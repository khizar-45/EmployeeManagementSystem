import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:astragen_app1/DepartmentPage/DepartmentPage.dart';
import 'package:astragen_app1/StocksPage/StocksPage.dart';
import 'package:astragen_app1/ContactUs/ContactUs.dart';
import 'package:astragen_app1/WelcomePage/WelcomePage.dart';

class TabMenu extends StatelessWidget {
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
              Tab(text: 'Active Employees', icon: Icon(Icons.people)),
              Tab(text: 'Add Employee', icon: Icon(Icons.add)),
              Tab(text: 'Manage Employees', icon: Icon(Icons.manage_accounts)),
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
                  Navigator.pop(context);
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
          children: [
            EmployeeList(),
            addEmployee(),
            DeleteEmployee(), // Delete Employee tab
          ],
        ),
      ),
    );
  }
}

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<dynamic> employees = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getEmployees();
  }

  // Get employees from the backend
  Future<void> _getEmployees() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/employees/GET_EMPLOYEES'),
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

class addEmployee extends StatefulWidget {
  addEmployee({super.key});

  @override
  State<addEmployee> createState() => _addEmployeeState();
}

class _addEmployeeState extends State<addEmployee> {
  String name = '';
  String email = '';
  String age = '';
  String department = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(60),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Please enter the details of the employee'),
            SizedBox(height: 40),
            TextFormField(
              initialValue: name,
              decoration: InputDecoration(
                labelText: 'Name',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                if (!nameRegex.hasMatch(value)) {
                  return 'Name can only contain letters and spaces';
                }
                return null;
              },
              onSaved: (value) {
                name = value ?? '';
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: age,
              decoration: InputDecoration(
                labelText: 'Age',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                final ageRegex = RegExp(r'^[0-99.-]+$');
                if (!ageRegex.hasMatch(value)) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (value) {
                age = value ?? '';
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Department',
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: 'CSE', child: Text('CSE')),
                DropdownMenuItem(value: 'IT', child: Text('IT')),
                DropdownMenuItem(value: 'ECE', child: Text('ECE')),
              ],
              onChanged: (value) {
                department = value ?? '';
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              initialValue: email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                final emailRegex = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onSaved: (value) {
                email = value ?? '';
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();

                  try {
                    final response = await http.post(
                      Uri.parse('http://localhost:3000/employees/ADD_EMPLOYEE'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'Name': name,
                        'Age': age,
                        'Department': department,
                        'Email': email,
                      }),
                    );

                    if (response.statusCode == 200) {
                      // If the employee was added successfully
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Employee added successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      // Navigate back to the first tab
                      DefaultTabController.of(context)?.animateTo(0);
                    } else {
                      // If there was an error in adding the employee
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error adding employee'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    // Catch any errors during the request
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteEmployee extends StatefulWidget {
  @override
  _DeleteEmployeeState createState() => _DeleteEmployeeState();
}

class _DeleteEmployeeState extends State<DeleteEmployee> {
  List<dynamic> employees = [];
  List<dynamic> filteredEmployees = [];
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getEmployees();
  }

  // Get employees from the backend
  Future<void> _getEmployees() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/employees/GET_EMPLOYEES'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> outerResponse = json.decode(response.body);
        final Map<String, dynamic> innerResponse =
            json.decode(outerResponse['body']);
        setState(() {
          employees = innerResponse['msg'];
          filteredEmployees = innerResponse['msg'];
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

  // Filter employees based on the entered Employee ID
  void _filterEmployees(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredEmployees = employees;
      });
    } else {
      setState(() {
        filteredEmployees = employees
            .where((employee) => employee['EmployeeId']
                .toString()
                .contains(query)) // Filter by EmployeeID
            .toList();
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
          ? Column(
              children: [
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Enter Employee ID',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => _filterEmployees(value),
                  ),
                ),
                filteredEmployees.isEmpty
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
                          DataColumn(label: Text('Edit')),
                          DataColumn(label: Text('Delete')),
                        ],
                        rows: filteredEmployees.map<DataRow>((employee) {
                          return DataRow(
                            cells: [
                              DataCell(Text(employee['EmployeeId'].toString())),
                              DataCell(Text(employee['Name'])),
                              DataCell(Text(employee['Age'].toString())),
                              DataCell(Text(employee['Department'])),
                              DataCell(Text(employee['Email'])),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _editEmployee(employee),
                                ),
                              ),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    try {
                                      final response = await http.post(
                                          Uri.parse(
                                              'http://localhost:3000/employees/DELETE_EMPLOYEE'),
                                          headers: {
                                            'Content-Type': 'application/json'
                                          },
                                          body: json.encode({
                                            'EmployeeId': employee['EmployeeId']
                                          }));

                                      if (response.statusCode == 200) {
                                        setState(() {
                                          employees.removeWhere((emp) =>
                                              emp['EmployeeId'] ==
                                              employee['EmployeeId']);
                                          filteredEmployees = employees;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Employee deleted successfully'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                      } else {
                                        print(response.statusCode);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Error deleting employee'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Error: ${e.toString()}'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      )
              ],
            )
          : Center(child: Text(errorMessage)),
    ));
  }

  void _editEmployee(Map employee) {
    final nameController = TextEditingController(text: employee['Name']);
    final ageController =
        TextEditingController(text: employee['Age'].toString());
    final departmentController =
        TextEditingController(text: employee['Department']);
    final emailController = TextEditingController(text: employee['Email']);

    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Employee'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
                    if (!nameRegex.hasMatch(value)) {
                      return 'Name can only contain letters and spaces';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'Age',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final ageRegex = RegExp(r'^[0-99]+$');
                    if (!ageRegex.hasMatch(value)) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: departmentController.text,
                  decoration: InputDecoration(
                    labelText: 'Select Department',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    DropdownMenuItem(value: 'CSE', child: Text('CSE')),
                    DropdownMenuItem(value: 'IT', child: Text('IT')),
                    DropdownMenuItem(value: 'ECE', child: Text('ECE')),
                  ],
                  onChanged: (value) {
                    departmentController.text = value ?? '';
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    final emailRegex =
                        RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Color.fromARGB(255, 255, 128, 17))),
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  final updatedEmployee = {
                    'EmployeeId': employee['EmployeeId'],
                    'Name': nameController.text,
                    'Age': int.parse(ageController.text),
                    'Department': departmentController.text,
                    'Email': emailController.text,
                  };
                  _updateEmployee(updatedEmployee);
                  try {
                    final response = await http.post(
                      Uri.parse(
                          'http://localhost:3000/employees/UPDATE_EMPLOYEE'),
                      headers: {'Content-Type': 'application/json'},
                      body: json.encode({
                        'EmployeeId': employee['EmployeeId'],
                        'Name': nameController.value.text,
                        'Age': ageController.value.text,
                        'Department': departmentController.value.text,
                        'Email': emailController.value.text,
                      }),
                    );

                    if (response.statusCode == 200) {
                      setState(() {
                        // final index = employees.indexWhere((emp) =>
                        //     emp['EmployeeId'] == employee['EmployeeId']);
                        // if (index != -1) {
                        //   employees[index] = employee;
                        //   filteredEmployees = employees;
                        // }
                        _getEmployees();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Employee updated successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      print(response.statusCode);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error updating employee'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  Navigator.of(context).pop();
                }
              },
              child: Text(
                'Update',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateEmployee(Map updatedEmployee) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/employees/UPDATE_EMPLOYEE'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedEmployee),
    );
    if (response.statusCode == 200) {
      _getEmployees();
    }
  }
}
