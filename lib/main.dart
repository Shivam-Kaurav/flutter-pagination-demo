import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_development/features/auth/presentation/login_screen.dart';
import 'package:new_development/features/leads/presentation/bloc/lead_bloc.dart';
import 'package:new_development/features/leads/data/repository/lead_repository.dart';
import 'package:new_development/features/leads/presentation/screens/lead_list_screen.dart';
import 'package:new_development/features/leads/data/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadBloc(LeadRepository(ApiService())),
      child: MaterialApp(
        title: 'New Development',

        routes: {
          '/login': (context) => const LoginPage(),
          '/leads': (context) => const LeadListScreen(),
        },

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),

        home: const LoginPage(),
      ),
    );
  }
}
