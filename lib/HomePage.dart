import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';
import 'package:tst1/Models/PostsModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final Response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    List<dynamic> data = jsonDecode(Response.body.toString());
    if (Response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My App Api"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: getPostApi(),
                    builder: (context, snapshort) {
                      if (!snapshort.hasData) {
                        return Text('Loding');
                      } else {
                        return ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (context, index) {
                            return Text(postList[index].title.toString());
                          },
                        );
                      }
                    }))
          ],
        ));
  }
}
