// // import 'package:flutter/material.dart';

// // class AttendanceMarkingPage extends StatefulWidget {
// //   final String subject;
// //   final List<String> students;

// //   AttendanceMarkingPage({required this.subject, required this.students});

// //   @override
// //   _AttendanceMarkingPageState createState() => _AttendanceMarkingPageState();
// // }

// // class _AttendanceMarkingPageState extends State<AttendanceMarkingPage> {
// //   List<bool> _presentStatus = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Initialize the present status list with false (absent) for all students
// //     _presentStatus = List<bool>.generate(widget.students.length, (index) => false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Mark Attendance - ${widget.subject}'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: widget.students.length,
// //         itemBuilder: (context, index) {
// //           return ListTile(
// //             title: Text(widget.students[index]),
// //             subtitle: Text('Roll No: ${index + 1}'),
// //             trailing: Checkbox(
// //               value: _presentStatus[index],
// //               onChanged: (value) {
// //                 setState(() {
// //                   // Ensure only one checkbox is selected
// //                   _presentStatus = List<bool>.generate(widget.students.length, (i) => false);
// //                   _presentStatus[index] = value!;
// //                 });
// //               },
// //             ),
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           // Process attendance here (save to database, etc.)
// //           Navigator.pop(context); // Return to previous screen after marking attendance
// //         },
// //         child: Icon(Icons.save),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';

// class AttendanceMarkingPage extends StatefulWidget {
//   final String subject;
//   final List<String> students;

//   AttendanceMarkingPage({required this.subject, required this.students});

//   @override
//   _AttendanceMarkingPageState createState() => _AttendanceMarkingPageState();
// }

// class _AttendanceMarkingPageState extends State<AttendanceMarkingPage> {
//   List<bool> _presentStatus = [];

//   @override
//   void initState() {
//     super.initState();
//     // Initialize _presentStatus list with false values (all students absent initially)
//     _presentStatus = List<bool>.filled(widget.students.length, false);
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
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildHeading('Student Name', Colors.black),
//                 _buildHeading('Present', Colors.green),
//                 _buildHeading('Absent', Colors.red),
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

//   Widget _buildHeading(String text, Color color) {
//     return Container(
//       alignment: Alignment.center,
//       padding: EdgeInsets.symmetric(vertical: 8.0),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         border: Border.all(color: color.withOpacity(0.5)),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(fontWeight: FontWeight.bold, color: color),
//       ),
//     );
//   }

//   Widget _buildStudentAttendanceRow(String studentName, int index) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(studentName),
//           Checkbox(
//             value: _presentStatus[index],
//             onChanged: (value) {
//               setState(() {
//                 // Only one checkbox can be selected, update all to false initially
//                 _presentStatus = List<bool>.filled(widget.students.length, false);
//                 // Set the selected index to true
//                 _presentStatus[index] = value!;
//               });
//             },
//             activeColor: Colors.green,
//           ),
//           Checkbox(
//             value: !_presentStatus[index], // opposite of present status
//             onChanged: (value) {
//               setState(() {
//                 // Only one checkbox can be selected, update all to false initially
//                 _presentStatus = List<bool>.filled(widget.students.length, false);
//                 // Set the selected index to true for absent
//                 _presentStatus[index] = !value!;
//               });
//             },
//             activeColor: Colors.red,
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
                _buildHeading('Student Name'),
                _buildHeading('Present'),
                _buildHeading('Absent'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.students.length,
              itemBuilder: (context, index) {
                return _buildStudentAttendanceRow(
                    widget.students[index], index);
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

  Widget _buildHeading(String text) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
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
                // Reset all statuses to null
                _presentStatus =
                    List<bool?>.filled(widget.students.length, null);
                // Set the selected index to true for present
                _presentStatus[index] = value!;
              });
            },
          ),
          Checkbox(
            value: _presentStatus[index] == false,
            onChanged: (value) {
              setState(() {
                // Reset all statuses to null
                _presentStatus =
                    List<bool?>.filled(widget.students.length, null);
                // Set the selected index to false for absent
                _presentStatus[index] = !value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
