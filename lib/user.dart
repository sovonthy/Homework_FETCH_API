import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  List users;
  Map userData;
  Future setUser() async{
    String url = "https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=beautiful&image_type=photo&pretty=true";
    http.Response response = await http.get(url);
    userData = json.decode(response.body);
    setState(() {
     users = userData['hits'] ;
    });

  }
  @override
  void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pixabay Data"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: users == null ? 0 : users.length,
        itemBuilder: (BuildContext context, int i) {
          final user = users[i];
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(user["userImageURL"]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("${user['user']}"),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    user["largeImageURL"],
                    fit: BoxFit.cover,
                    height: 250.0,
                    width: 400.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


