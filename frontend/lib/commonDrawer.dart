import 'package:astragen_app1/WelcomePage/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:astragen_app1/DepartmentPage/DepartmentPage.dart';
import 'package:astragen_app1/ContactUs/ContactUs.dart';
import 'package:astragen_app1/StocksPage/StocksPage.dart';

import 'EmployeesPage/EmployeePage.dart';

class Commondrawer extends StatelessWidget {
  const Commondrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              child: Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.people,
            ),
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
    );
  }
}
