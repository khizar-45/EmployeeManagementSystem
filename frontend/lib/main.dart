import 'package:flutter/material.dart';
import 'package:astragen_app1/WelcomePage/WelcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
        // Light theme settings
      ),
      darkTheme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.orange,
        brightness: Brightness.dark, // Dark theme settings
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 56, 56, 56), // Example customization for dark theme
      ),
      themeMode:
          ThemeMode.system, // Automatically switches based on system settings
      home: WelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:astragen_app1/WelcomePage/welcomePage.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
      
//       title: 'Employee Management',
//       theme: ThemeData(
//         fontFamily: 'Montserrat',
//         primarySwatch: Colors.orange,
//       ),
//       home: WelcomePage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
