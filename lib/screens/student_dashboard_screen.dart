import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:attendance_app/courses_page.dart'; // Import your CoursesPage widget
import 'academic_screen.dart'; // Import your AcademicScreen widget
import 'home_screen.dart'; // Import your HomeScreen widget
import 'attendance_page.dart'; // Import your AttendancePage widget
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentDashboardScreen extends StatefulWidget {
  @override
  _StudentDashboardScreenState createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  int _selectedIndex = 0;
  Map<String, dynamic>? studentDetails;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchStudentDetails();
  }

  Future<void> _fetchStudentDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('StudentDetails')
          .doc(user.email)
          .get();
      setState(() {
        studentDetails = doc.data() as Map<String, dynamic>?;
        _profileImageUrl = studentDetails?['profileImageUrl'];
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String fileName = path.basename(pickedFile.path);
      File imageFile = File(pickedFile.path);

      // Upload the image to Firebase Storage
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(fileName);
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Update Firestore with the new profile image URL
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('StudentDetails')
              .doc(user.email)
              .update({'profileImageUrl': downloadUrl});

          setState(() {
            _profileImageUrl = downloadUrl;
          });
        }
      } catch (e) {
        print(e);
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        // Navigate to CoursesPage when Courses is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CoursesPage()),
        );
      } else if (_selectedIndex == 2) {
        // Navigate to AcademicScreen when Academic Calendar is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AcademicScreen()),
        );
      } else if (_selectedIndex == 3) {
        // Navigate to AttendancePage when Attendance is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendancePage()),
        );
      } else if (_selectedIndex == 4) {
        // Handle logout
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
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
        title: Text('Student Dashboard'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _onItemTapped(4); // Simulate tap on logout item
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
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                : AssetImage('assets/images/student.jpg')
                                    as ImageProvider,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: _pickImage,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (studentDetails != null)
                      Column(
                        children: [
                          Text(
                            'USN: ${studentDetails!['usn']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Name: ${studentDetails!['name']}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              if (studentDetails != null)
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Name: ${studentDetails!['name']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Email: ${studentDetails!['email']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('Branch: ${studentDetails!['branch']}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.class_),
                      title: Text('Section: ${studentDetails!['section']}'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      body: _selectedIndex == 0
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Carousel with announcements
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height *
                          0.25, // Adjust height
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
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                announcement,
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
              ),
            )
          : Container(), // Empty container for now, since we navigate to CoursesPage or AcademicScreen or AttendancePage
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
