import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Colors.blue, // Set app bar color to blue
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          DataTable(
            columns: [
              DataColumn(label: Text('Sl No.')),
              DataColumn(label: Text('Course Code')),
              DataColumn(label: Text('Course Name')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1')),
                DataCell(Text('CS101')),
                DataCell(Text('Introduction to Computer Science')),
              ]),
              DataRow(cells: [
                DataCell(Text('2')),
                DataCell(Text('MATH201')),
                DataCell(Text('Advanced Mathematics')),
              ]),
              DataRow(cells: [
                DataCell(Text('3')),
                DataCell(Text('CS301')),
                DataCell(Text('TFCS')),
              ]),
              DataRow(cells: [
                DataCell(Text('4')),
                DataCell(Text('CS401')),
                DataCell(Text('COA')),
              ]),
              DataRow(cells: [
                DataCell(Text('5')),
                DataCell(Text('CS01')),
                DataCell(Text('JAVA')),
              ]),
              DataRow(cells: [
                DataCell(Text('6')),
                DataCell(Text('CS601')),
                DataCell(Text('PYTHON')),
              ]),
              DataRow(cells: [
                DataCell(Text('7')),
                DataCell(Text('CS701')),
                DataCell(Text('DSA')),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}