

import 'package:flutter/material.dart';
import 'attendance_marking_page.dart'; // Import your AttendanceMarkingPage widget

class AttendanceTeacher extends StatefulWidget {
  @override
  _AttendanceTeacherState createState() => _AttendanceTeacherState();
}

class _AttendanceTeacherState extends State<AttendanceTeacher> {
  String _selectedDay = '';
  String _hoveredDay = '';
  Map<String, List<Map<String, String>>> _classSchedule = {
    'Monday': [
      {'subject': 'TFC-4F', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'COA-4B', 'time': '10:00 AM - 11:30 AM'},
      {'subject': 'DSA-4C', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'PYTHON-4A', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Tuesday': [
      {'subject': 'DSA-4C', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'JAVA-4D', 'time': '10:00 AM - 11:00 AM'},
      {'subject': 'PYTHON-4A', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'TFC-4F', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Wednesday': [
      {'subject': 'Introduction to Computer Science-4C', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'COA-4A', 'time': '10:00 AM - 11:30 AM'},
      {'subject': 'Advanced Mathematics-4B', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'PYTHON-4D', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Thursday': [
      {'subject': 'TFC-4D', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'Advanced Mathematics-4E', 'time': '10:00 AM - 12:00 PM'},
      {'subject': 'PYTHON-4D', 'time': '12:00 PM - 1:00 PM'},
    ],
    'Friday': [
      {'subject': 'Advanced Mathematics-4E', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'Introduction to Computer Science-4F', 'time': '10:00 AM - 11:30 AM'},
      {'subject': 'DSA-4A', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'JAVA-4C', 'time': '2:00 PM - 3:00 PM'},
    ],
    // Add schedules for other days...
  };

  // Sample student list, replace with actual student data
  List<String> _students = [
    'Student 1',
    'Student 2',
    'Student 3',
    'Student 4',
    // Add more students as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
                  .map((day) => _buildDayButton(day))
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: _selectedDay.isNotEmpty
                  ? _classSchedule[_selectedDay]!
                      .map((classInfo) => _buildClassInfoCard(classInfo))
                      .toList()
                  : [Center(child: Text('Select a day to view classes'))],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayButton(String day) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredDay = day),
      onExit: (_) => setState(() => _hoveredDay = ''),
      child: InkWell(
        onTap: () => setState(() => _selectedDay = day),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          decoration: BoxDecoration(
            color: _selectedDay == day
                ? Colors.blue
                : (_hoveredDay == day ? Color.fromARGB(255, 25, 4, 77) : Colors.lightBlue),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            day,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildClassInfoCard(Map<String, String> classInfo) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            classInfo['subject']!,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.0),
          Text(
            classInfo['time']!,
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceMarkingPage(subject: classInfo['subject']!, students: _students),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              backgroundColor: Colors.blue,
            ),
            child: Text('Take Attendance'),
          ),
        ],
      ),
    );
  }
}
