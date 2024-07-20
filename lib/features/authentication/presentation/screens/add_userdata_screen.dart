import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_exporter/features/authentication/presentation/widgets/custom_text_field.dart';

class AddUserdataScreen extends StatefulWidget {
  const AddUserdataScreen({super.key});

  @override
  State<AddUserdataScreen> createState() => _AddUserdataScreenState();
}

class _AddUserdataScreenState extends State<AddUserdataScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller_username = TextEditingController();
  TextEditingController _controller_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.go("/authentications"),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              hintText: "Username",
              controller: _controller_username,
            ),
            CustomTextField(
              hintText: "Password",
              controller: _controller_password,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Hinzufügen"),
            ),
          ],
        ),
      ),
    );
  }
}
