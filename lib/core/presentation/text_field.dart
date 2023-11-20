import 'package:flutter/material.dart';

class TextFieldItem extends StatefulWidget {
  final TextEditingController controller;
  final String formName;
  final bool canHidePassword;

  const TextFieldItem(
      {super.key,
        required this.controller,
        required this.formName,
        required this.canHidePassword});

  @override
  State<TextFieldItem> createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  late bool passwordObscured;

  @override
  void initState() {
    super.initState();
    passwordObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
      child: TextFormField(
        maxLength: 14,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        controller: widget.controller,
        validator: (val) {
          if (val!.isEmpty) {
            return 'поле не может быть пустым';
          }
          return null;
        },
        obscureText: widget.canHidePassword ? passwordObscured : false,
        decoration: InputDecoration(
          counterText: '',
          counterStyle: const TextStyle(fontSize: 0),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide:
              BorderSide(color: Colors.blue)),
          labelText: widget.formName,
          suffixIcon: widget.canHidePassword
              ? MaterialButton(
            shape: const CircleBorder(),
            onPressed: () {
              setState(() {
                passwordObscured = !passwordObscured;
              });
            },
            child: Icon(Icons.remove_red_eye),
          )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
