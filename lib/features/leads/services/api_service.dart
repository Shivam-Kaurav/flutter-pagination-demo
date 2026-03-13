import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_development/features/leads/models/lead_model.dart';

class ApiService {
  static const String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Leads>> fetchLeads(int page, int limit) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json", "User-Agent": "Mozilla/5.0"},
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);

      int start = (page - 1) * limit;
      int end = start + limit;

      if (start >= data.length) return [];
      final paginatedData = data.sublist(
        start,
        end > data.length ? data.length : end,
      );
      return paginatedData.map((e) => Leads.fromJson(e)).toList();
    }
    throw Exception('Api error');
  }
}
