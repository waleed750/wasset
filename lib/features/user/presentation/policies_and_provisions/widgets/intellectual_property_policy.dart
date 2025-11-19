import 'package:flutter/material.dart';

class IntellectualPropertyPolicy extends StatelessWidget {
  const IntellectualPropertyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: const Text(
          'سياسة الملكية الفكرية',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(25),
        child: Column(),
      ),
    );
  }
}
