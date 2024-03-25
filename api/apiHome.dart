import 'dart:convert';

import 'package:api_implementation/api/addUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHome extends StatefulWidget {
  const ApiHome({super.key});

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Api-Implementation'),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const AddUser(null);
                    },
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  child: ListTile(
                    tileColor: Colors.blue[50],
                    title: Text(
                      snapshot.data![index]["name"].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await deleteUser(
                              snapshot.data![index]["id"].toString(),
                            ).then((value) {
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddUser(snapshot.data![index]);
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List> getUsers() async {
    var res = await http.get(
      Uri.parse("https://65f14ed8da8c6584131d591c.mockapi.io/Users"),
    );
    return jsonDecode(res.body);
  }

  Future<void> deleteUser(String id) async {
    var res = await http.delete(
      Uri.parse("https://65f14ed8da8c6584131d591c.mockapi.io/Users/$id"),
    );
  }
}
