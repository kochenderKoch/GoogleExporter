import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/configs/app_configs.dart';
import '/features/project/presentation/provider/project_state_provider.dart';
import '/shared/domain/models/projects/project_model.dart';
import '/shared/helper/validation.dart';

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
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).caseNumber),
              controller: caseNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context).caseNumberEmpty;
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).evidenceNumber),
              controller: identificationNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context).evidenceNumberEmpty;
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).processor),
              controller: processorController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context).processorEmpty;
                }
                return null;
              },
            ),
            SizedBox(
              height: AppConfigs.DEFAULT_PADDING.toDouble(),
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).description),
              controller: descriptionController,
              maxLines: 3,
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
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).savePath),
                    controller: locationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context).savePathEmpty;
                      }
                      if (validateAndCompletePath(value).isLeft()) {
                        return AppLocalizations.of(context).savePathInvalid;
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
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).secondaryHeaderColor),
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
              child: Text(AppLocalizations.of(context).saveProject),
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
