import 'package:flutter/material.dart';
import 'student_dashboard_screen.dart';
import 'teacher_dashboard_screen.dart'; // Import the teacher dashboard screen
import 'package:firebase_auth/firebase_auth.dart';

final _firebaseAuth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  final String userType;

  LoginScreen({required this.userType});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Navigate to the respective dashboard
      if (widget.userType == 'Student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentDashboardScreen()),
        );
      } else if (widget.userType == 'Teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherDashboardScreen()),
        );
      }
    } catch (e) {
      // Handle login error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to login: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _forgotPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address.')),
      );
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send reset email: $e')),
      );
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController emailController = TextEditingController();

        return AlertDialog(
          title: Text('Forgot Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'Enter your email address and we\'ll send you a link to reset your password.'),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _firebaseAuth.sendPasswordResetEmail(
                    email: emailController.text.trim());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password reset email sent.')),
                );
              },
              child: Text('Send Reset Link'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Set header color to blue
        title: Text('${widget.userType} Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 450, // Set a fixed width for the text fields
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text('Login'),
                  ),
                  TextButton(
                    onPressed: _showForgotPasswordDialog,
                    child: Text('Forgot Password?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
