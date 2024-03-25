import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  final Map<String, dynamic>? map;

  const AddUser(this.map, {super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.map != null && widget.map!["name"] != null) {
      nameController.text = widget.map!["name"].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.map == null ? 'Add User' : 'Update User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Enter name"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (widget.map == null) {
                    await addUser(nameController.text);
                  } else {
                    await updateUser(
                      widget.map!["id"].toString(),
                      nameController.text,
                    );
                  }
                  Navigator.of(context).pop();
                },
                child: Text(widget.map == null ? 'Add User' : 'Update User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addUser(String name) async {
    var res = await http.post(
      Uri.parse("https://65f14ed8da8c6584131d591c.mockapi.io/Users"),
      body: {"name": name},
    );
  }

  Future<void> updateUser(String id, String newName) async {
    var res = await http.put(
      Uri.parse("https://65f14ed8da8c6584131d591c.mockapi.io/Users/$id"),
      body: {"name": newName},
    );
  }
}
