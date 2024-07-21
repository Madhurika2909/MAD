

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:attendance_app/course_teacher.dart'; // Import your CoursesPage widget
import 'academic_screen.dart'; // Import your AttendancePage widget
import 'attendance_teacher.dart';

class TeacherDashboardScreen extends StatefulWidget {
  @override
  _TeacherDashboardScreenState createState() => _TeacherDashboardScreenState();
}

class _TeacherDashboardScreenState extends State<TeacherDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // Navigate to CoursesPage when Courses is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoursesTeacher()),
        );
      } else if (_selectedIndex == 2) {
        // Navigate to AttendancePage when Attendance is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcademicScreen()),
        );
      } else if (_selectedIndex == 3) {
        // Handle logout
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AttendanceTeacher()),
        );
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: _openDrawer,
        ),
        title: Text('Teacher Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _onItemTapped(3); // Simulate tap on logout item
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/student.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'USN: 1BM22CS342',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Name: Sakshi'),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email: bhoomika@example.com'),
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text('Dept: Computer Science'),
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? Column(
              children: <Widget>[
                // Carousel with announcements
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: [
                    'Welcome to the new semester!',
                    'Don\'t forget to check your email for updates.',
                    'Exam schedule will be released next week.',
                  ].map((announcement) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Text(
                              announcement,
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                // Add other widgets here
              ],
            )
          : Container(), // Empty container for now, since we navigate to CoursesPage or AttendancePage
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendar),
            label: 'Academic Clender',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarCheck),
            label: 'Attendance',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

