import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/presentation/widgets/project_form.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/domain/providers/current_project_model_provider.dart';

class ProjectOverviewScreen extends ConsumerWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentProjectState = ref.watch(currentProjectProvider);
    final currentDatabase = ref.watch(dynamicDatabaseProvider);
    final currentProject =
        currentProjectState.project; // Dies gibt Ihnen das aktuelle Projekt
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Projekt: ${currentProject?.path}"),
          Text("Database: ${currentDatabase?.db.toString()}"),
          ElevatedButton(
              onPressed: () async {
                final isar = await currentDatabase?.db;
                await isar!.writeTxn(() async {
                  await isar.projects.put(Project(
                      name: "name",
                      identifier: "identifier",
                      processor: "processor",
                      path: "path"));
                });
              },
              child: Text("Add")),
          const ProjectForm(),
          const SizedBox(height: 16), // Leerraum zwischen den Buttons
          OutlinedButton(
            onPressed: () async {
              // Logik zum Laden eines bestehenden Projekts
              await pickFile();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ), // Randfarbe des Buttons
            ),
            child: const Text('Bestehendes Projekt laden'),
          ),
        ],
      ),
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
