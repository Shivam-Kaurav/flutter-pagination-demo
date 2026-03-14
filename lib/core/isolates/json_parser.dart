import 'dart:convert';
import 'package:new_development/features/leads/data/models/lead_model.dart';

List<Leads> parseLeads(String responseBody) {
  final decoded = jsonDecode(responseBody) as List;

  return decoded.map<Leads>((json) => Leads.fromJson(json)).toList();
}
