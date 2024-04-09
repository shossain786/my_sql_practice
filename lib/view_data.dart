import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];

  @override
  void initState() {
    debugPrint('Inside initstate');
    getrecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Data'),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(left: 4, right: 4, top: 4),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${(userData[index]["uname"]).substring(0, 1)}'),
              ),
              title: Text(userData[index]["uname"]),
              subtitle: Text(userData[index]["uemail"]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  debugPrint('Fetched id: ${userData[index]["id"]}');
                  deleteRecord(userData[index]["id"]);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getrecord() async {
    String uri = "http://10.0.2.2/practice_api/view_data.php";
    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        if (response.body.isEmpty) {
        } else {
          userData = jsonDecode(response.body);
        }
      });
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  Future<void> deleteRecord(String id) async {
    String uri = "http://10.0.2.2/practice_api/delete_data.php";
    try {
      debugPrint('Inside delete Record for id: $id');
      var res = await http.post(Uri.parse(uri), body: {"id": id});
      debugPrint('response: ${res.body}');
      var response = jsonDecode(res.body);
      debugPrint('Response: $response');
      if (response["success"] == "true") {
        debugPrint('Record deleted successfully');
        getrecord();
      } else {
        debugPrint('Failed to delete the record!');
      }
    } catch (e) {
      debugPrint("Exception: $e");
    }
  }
}
