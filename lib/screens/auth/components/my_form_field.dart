import 'package:flutter/material.dart';

class MyCustomForm extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final String? errorText;
  final String? Function(String?) validator;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final void Function(String?)? onchanged;
  final TextInputType? keyboardType;

  const MyCustomForm(
      {super.key,
      required this.hintText,
      required this.textEditingController,
      required this.errorText,
      required this.validator,
      required this.prefixIcon,
      this.obscureText = false,
      this.suffixIcon,
      this.onchanged,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
              controller: textEditingController,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: onchanged,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black38)),
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  hintText: hintText,
                  errorText: errorText),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator),
        ));
  }
}
