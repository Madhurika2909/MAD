import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceTeacher extends StatefulWidget {
  final DocumentSnapshot course;

  AttendanceTeacher({required this.course});

  @override
  _AttendanceTeacherState createState() => _AttendanceTeacherState();
}

class _AttendanceTeacherState extends State<AttendanceTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Attendance for ${widget.course['courseName']}'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Students')
            .where('courses', arrayContains: widget.course['courseCode'])
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
              bool isChecked = student['attendances']
                      ?.contains(widget.course['courseCode']) ??
                  false;
              return ListTile(
                title: Text(student['name']),
                subtitle: Text(student['email']),
                trailing: Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    if (value != null) {
                      FirebaseFirestore.instance
                          .runTransaction((transaction) async {
                        DocumentSnapshot freshSnap =
                            await transaction.get(student.reference);
                        List<dynamic> attendances =
                            freshSnap['attendances'] ?? [];
                        if (value) {
                          attendances.add(widget.course['courseCode']);
                        } else {
                          attendances.remove(widget.course['courseCode']);
                        }
                        transaction.update(
                            student.reference, {'attendances': attendances});
                      });
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
