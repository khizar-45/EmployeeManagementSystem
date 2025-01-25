import 'package:flutter/material.dart';
import 'package:astragen_app1/DepartmentPage/DepartmentPage.dart';
import 'package:astragen_app1/EmployeesPage/EmployeePage.dart';
import 'package:astragen_app1/StocksPage/StocksPage.dart';
import 'package:astragen_app1/WelcomePage/WelcomePage.dart';

class ContactUs extends StatelessWidget {
  final _formKey =
      GlobalKey<FormState>(); // Add this key to manage the form state

  String name = '';
  String email = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Color.fromARGB(255, 242, 130, 17),
        foregroundColor: Colors.white,
        title: Text('Contact Us'),
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
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(60),
        child: Form(
          // Wrap the Column in a Form widget
          key: _formKey, // Assign the key to the form
          child: Column(
            children: [
              Text(
                  'Please enter your details below, we will get back to you shortly'),
              SizedBox(height: 40),
              // TextFormField(
              //   initialValue: name,
              //   decoration: InputDecoration(
              //     labelText: 'Name',
              //     border: const OutlineInputBorder(),
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your name';
              //     }
              //     final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
              //     if (!nameRegex.hasMatch(value)) {
              //       return 'Name can only contain letters and spaces';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     name = value ?? '';
              //   },
              // ),
              // SizedBox(height: 20),
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
                  final emailRegex =
                      RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
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
              Text('(Or)'),
              SizedBox(height: 20),
              TextFormField(
                initialValue: phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  final phoneRegex = RegExp(r'^[0-9.-]+$');
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value ?? '';
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    // Logic to send the message
                    print('Message sent by $name');
                  }
                },
                child: Text('Send'),
              )
            ],
          ),
        ),
      ),
      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('Name: Sk Khizar Ali'),
      //     Text('Email: skkhizarali45@gmail.com'),
    );
  }

  // void sendMessage() {
  //   // Logic to send the message
  //   print('Message sent by $name');
  // }
}
