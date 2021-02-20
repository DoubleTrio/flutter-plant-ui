import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:plant_ui/constants.dart';
import 'dart:convert';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.postId});

  final int postId;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future postFuture;

  @override
  void initState() {
    // TODO: implement initState
    postFuture = _getPosts();
    print(postFuture);
    super.initState();
  }

  Future<List<Post>> _getPosts() async {
    http.Response response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var ls = jsonDecode(response.body) as List;
      return ls.map((e) => Post.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Testing'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            FeaturePlantCard(
              image: "assets/images/bottom_img_1.png",
              press: () {},
            ),
            FeaturePlantCard(
              image: "assets/images/bottom_img_2.png",
              press: () {},
            ),
            FeaturePlantCard(
              image: "assets/images/bottom_img_1.png",
              press: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Testing',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PostCard extends StatelessWidget {
  PostCard({this.userId, this.id, this.title, this.body});

  final int userId;
  final int id;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(20),
        child: Text(title));
  }
}

class PostList extends StatelessWidget {
  PostList({this.postList});

  final List<Post> postList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: postList.length,
      itemBuilder: (context, index) {
        Post data = postList[index];
        return ListTile(
            title: Text(data.title, style: TextStyle(fontSize: 20)),
            subtitle: Text(data.body),
            tileColor: Colors.white10,
            leading: Icon(Icons.image),
            trailing: Icon(Icons.more_vert));
      },
      separatorBuilder: (context, index) {
        return Container(padding: EdgeInsets.all(10));
      },
    );
    ;
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    Key key,
    this.image,
    this.press,
  }) : super(key: key);
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
