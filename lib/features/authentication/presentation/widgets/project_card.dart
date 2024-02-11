import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:row_item/row_item.dart';

import '/shared/domain/providers/current_project_model_provider.dart';

class ProjectCard extends ConsumerWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currentProjectProvider);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            RowItem.text("Projekt-ID: ", state.project?.id.toString() ?? "-"),
            RowItem.text(
                "Projektname: ", state.project?.name.toString() ?? "-"),
            RowItem.text(
                "Projekt-Pfad: ", state.project?.path.toString() ?? "-"),
          ],
        ),
      ),
    );
  }
}
