import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_exporter/features/project/presentation/widgets/project_form.dart';
import 'package:google_exporter/features/project/presentation/widgets/project_list.dart';

class ProjectOverviewScreen extends StatelessWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ProjectList(),
          ),
          ProjectForm(),

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
