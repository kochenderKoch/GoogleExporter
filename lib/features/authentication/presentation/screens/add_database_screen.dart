import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_text_field.dart';

// import 'package:path_provider/path_provider.dart';

/// Screen that shows an example of openFile
class AddDatabaseScreen extends StatefulWidget {
  /// Default Constructor
  AddDatabaseScreen({super.key});

  @override
  State<AddDatabaseScreen> createState() => _AddDatabaseScreenState();
}

class _AddDatabaseScreenState extends State<AddDatabaseScreen> {
  Future<void> _openTextFile(BuildContext context) async {
    const XTypeGroup typeGroup = XTypeGroup(
      label: 'database',
      extensions: <String>['db', 'sqlite'],
    );

    final XFile? file = await openFile(
      acceptedTypeGroups: <XTypeGroup>[typeGroup],
    );
    if (file == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomTextField(
              width: 1000,
              readOnly: true,
              controller: TextEditingController(),
              uploadingField: true,
              uploadFunc: () => _openTextFile(context),
              disabled: false,
              hintText: "authProvider.file?.path",
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // ElevatedButton.icon(
          //   style: const ButtonStyle(
          //       padding: MaterialStatePropertyAll(EdgeInsets.all(12.0))),
          //   onPressed: () {},
          //   icon: const Icon(Icons.wifi_protected_setup),
          //   label: const Text("Parsen"),
          // ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.0),
              child: Text(
                "Accounts: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => ListTile(
                leading: Text(
                  "authProvider.database.accounts[index].iId.toString()",
                ),
                title: Text(
                    "authProvider.database.accounts[index].name.toString()"),
                subtitle: SelectableText(
                  "authProvider.database.accounts[index].password.toString()",
                  style: const TextStyle(fontSize: 10),
                ),
                trailing: Text(
                    "authProvider.database.accounts[index].type.toString()"),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.0),
              child: Text(
                "AuthTokens: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => ListTile(
                leading: Text(
                  "authProvider.database.authTokens[index].iId.toString()",
                ),
                title: SelectableText(
                    "authProvider.database.authTokens[index].type.toString()"),
                subtitle: SelectableText(
                  "authProvider.database.authTokens[index].authtoken.toString()",
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
