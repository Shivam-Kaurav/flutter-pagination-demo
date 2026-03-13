import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_development/features/leads/core/isolates/json_parser.dart';
import 'package:new_development/features/leads/models/lead_model.dart';

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Leads>> fetchLeads(int page, int limit) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json", "User-Agent": "Mozilla/5.0"},
    );

    if (response.statusCode == 200) {
      //parse json in background isolate
      final List<Leads> allLeads = await compute(parseLeads, response.body);

      int start = (page - 1) * limit;
      int end = start + limit;

      if (start >= allLeads.length) return [];
      return allLeads.sublist(
        start,
        end > allLeads.length ? allLeads.length : end,
      );
    }
    throw Exception('Api error');
  }
}
