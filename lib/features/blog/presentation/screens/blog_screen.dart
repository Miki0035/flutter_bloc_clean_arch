import 'package:blog_app/features/blog/presentation/screens/add_new_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewBlogScreen.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
