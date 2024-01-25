import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/presentation/provider/project_state_provider.dart';

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
    return Scrollbar(
      controller: scrollController,
      child: ListView.separated(
        separatorBuilder: (_, __) => const Divider(),
        controller: scrollController,
        itemCount: state.projectList.length,
        itemBuilder: (context, index) {
          final project = state.projectList[index];
          return ListTile(
              title: Text("${project.name} - ${project.identifier} - ${project.processor}"),
              subtitle: Text(
                project.path,
              ));
        },
      ),
    );
  }
}
