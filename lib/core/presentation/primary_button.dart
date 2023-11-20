import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;

  const PrimaryButton(
      {super.key, required this.onTap, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: MaterialButton(
        padding:
        const EdgeInsets.only(right: 20, left: 16, top: 10, bottom: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        minWidth: MediaQuery.of(context).size.width,
        elevation: 0,
        onPressed: () {
          onTap();
        },
        color: Colors.blue[900],
        child: Text(
          buttonName,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white),
        ),
      ),
    );
  }
}
