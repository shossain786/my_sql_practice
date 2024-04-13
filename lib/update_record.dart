// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateRecord extends StatefulWidget {
  String name, email, password;
  UpdateRecord(this.name, this.email, this.password, {super.key});

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    name.text = widget.name;
    email.text = widget.email;
    password.text = widget.password;
    super.initState();
  }

  Future<void> updateData() async {
    String uri = "http://10.0.2.2/practice_api/edit_data.php";
    try {
      var res = await http.post(Uri.parse(uri), body: {
        "name": name.text,
        "email": email.text,
        "password": password.text
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        debugPrint('Update Success');
      } else {
        debugPrint('Update failed');
      }
    } catch (e) {
      debugPrint('Exception occured\n $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Record'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Update Name'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
              ),
              enabled: false,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Update Password'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                updateData();
                name.text = '';
                email.text = '';
                password.text = '';
              },
              child: const Text('Update Record'),
            ),
          ),
        ],
      ),
    );
  }
}
