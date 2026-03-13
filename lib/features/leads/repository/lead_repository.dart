import 'package:new_development/features/leads/models/lead_model.dart';
import 'package:new_development/features/leads/services/api_service.dart';

class LeadRepository {
  final ApiService apiService;
  LeadRepository(this.apiService);

  Future<List<Leads>> fetchLeads(int page, int limit) {
    return apiService.fetchLeads(page, limit);
  }
}
