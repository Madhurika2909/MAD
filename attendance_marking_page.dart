
// import 'package:flutter/material.dart';

// class AttendanceMarkingPage extends StatefulWidget {
//   final String subject;
//   final List<String> students;

//   AttendanceMarkingPage({required this.subject, required this.students});

//   @override
//   _AttendanceMarkingPageState createState() => _AttendanceMarkingPageState();
// }

// class _AttendanceMarkingPageState extends State<AttendanceMarkingPage> {
//   List<bool?> _presentStatus = []; // Changed to allow null for initial state

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _presentStatus list with null values (neither present nor absent initially)
//     _presentStatus = List<bool?>.filled(widget.students.length, null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mark Attendance - ${widget.subject}'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildHeading('Student Name'),
//                 _buildHeading('Present'),
//                 _buildHeading('Absent'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.students.length,
//               itemBuilder: (context, index) {
//                 return _buildStudentAttendanceRow(widget.students[index], index);
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Implement your logic to save the attendance data
//               // For demo, print the selected status
//               print('Attendance Status: $_presentStatus');
//               Navigator.pop(context); // Go back to previous screen
//             },
//             child: Text('Save Attendance'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeading(String text) {
//     return Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.blueGrey.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildStudentAttendanceRow(String studentName, int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(studentName),
//           Checkbox(
//             value: _presentStatus[index] == true,
//             onChanged: (value) {
//               setState(() {
//                 if (value == true) {
//                   _presentStatus[index] = true;
//                 }
//               });
//             },
//           ),
//           Checkbox(
//             value: _presentStatus[index] == false,
//             onChanged: (value) {
//               setState(() {
//                 if (value == true) {
//                   _presentStatus[index] = false;
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AttendanceMarkingPage extends StatefulWidget {
  final String subject;
  final List<String> students;

  AttendanceMarkingPage({required this.subject, required this.students});

  @override
  _AttendanceMarkingPageState createState() => _AttendanceMarkingPageState();
}

class _AttendanceMarkingPageState extends State<AttendanceMarkingPage> {
  List<bool?> _presentStatus = []; // Changed to allow null for initial state

  @override
  void initState() {
    super.initState();
    // Initialize _presentStatus list with null values (neither present nor absent initially)
    _presentStatus = List<bool?>.filled(widget.students.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance - ${widget.subject}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeading('Student Name', backgroundColor: Colors.blue),
                _buildHeading('Present', color: Colors.green),
                _buildHeading('Absent', color: Colors.red),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                return _buildStudentAttendanceRow(widget.students[index], index);
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement your logic to save the attendance data
              // For demo, print the selected status
              print('Attendance Status: $_presentStatus');
              Navigator.pop(context); // Go back to previous screen
            },
            child: Text('Save Attendance'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeading(String text, {Color color = Colors.black, Color backgroundColor = Colors.blueGrey}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget _buildStudentAttendanceRow(String studentName, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(studentName),
          Checkbox(
            value: _presentStatus[index] == true,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _presentStatus[index] = true;
                }
              });
            },
          ),
          Checkbox(
            value: _presentStatus[index] == false,
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  _presentStatus[index] = false;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

