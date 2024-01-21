import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProjectOverviewScreen extends StatelessWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              // Logik zum Erstellen eines neuen Projekts
              await saveFile();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              backgroundColor:
                  Theme.of(context).primaryColor, // Textfarbe des Buttons
            ),
            child: const Text('Neues Projekt erstellen'),
          ),
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

  Future<Directory> saveFile() async {
    // Logik zum Speichern einer Datei
    final result = await FilePicker.platform.saveFile(
      dialogTitle: 'Speichern',
      type: FileType.custom,
      allowedExtensions: ['db'],
      lockParentWindow: true,
    );
    debugPrint('Result: $result');
    return Directory(result!);
  }
}
