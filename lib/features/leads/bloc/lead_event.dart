part of 'lead_bloc.dart';

@immutable
sealed class LeadEvent {}

class FetchLeads extends LeadEvent {}

class FetchMoreLeads extends LeadEvent {}
