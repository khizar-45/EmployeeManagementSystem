import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:astragen_app1/EmployeesPage/EmployeePage.dart';
import 'package:astragen_app1/StocksPage/StocksPage.dart';
import 'package:astragen_app1/ContactUs/ContactUs.dart';
import 'package:astragen_app1/WelcomePage/WelcomePage.dart';
import 'package:http/http.dart' as http;

class Departmentpage extends StatelessWidget {
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
              Tab(
                text: 'CSE',
                // icon: Icon(Icons.business),
              ),
              Tab(
                text: 'IT',
                // icon: Icon(Icons.business),
              ),
              Tab(
                text: 'ECE',
                // icon: Icon(Icons.business),
              )
              // Tab(text: 'View', icon: Icon(Icons.view_list)),
              // Tab(text: 'Add', icon: Icon(Icons.add)),
              // Tab(text: 'Delete', icon: Icon(Icons.delete)),
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
                    Navigator.pop(context);
                  }),
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
        body: TabBarView(
          children: [CSE(), IT(), ECE()],
        ),
      ),
    );
  }
}

class CSE extends StatefulWidget {
  @override
  _CSEState createState() => _CSEState();
}

class _CSEState extends State<CSE> {
  List<dynamic> employees = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getCSE();
  }

  // Get employees from the backend
  Future<void> _getCSE() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/employees/FETCH_CSE'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> outerResponse = json.decode(response.body);
        final Map<String, dynamic> innerResponse =
            json.decode(outerResponse['body']);
        setState(() {
          employees = innerResponse['msg'];
          // filteredEmployees = innerResponse['msg'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load employees';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching employees: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: errorMessage.isEmpty
          ? employees.isEmpty
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 242, 130, 17)),
                ))
              : DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Employee ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Email')),
                  ],
                  rows: employees.map<DataRow>((employee) {
                    return DataRow(cells: [
                      DataCell(Text(employee['EmployeeId'].toString())),
                      DataCell(Text(employee['Name'])),
                      DataCell(Text(employee['Age'].toString())),
                      DataCell(Text(employee['Department'])),
                      DataCell(Text(employee['Email'])),
                    ]);
                  }).toList(),
                )
          : Center(child: Text(errorMessage)),
    ));
  }
}

class IT extends StatefulWidget {
  @override
  _ITState createState() => _ITState();
}

class _ITState extends State<IT> {
  List<dynamic> employees = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getIT();
  }

  // Get employees from the backend
  Future<void> _getIT() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/employees/FETCH_IT'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> outerResponse = json.decode(response.body);
        final Map<String, dynamic> innerResponse =
            json.decode(outerResponse['body']);
        setState(() {
          employees = innerResponse['msg'];
          // filteredEmployees = innerResponse['msg'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load employees';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching employees: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: errorMessage.isEmpty
          ? employees.isEmpty
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 242, 130, 17)),
                ))
              : DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Employee ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Age')),
                    DataColumn(label: Text('Department')),
                    DataColumn(label: Text('Email')),
                  ],
                  rows: employees.map<DataRow>((employee) {
                    return DataRow(cells: [
                      DataCell(Text(employee['EmployeeId'].toString())),
                      DataCell(Text(employee['Name'])),
                      DataCell(Text(employee['Age'].toString())),
                      DataCell(Text(employee['Department'])),
                      DataCell(Text(employee['Email'])),
                    ]);
                  }).toList(),
                )
          : Center(child: Text(errorMessage)),
    ));
  }
}

class ECE extends StatefulWidget {
  @override
  _ECEState createState() => _ECEState();
}

class _ECEState extends State<ECE> {
  List<dynamic> employees = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getECE();
  }

  // Get employees from the backend
  Future<void> _getECE() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/employees/FETCH_ECE'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> outerResponse = json.decode(response.body);
        final Map<String, dynamic> innerResponse =
            json.decode(outerResponse['body']);
        setState(() {
          employees = innerResponse['msg'];
          // filteredEmployees = innerResponse['msg'];
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load employees';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching employees: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: errorMessage.isEmpty
            ? employees.isEmpty
                ? Center(
                    child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromARGB(255, 242, 130, 17)),
                  ))
                : DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Employee ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Age')),
                      DataColumn(label: Text('Department')),
                      DataColumn(label: Text('Email')),
                    ],
                    rows: employees.map<DataRow>((employee) {
                      return DataRow(cells: [
                        DataCell(Text(employee['EmployeeId'].toString())),
                        DataCell(Text(employee['Name'])),
                        DataCell(Text(employee['Age'].toString())),
                        DataCell(Text(employee['Department'])),
                        DataCell(Text(employee['Email'])),
                      ]);
                    }).toList(),
                  )
            : Center(child: Text(errorMessage)),
      ),
    );
  }
}
