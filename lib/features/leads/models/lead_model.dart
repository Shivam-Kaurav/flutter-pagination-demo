class Leads {
  final int id;
  final String title;
  final String body;

  Leads({required this.id, required this.title, required this.body});

  factory Leads.fromJson(Map<String, dynamic> json) {
    return Leads(id: json['id'], title: json['title'], body: json['body']);
  }
}
