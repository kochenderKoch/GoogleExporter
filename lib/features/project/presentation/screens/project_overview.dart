import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/presentation/widgets/project_form.dart';

class ProjectOverviewScreen extends ConsumerWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dies gibt Ihnen das aktuelle Projekt
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Card(child: const ProjectForm()),
        ],
      ),
    );
  }
}
