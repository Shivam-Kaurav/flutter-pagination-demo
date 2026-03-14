import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_development/core/isolates/json_parser.dart';
import 'package:new_development/core/network/dio_client.dart';
import 'package:new_development/features/leads/data/models/lead_model.dart';

class ApiService {
  //api call using dio
  final Dio dio = DioClient().dio;

  Future<List<Leads>> fetchLeads(int page, int limit) async {
    try {
      final response = await dio.get('/posts');

      if (response.statusCode == 200) {
        //convert response to string for isolate
        final String jsonString = jsonEncode(response.data);
        //parse json in background isolate
        final List<Leads> allLeads = await compute(parseLeads, jsonString);

        //pagination
        int start = (page - 1) * limit;
        int end = start + limit;

        if (start >= allLeads.length) return [];
        return allLeads.sublist(
          start,
          end > allLeads.length ? allLeads.length : end,
        );
      }
      throw Exception("API error: ${response.statusCode}");
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
