// import 'package:flutter/material.dart';

// class AttendancePage extends StatefulWidget {
//   @override
//   _AttendancePageState createState() => _AttendancePageState();
// }

// class _AttendancePageState extends State<AttendancePage> {
//   String _selectedDay = '';
//   String _hoveredDay='';
//   Map<String, List<Map<String, String>>> _classSchedule = {
//     'Monday': [
//       {'subject': 'TFC', 'time': '9:00 AM - 10:00 AM'},
//       {'subject': 'COA', 'time': '10:00 AM - 11:30 AM'},
//       {'subject': 'DSA', 'time': '12:00 AM - 1:00 AM'},
//       {'subject': 'PYTHON', 'time': '2:00 AM - 3:00 AM'},
//     ],
//     'Tuesday': [
//       {'subject': 'DSA', 'time': '9:00 AM - 10:00 AM'},
//       {'subject': 'JAVA', 'time': '10:00 AM - 11:00 AM'},
//       {'subject': 'PYTHON', 'time': '12:00 AM - 1:00 AM'},
//       {'subject': 'TFC', 'time': '2:00 AM - 3:00 AM'},
//     ],
//     'Wednesday': [
//       {'subject': 'Introduction to Computer Science', 'time': '9:00 AM - 10:00 AM'},
//       {'subject': 'COA', 'time': '10:00 AM - 11:30 AM'},
//       {'subject': 'Advanced Mathematics', 'time': '12:00 AM - 1:00 AM'},
//       {'subject': 'PYTHON', 'time': '2:00 AM - 3:00 AM'},
//     ],
//     'Thursday': [
//       {'subject': 'TFC', 'time': '9:00 AM - 10:00 AM'},
//       {'subject': 'Advanced Mathematics', 'time': '10:00 AM - 12:00 AM'},
//       {'subject': 'PYTHON', 'time': '12:00 AM - 1:00 AM'},
//     ],
//     'Friday': [
//       {'subject': 'Advanced Mathematics', 'time': '9:00 AM - 10:00 AM'},
//       {'subject': 'Introduction to Computer Science', 'time': '10:00 AM - 11:30 AM'},
//       {'subject': 'DSA', 'time': '12:00 AM - 1:00 AM'},
//       {'subject': 'JAVA', 'time': '2:00 AM - 3:00 AM'},
//     ],
//     // Add schedules for other days...
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance'),
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.0),
//             color: Colors.lightBlue,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
//                   .map((day) => _buildDayButton(day))
//                   .toList(),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(16.0),
//               children: _selectedDay.isNotEmpty
//                   ? _classSchedule[_selectedDay]!
//                       .map((classInfo) => _buildClassInfoCard(classInfo))
//                       .toList()
//                   : [Center(child: Text('Select a day to view classes'))],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDayButton(String day) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _hoveredDay = day),
//       onExit: (_) => setState(() => _hoveredDay = ''),
//       child: InkWell(
//         onTap: () => setState(() => _selectedDay = day),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
//           decoration: BoxDecoration(
//             color: _selectedDay == day ? Colors.blue : (_hoveredDay == day ? Color.fromARGB(255, 25, 4, 77) : Colors.lightBlue),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Text(
//             day,
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildClassInfoCard(Map<String, String> classInfo) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8.0),
//       padding: EdgeInsets.all(12.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 4.0,
//             offset: Offset(2, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             classInfo['subject']!,
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 4.0),
//           Text(
//             classInfo['time']!,
//             style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String _selectedDay = '';
  String _hoveredDay = '';
  Map<String, List<Map<String, String>>> _classSchedule = {
    'Monday': [
      {'subject': 'TFC', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'COA', 'time': '10:00 AM - 11:30 AM'},
      {'subject': 'DSA', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'PYTHON', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Tuesday': [
      {'subject': 'DSA', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'JAVA', 'time': '10:00 AM - 11:00 AM'},
      {'subject': 'PYTHON', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'TFC', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Wednesday': [
      {
        'subject': 'Introduction to Computer Science',
        'time': '9:00 AM - 10:00 AM'
      },
      {'subject': 'COA', 'time': '10:00 AM - 11:30 AM'},
      {'subject': 'Advanced Mathematics', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'PYTHON', 'time': '2:00 PM - 3:00 PM'},
    ],
    'Thursday': [
      {'subject': 'TFC', 'time': '9:00 AM - 10:00 AM'},
      {'subject': 'Advanced Mathematics', 'time': '10:00 AM - 12:00 PM'},
      {'subject': 'PYTHON', 'time': '12:00 PM - 1:00 PM'},
    ],
    'Friday': [
      {'subject': 'Advanced Mathematics', 'time': '9:00 AM - 10:00 AM'},
      {
        'subject': 'Introduction to Computer Science',
        'time': '10:00 AM - 11:30 AM'
      },
      {'subject': 'DSA', 'time': '12:00 PM - 1:00 PM'},
      {'subject': 'JAVA', 'time': '2:00 PM - 3:00 PM'},
    ],
    // Add schedules for other days...
  };

  // Example simulated attendance data
  Map<String, Map<String, dynamic>> _attendanceData = {
    'TFC': {'totalClasses': 20, 'daysPresent': 15},
    'COA': {'totalClasses': 18, 'daysPresent': 16},
    'DSA': {'totalClasses': 22, 'daysPresent': 17},
    'PYTHON': {'totalClasses': 21, 'daysPresent': 14},
    'JAVA': {'totalClasses': 19, 'daysPresent': 18},
    'Introduction to Computer Science': {'totalClasses': 20, 'daysPresent': 19},
    'Advanced Mathematics': {'totalClasses': 23, 'daysPresent': 20},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Column(
        children: [
          Container(
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
          decoration: BoxDecoration(
            color: _selectedDay == day
                ? Colors.blue
                : (_hoveredDay == day ? Colors.blue[800] : Colors.lightBlue),
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
    String subject = classInfo['subject']!;
    int totalClasses = _attendanceData[subject]!['totalClasses']!;
    int daysPresent = _attendanceData[subject]!['daysPresent']!;
    int daysAbsent = totalClasses - daysPresent;
    double presentPercentage = (daysPresent / totalClasses) * 100;

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
          Row(
            children: [
              _buildAttendanceInfo('Total: $totalClasses'),
              SizedBox(width: 8.0),
              _buildAttendanceInfo('Present: $daysPresent',
                  color: Colors.green),
              SizedBox(width: 8.0),
              _buildAttendanceInfo('Absent: $daysAbsent', color: Colors.red),
              SizedBox(width: 8.0),
              _buildAttendanceInfo(
                  'Present %: ${presentPercentage.toStringAsFixed(1)}%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceInfo(String text, {Color? color}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14.0, color: color != null ? Colors.white : Colors.black),
      ),
    );
  }
}
