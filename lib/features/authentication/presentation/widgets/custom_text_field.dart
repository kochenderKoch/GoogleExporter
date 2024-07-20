import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key,
      required this.controller,
      this.obscureText = false,
      this.uploadingField = false,
      this.tokenField = false,
      this.readOnly = false,
      this.uploadFunc,
      this.prefixIcon,
      this.hintText,
      this.onChangeFunc,
      this.valFunc,
      this.width = 450,
      this.disabled = false})
      : super(key: key);

  final TextEditingController controller;
  final bool obscureText;
  final bool uploadingField;
  final void Function()? uploadFunc;
  final bool tokenField;
  final void Function(String)? onChangeFunc;

  final Icon? prefixIcon;
  final String? hintText;
  final bool disabled;
  final String? Function(String?)? valFunc;
  final double width;

  final bool readOnly;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var _passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          readOnly: widget.readOnly,
          enabled: !widget.disabled,
          controller: widget.controller,
          onChanged: widget.onChangeFunc,
          obscureText: widget.obscureText ? _passwordVisibility : false,
          decoration: InputDecoration(
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(!_passwordVisibility
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  )
                : widget.uploadingField
                    ? ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.background),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.all(25)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 23, 21, 21))))),
                        onPressed: widget.uploadFunc,
                        child: Text(AppLocalizations.of(context).about))
                    : widget.tokenField
                        ? null
                        : null,
            prefixIcon: widget.prefixIcon,
            contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            hintText: widget.hintText,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.05),
            filled: true,
            errorStyle: const TextStyle(height: 0, color: Colors.red),
            hintStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xFF969A9D),
              fontWeight: FontWeight.w300,
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(width: .5)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(width: .5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(width: .5)),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(width: .5),
            ),
          ),
          validator: widget.valFunc,
          style: const TextStyle(
            fontSize: 16,
            //color: Color(0xFF3C3C43),
          ),
        ),
      ),
    );
  }
}
