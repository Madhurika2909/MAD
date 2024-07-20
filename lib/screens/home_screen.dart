// // import 'package:flutter/material.dart';
// // import 'login_screen.dart';
// // import 'sign_up_screen.dart';

// // class HomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Attendance App'),
// //       ),
// //       body: Stack(
// //         children: <Widget>[
// //           Container(
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage('C:/Users/user/Desktop/graduation1.jpg'),
// //                 fit: BoxFit.cover,
// //               ),
// //             ),
// //           ),
// //           Center(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: <Widget>[
// //                 Spacer(), // Add Spacer to create space at the top
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => LoginScreen(userType: 'Student')),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
// //                     textStyle: TextStyle(fontSize: 20),
// //                   ),
// //                   child: Text('Student Login'),
// //                 ),
// //                 Spacer(), // Add Spacer between buttons
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => LoginScreen(userType: 'Teacher')),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
// //                     textStyle: TextStyle(fontSize: 20),
// //                   ),
// //                   child: Text('Teacher Login'),
// //                 ),
// //                 Spacer(), // Add Spacer between buttons
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => SignUpScreen()),
// //                     );
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
// //                     textStyle: TextStyle(fontSize: 20),
// //                   ),
// //                   child: Text('Sign Up'),
// //                 ),
// //                 Spacer(), // Add Spacer to create space at the bottom
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'login_screen.dart';
// import 'sign_up_screen.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance App'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('C:/Users/user/Desktop/graduation1.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Spacer(), // Add Spacer to create space at the top
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen(userType: 'Student')),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     textStyle: TextStyle(fontSize: 20),
//                   ),
//                   child: Text('Student Login'),
//                 ),
//                 Spacer(), // Add Spacer between buttons
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen(userType: 'Teacher')),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     textStyle: TextStyle(fontSize: 20),
//                   ),
//                   child: Text('Teacher Login'),
//                 ),
//                 Spacer(), // Add Spacer between buttons
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => SignUpScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//                     textStyle: TextStyle(fontSize: 20),
//                   ),
//                   child: Text('Sign Up'),
//                 ),
//                 Spacer(), // Add Spacer to create space at the bottom
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance App'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/graduation1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(), // Add Spacer to create space at the top
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen(userType: 'Student')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Student Login'),
                ),
                Spacer(), // Add Spacer between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginScreen(userType: 'Teacher')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Teacher Login'),
                ),
                Spacer(), // Add Spacer between buttons
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Sign Up'),
                ),
                Spacer(), // Add Spacer to create space at the bottom
              ],
            ),
          ),
        ],
      ),
    );
  }
}
