import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendancePage extends StatelessWidget {
  final String courseCode;

  StudentAttendancePage({required this.courseCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Attendance for $courseCode'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Students')
            .where('courseCode', isEqualTo: courseCode)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var students = snapshot.data!.docs;

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              var student = students[index];
              return ListTile(
                title: Text(student['name']),
                subtitle: Text(student['email']),
                trailing: Text(
                    student['attendances']?.contains(courseCode) ?? false
                        ? 'Present'
                        : 'Absent'),
              );
            },
          );
        },
      ),
    );
  }
}
