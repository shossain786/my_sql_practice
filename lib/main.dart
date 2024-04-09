import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_sql_practice/view_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async {
    debugPrint(
        'Username: $name.text, Email: $email.text and Password: $password.text');
    if (name.text != "" || email.text != "" || password.text != "") {
      try {
        String uri = "http://10.0.2.2/practice_api/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          debugPrint('True');
        } else {
          debugPrint('Unable to insert data');
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('Please fill all the fields.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My DB Practice'),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Name'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Email'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Enter Password'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  insertrecord();
                  name.text = '';
                  email.text = '';
                  password.text = '';
                },
                child: const Text('Insert Record'),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewData(),
                      ),
                    );
                  },
                  child: const Text('View Data'),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
