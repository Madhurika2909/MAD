import 'package:flutter/material.dart';

class AcademicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Academic Calendar'),
      ),
      body: Center(
        child: Text('Academic Calendar Content Here'),
      ),
    );
  }
}
