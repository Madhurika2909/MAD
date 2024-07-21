import 'package:flutter/material.dart';

class AttendanceReportPage extends StatelessWidget {
  final List<String> students;

  AttendanceReportPage({required this.students});

  // Sample data for attendance records; replace with actual data
  Map<String, List<String>> _getAttendanceRecords() {
    return {
      '01-07-2024': ['P', 'A', 'P', 'P', 'A', 'P', 'A'],
      '02-07-2024': ['A', 'P', 'P', 'A', 'P', 'P', 'A'],
      '03-07-2024': ['P', 'P', 'A', 'P', 'A', 'P', 'P'],
      '04-07-2024': ['A', 'A', 'P', 'P', 'P', 'A', 'P'],
      '05-07-2024': ['P', 'P', 'P', 'A', 'P', 'P', 'A'],
      '06-07-2024': ['P', 'P', 'A', 'P', 'A', 'P', 'P'],
      '07-07-2024': ['A', 'P', 'P', 'A', 'P', 'A', 'P'],
    };
  }

  @override
  Widget build(BuildContext context) {
    final attendanceRecords = _getAttendanceRecords();
    final dates = attendanceRecords.keys.toList();
    final List<List<String>> records = List.generate(students.length, (index) {
      return List.generate(dates.length, (dateIndex) {
        return attendanceRecords[dates[dateIndex]]![index];
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Student')),
            ...dates.map((date) => DataColumn(label: Text(date))),
          ],
          rows: List.generate(students.length, (index) {
            return DataRow(
              cells: [
                DataCell(Text(students[index])),
                ...records[index].map((status) => DataCell(Text(status))),
              ],
            );
          }),
        ),
      ),
    );
  }
}
