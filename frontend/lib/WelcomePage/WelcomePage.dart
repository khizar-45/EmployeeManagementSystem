import 'package:flutter/material.dart';
import 'package:astragen_app1/EmployeesPage/EmployeePage.dart';
import 'package:astragen_app1/DepartmentPage/DepartmentPage.dart';
import 'package:astragen_app1/ContactUs/ContactUs.dart';
import 'package:astragen_app1/StocksPage/StocksPage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 242, 130, 17),
        toolbarHeight: 100,
        title: Text(
          'ASTRAGEN',
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat"),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        // backgroundColor: Color.fromARGB(200, 255, 255, 255),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                image: DecorationImage(
                  image: AssetImage('../assets/Untitled-661.png'),
                  fit: BoxFit.contain,
                ),
              ),
              padding: EdgeInsets.zero,
              child: Container(
                height: 90,
                alignment: Alignment.center,
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Employees'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TabMenu()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.business),
              title: Text('Departments'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Departmentpage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.my_library_books),
              title: Text('Stocks'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StocksPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Contact us'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContactUs(
                            // name: 'Your Name',
                            // email: 'your.email@example.com',
                            // message: 'Your message')
                            )));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("../assets/Untitled-661.png")),
            SizedBox(height: 60),
            Text(
              'Welcome to AstraGen App!',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
