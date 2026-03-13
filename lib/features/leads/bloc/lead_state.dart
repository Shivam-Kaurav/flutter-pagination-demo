part of 'lead_bloc.dart';

@immutable
sealed class LeadState {}

final class LeadInitial extends LeadState {}

final class LeadLoading extends LeadState {}

final class LeadLoaded extends LeadState {
  final List<Leads> leads;
  final bool hasMore;

  LeadLoaded({required this.leads, required this.hasMore});
}

final class LeadError extends LeadState {
  final String message;

  LeadError({required this.message});
}
