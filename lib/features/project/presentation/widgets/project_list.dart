import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/configs/app_configs.dart';
import 'package:google_exporter/features/project/presentation/provider/project_state_provider.dart';
import 'package:google_exporter/shared/domain/providers/current_project_model_provider.dart';

class ProjectList extends ConsumerStatefulWidget {
  const ProjectList({super.key});

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends ConsumerState<ProjectList> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(projectNotifierProvider);
    final notifier = ref.read(currentProjectProvider.notifier);
    return Column(
      children: [
        SizedBox(
          height: AppConfigs.DEFAULT_PADDING.toDouble(),
        ),
        Text("Zuletzt geöffnete Projekte"),
        SizedBox(
          height: AppConfigs.DEFAULT_PADDING.toDouble(),
        ),
        Expanded(
          child: Scrollbar(
            controller: scrollController,
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              controller: scrollController,
              itemCount: state.projectList.length,
              itemBuilder: (context, index) {
                final project = state.projectList[index];
                return ListTile(
                  leading: TextButton(
                    onPressed: () {
                      notifier.setProject(project.id!);
                    },
                    child: const Text("Projekt laden"),
                  ),
                  title: Text(
                      "${project.name} - ${project.identifier} - ${project.processor}"),
                  subtitle: Text(
                    project.path,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
