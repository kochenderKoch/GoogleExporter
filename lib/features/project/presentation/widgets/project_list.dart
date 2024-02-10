import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/configs/app_configs.dart';
import 'package:google_exporter/features/project/presentation/provider/project_state_provider.dart';
import 'package:google_exporter/shared/domain/providers/current_project_model_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final stateCurrentProject = ref.watch(currentProjectProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: AppConfigs.DEFAULT_PADDING.toDouble(),
        ),
        Text(AppLocalizations.of(context).lastOpenedProjects),
        SizedBox(
          height: AppConfigs.DEFAULT_PADDING.toDouble(),
        ),
        Flexible(
          flex: 4,
          child: Scrollbar(
            controller: scrollController,
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              controller: scrollController,
              itemCount: state.projectList.length,
              itemBuilder: (context, index) {
                final project = state.projectList[index];
                return ListTile(
                  leading: stateCurrentProject.project?.id == project.id
                      ? Icon(Icons.check)
                      : TextButton(
                          onPressed: () {
                            notifier.setProject(project.id);
                          },
                          child: Text(AppLocalizations.of(context).loadProject),
                        ),
                  title: Text(
                      "${project.id} - ${project.identifier} - ${project.processor}"),
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
        Flexible(
          flex: 1,
          child: OutlinedButton(
            onPressed: () async {
              // Logik zum Laden eines bestehenden Projekts
              await pickFile();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ), // Randfarbe des Buttons
              padding: EdgeInsets.all(38.0),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              elevation: 10.0,
              alignment: Alignment.center,
              minimumSize: const Size(100, 100),
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            child: Text(AppLocalizations.of(context).existingProject),
          ),
        ),
      ],
    );
  }

  Future<void> pickFile() async {
    try {
      // Öffne den Dateiauswahldialog
      final result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // Wenn der Benutzer eine Datei auswählt und nicht abbricht
        final file = result.files.first;

        final dir = Directory(file.path!);

        debugPrint('Directory contents: ${dir.path}');
      } else {
        // Der Benutzer hat den Dialog abgebrochen
        debugPrint('No file selected');
      }
    } catch (e) {
      // Fehlerbehandlung
      debugPrint('An error occurred while picking the file: $e');
    }
  }
}
