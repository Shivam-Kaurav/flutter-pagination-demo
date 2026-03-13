import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_development/features/leads/bloc/lead_bloc.dart';
import 'package:new_development/features/leads/repository/lead_repository.dart';
import 'package:new_development/features/leads/screens/lead_list_screen.dart';
import 'package:new_development/features/leads/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'New Development',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => LeadBloc(LeadRepository(ApiService())),
        child: const LeadListScreen(),
      ),
    );
  }
}
