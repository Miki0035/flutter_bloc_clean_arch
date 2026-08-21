import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_viewer_screen.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerScreen.route(blog));
      },
      child: Container(
        height: 200,
        margin: .only(top: 16, left: 16, right: 16, bottom: 4),
        padding: .all(16),
        decoration: BoxDecoration(color: color, borderRadius: .circular(10)),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .spaceBetween,
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                SingleChildScrollView(
                  scrollDirection: .horizontal,
                  child: Row(
                    children: blog.topics
                        .map(
                          (item) => Padding(
                            padding: .all(5.0),
                            child: Chip(label: Text(item)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Text(
                  blog.title,
                  style: TextStyle(fontSize: 22, fontWeight: .bold),
                ),
              ],
            ),

            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
