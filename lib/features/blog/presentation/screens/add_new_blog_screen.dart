import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewBlogScreen extends StatefulWidget {
  static MaterialPageRoute<dynamic> route() =>
      MaterialPageRoute(builder: (_) => AddNewBlogScreen());

  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        padding: .all(16),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            image == null
                ? GestureDetector(
                    onTap: selectImage,
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: .circular(10),
                        color: AppPallete.borderColor,
                        dashPattern: [10, 4],
                        strokeCap: .round,
                      ),
                      child: SizedBox(
                        height: 150,
                        width: .infinity,
                        child: Column(
                          children: [
                            Icon(Icons.folder_open, size: 40),
                            SizedBox(height: 15),
                            Text(
                              'Select your image',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: .infinity,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: .circular(10),
                      child: Image.file(image!, fit: .cover),
                    ),
                  ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: .horizontal,
              child: Row(
                children:
                    ['Technology', 'Business', 'Programming', 'Entertainment']
                        .map(
                          (item) => Padding(
                            padding: .all(5.0),
                            child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(item)) {
                                  selectedTopics.remove(item);
                                } else {
                                  selectedTopics.add(item);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                label: Text(item),
                                color: selectedTopics.contains(item)
                                    ? WidgetStatePropertyAll(
                                        AppPallete.gradient1,
                                      )
                                    : null,
                                side: selectedTopics.contains(item)
                                    ? null
                                    : BorderSide(
                                        color: AppPallete.backgroundColor,
                                      ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 10),
            BlogEditor(controller: titleController, hintText: 'Blog Title'),
            SizedBox(height: 10),
            BlogEditor(controller: contentController, hintText: 'Blog Content'),
          ],
        ),
      ),
    );
  }
}
