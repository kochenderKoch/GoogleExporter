import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/configs/app_configs.dart';
import 'package:google_exporter/features/project/presentation/provider/project_state_provider.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/helper/validation.dart';

class ProjectForm extends ConsumerStatefulWidget {
  const ProjectForm({super.key});

  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends ConsumerState<ProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController caseNumberController = TextEditingController(text: "");
  TextEditingController identificationNumberController =
      TextEditingController(text: "");
  TextEditingController processorController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController locationController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          shrinkWrap: true,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Fallnummer'),
              controller: caseNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte Fallnummer eingeben';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Identifier'),
              controller: identificationNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte Identifier eingeben';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Processor'),
              controller: processorController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bitte Bearbeiter eingeben';
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              controller: descriptionController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Location'),
                    controller: locationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte Speicherort auswählen';
                      }
                      if (validateAndCompletePath(value).isLeft()) {
                        return 'Pfad ungültig';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.upload),
                  onPressed: () {
                    saveFile();
                  },
                )
              ],
            ),
            SizedBox(
              height: 4 * AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Logik zum Speichern der Projektinformationen
                  ref.read(projectNotifierProvider.notifier).addProject(Project(
                        name: caseNumberController.text,
                        identifier: identificationNumberController.text,
                        processor: processorController.text,
                        description: descriptionController.text,
                        path: locationController.text,
                      ));
                }
              },
              child: Text('Projekt speichern'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Directory> saveFile() async {
    // Logik zum Speichern einer Datei
    try {
      final result = await FilePicker.platform.saveFile(
        dialogTitle: 'Speichern',
        type: FileType.custom,
        allowedExtensions: ['db'],
        lockParentWindow: true,
      );
      debugPrint('Result: $result');

      if (result != null) {
        // Wenn der Benutzer eine Datei auswählt und nicht abbricht
        final dir = Directory(result);

        debugPrint('Directory contents: ${dir.path}');
        locationController.text = result + ".db";
        return Directory(result);
      } else {
        // Der Benutzer hat den Dialog abgebrochen
        debugPrint('No file selected');
      }
    } catch (e) {
      // Fehlerbehandlung
      debugPrint('An error occurred while picking the file: $e');
    }
    return Directory('./default.db');
  }
}
