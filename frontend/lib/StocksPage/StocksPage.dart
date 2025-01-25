import 'package:astragen_app1/EmployeesPage/EmployeePage.dart';
import 'package:flutter/material.dart';
import 'package:astragen_app1/ContactUs/ContactUs.dart';
import 'package:astragen_app1/DepartmentPage/DepartmentPage.dart';
import 'package:astragen_app1/WelcomePage/WelcomePage.dart';

class StocksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 242, 130, 17),
          foregroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Stocks'),
              Tab(text: 'Add', icon: Icon(Icons.add)),
              Tab(text: 'Delete', icon: Icon(Icons.delete)),
            ],
          ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TabMenu()));
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text('Departments'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Departmentpage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.my_library_books),
                title: Text('Stocks'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Contact us'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactUs()));
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('View Content')),
            Center(child: Text('Add Content')),
            Center(child: Text('Delete Content')),
          ],
        ),
      ),
    );
  }
}
