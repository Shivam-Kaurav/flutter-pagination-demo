import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_development/features/leads/models/lead_model.dart';
import 'package:new_development/features/leads/repository/lead_repository.dart';

part 'lead_event.dart';
part 'lead_state.dart';

class LeadBloc extends Bloc<LeadEvent, LeadState> {
  final LeadRepository leadRepository;

  int page = 1;
  final int limit = 10;

  List<Leads> leads = [];

  bool hasMore = true;
  bool isFetching = false;

  LeadBloc(this.leadRepository) : super(LeadInitial()) {
    /// FIRST LOAD
    on<FetchLeads>((event, emit) async {
      emit(LeadLoading());

      page = 1;
      leads.clear();
      hasMore = true;

      try {
        final newLeads = await leadRepository.fetchLeads(page, limit);

        if (newLeads.isEmpty) {
          hasMore = false;
        } else {
          leads.addAll(newLeads);
          page++;
        }

        emit(LeadLoaded(leads: leads, hasMore: hasMore));
      } catch (e) {
        emit(LeadError(message: e.toString()));
      }
    });

    /// PAGINATION
    on<FetchMoreLeads>((event, emit) async {
      if (!hasMore || isFetching) return;

      isFetching = true;

      try {
        final newLeads = await leadRepository.fetchLeads(page, limit);

        if (newLeads.isEmpty) {
          hasMore = false;
        } else {
          leads.addAll(newLeads);
          page++;
        }

        emit(LeadLoaded(leads: leads, hasMore: hasMore));
      } catch (e) {
        emit(LeadError(message: e.toString()));
      }

      isFetching = false;
    });
  }
}
