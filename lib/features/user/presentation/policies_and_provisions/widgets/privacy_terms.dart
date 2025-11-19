import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyTerms extends StatelessWidget {
  const PrivacyTerms({Key? key}) : super(key: key);

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
          'شروط الخصوصية',
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Text('شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                'شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                'شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                'شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                'شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                'شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية شروط وخصوصية '
                ''),
          ],
        ),
      ),
    );
  }
}
