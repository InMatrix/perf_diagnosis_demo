import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JsonDemo extends StatefulWidget {
  @override
  JsonDemoState createState() => JsonDemoState();
}
class JsonDemoState extends State<JsonDemo> {
  List data = List();

  _fetchData() async {
    final response =
      await http.get("https://jsonplaceholder.typicode.com/photos");
      if (response.statusCode == 200) {
        setState(() {
          data = (json.decode(response.body) as List)
              .map((data) => new Photo.fromJson(data))
              .toList();
        });
      }
  }

  @override
  void initState() {
    super.initState();
    this._fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List From JSON"),
        ),
        body: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(data[index].title),
                trailing: new Image.network(
                  data[index].thumbnailUrl,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              );
            }));
  }
}

class Photo {
  final String title;
  final String thumbnailUrl;
  Photo._({this.title, this.thumbnailUrl});
  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo._(
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}