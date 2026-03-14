import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_development/features/leads/presentation/bloc/lead_bloc.dart';
import 'package:new_development/features/leads/presentation/widgets/lead_card.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});
  @override
  State<StatefulWidget> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<LeadBloc>().add(FetchLeads());
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        context.read<LeadBloc>().add(FetchMoreLeads());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leads')),
      body: BlocBuilder<LeadBloc, LeadState>(
        builder: (context, state) {
          if (state is LeadLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            );
          }
          if (state is LeadLoaded) {
            return ListView.builder(
              controller: controller,
              itemCount: state.hasMore
                  ? state.leads.length + 1
                  : state.leads.length,
              itemBuilder: (context, index) {
                if (index < state.leads.length) {
                  var lead = state.leads[index];
                  return LeadCard(lead: lead);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    ),
                  );
                }
              },
            );
          }
          if (state is LeadError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Error loading leads"));
        },
      ),
    );
  }
}
