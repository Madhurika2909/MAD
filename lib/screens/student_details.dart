import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class StudentDetailsScreen extends StatefulWidget {
  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  final _usnController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _branchController = TextEditingController();
  final _sectionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveDetails() async {
    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('StudentDetails')
            .doc(user.email)
            .set({
          'usn': _usnController.text,
          'name': _nameController.text,
          'email': _emailController.text,
          'branch': _branchController.text,
          'section': _sectionController.text,
        });

        // Navigate to HomeScreen after saving details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
      print('Error: ${e.toString()}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usnController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _branchController.dispose();
    _sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Student Details'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 450,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usnController,
                  decoration: InputDecoration(labelText: 'USN'),
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _branchController,
                  decoration: InputDecoration(labelText: 'Branch'),
                ),
                TextField(
                  controller: _sectionController,
                  decoration: InputDecoration(labelText: 'Section'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveDetails,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text('Save Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
