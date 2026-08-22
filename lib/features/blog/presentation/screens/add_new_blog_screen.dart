import 'dart:io';

import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/screens/blog_screen.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final formKey = GlobalKey<FormState>();

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

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedTopics.isNotEmpty &&
        image != null) {
      final posterId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      context.read<BlogBloc>().add(
        BlogUpload(
          posterId: posterId,
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          image: image!,
          topics: selectedTopics,
        ),
      );
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
        actions: [
          IconButton(onPressed: uploadBlog, icon: Icon(Icons.done_rounded)),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackbar(context, state.message);
          } else if (state is BlogUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              BlogScreen.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          return SingleChildScrollView(
            padding: .all(16),
            child: Form(
              key: formKey,
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
                      children: Constants.topics
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
                  BlogEditor(
                    controller: titleController,
                    hintText: 'Blog Title',
                  ),
                  SizedBox(height: 10),
                  BlogEditor(
                    controller: contentController,
                    hintText: 'Blog Content',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
