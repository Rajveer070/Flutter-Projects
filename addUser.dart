import 'package:db_crud_evaluation/my_database.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  final Map<String, Object?>? map;

  const AddUser(this.map, {super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.map?["name"]?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.map == null ? "Add User" : "Edit User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                if (widget.map == null) {
                  await insertUser();
                } else {
                  await editUser(widget.map!["StuId"].toString());
                }
                Navigator.of(context).pop(true);
              },
              child: Text(widget.map == null ? "Submit" : "Update"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> insertUser() async {
    final Map<String, Object?> map = {
      "name": nameController.text,
    };
    await MyDatabase().insertUser(map);
  }

  Future<void> editUser(String id) async {
    final Map<String, Object?> map = {
      "name": nameController.text,
    };
    await MyDatabase().editUser(map, id);
  }
}
