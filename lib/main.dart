import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class Post {
  final String title;
  final String content;
  final String imageUrl;

  Post({required this.title, required this.content, required this.imageUrl});
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController _scrollController = ScrollController();
  List<Post> posts = List.generate(
    20,
    (index) => Post(
      title: 'Post $index',
      content: 'This is the content of post $index. Scroll down for more!',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // Fetch and add more posts when reaching the end of the list
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    // Simulate fetching more posts from your data source
    List<Post> newPosts = List.generate(
      10,
      (index) => Post(
        title: 'New Post ${posts.length + index}',
        content: 'This is the content of new post ${posts.length + index}. Scroll down for more!',
        imageUrl: 'https://via.placeholder.com/150',
      ),
    );
    setState(() {
      posts.addAll(newPosts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Posts'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(posts[index].title),
                subtitle: Text(posts[index].content),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(posts[index].imageUrl),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}