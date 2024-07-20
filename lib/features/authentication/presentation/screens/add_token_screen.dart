import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_exporter/features/authentication/presentation/widgets/custom_text_field.dart';

class AddTokenScreen extends StatefulWidget {
  const AddTokenScreen({super.key});

  @override
  State<AddTokenScreen> createState() => _AddTokenScreenState();
}

class _AddTokenScreenState extends State<AddTokenScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _controller_token = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.go("/authentications");
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(controller: _controller_token),
          ],
        ),
      ),
    );
  }
}
