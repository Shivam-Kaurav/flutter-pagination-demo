import 'package:new_development/features/leads/data/models/lead_model.dart';
import 'package:new_development/features/leads/data/api_service.dart';

class LeadRepository {
  final ApiService apiService;
  LeadRepository(this.apiService);

  Future<List<Leads>> fetchLeads(int page, int limit) {
    return apiService.fetchLeads(page, limit);
  }
}
