import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import for Firestore
import 'package:attendance_app/course_teacher.dart'; // Import your CoursesPage widget
import 'academic_screen.dart'; // Import your AcademicScreen widget
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
        // Navigate to AcademicScreen when Academic Calendar is tapped
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
                title: Text('Branch: Computer Science'),
              ),
              ListTile(
                leading: Icon(Icons.class_),
                title: Text('Section: A'),
              ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Announcements')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var announcements = snapshot.data!.docs;

                return Column(
                  children: <Widget>[
                    // Carousel with announcements
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: announcements.map((announcement) {
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
                                  announcement['message'],
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
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
                );
              },
            )
          : Container(), // Empty container for now, since we navigate to CoursesPage or AcademicScreen
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
            label: 'Academic Calendar',
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
