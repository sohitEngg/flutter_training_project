import 'package:flutter/material.dart';
import 'package:flutter_app/photo.dart';
import 'package:flutter_app/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'listposts.dart';

class MyRemoteList extends StatefulWidget {
  final String title;

  MyRemoteList({Key key, this.title}) : super(key: key);

  @override
  _RemoteListState createState() => _RemoteListState();
}

Future<List<Post>> fetchPosts(http.Client client) async {
  final response =
      await client.get('https://jsonplaceholder.typicode.com/posts');
  return compute(parsePosts, response.body);
}

List<Post> parsePosts(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Post>((json) => Post.fromJson(json)).toList();
}

class _RemoteListState extends State<MyRemoteList> {
  List<Photo> list = List();
  var isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewPosts(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
