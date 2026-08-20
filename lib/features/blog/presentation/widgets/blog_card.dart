import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: .all(16),
      padding: .all(16),
      decoration: BoxDecoration(color: color, borderRadius: .circular(10)),
      child: Column(children: [Text(blog.title)]),
    );
  }
}
