import 'package:flutter/material.dart';
import 'package:db_crud_evaluation/addUser.dart';
import 'package:db_crud_evaluation/my_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Database Implementation"),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddUser(null);
                  },
                )).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: MyDatabase().getDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
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
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await MyDatabase()
                                .deleteUser(snapshot.data![index]["StuId"])
                                .then((value) {
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AddUser(snapshot.data![index]);
                              },
                            )).then((value) {
                              setState(() {});
                            });
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.blue,
                        ),
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
}
