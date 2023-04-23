import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/blog_model.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    getBlogs();
  }

  List<BlogModel> blogs = [];

  Future<void> getBlogs() async {
    DioResponse dioResponse = await DioService().request('blog');
    if (dioResponse.isSuccessful) {
      blogs = dioResponse.data['data'].map<BlogModel>((e) => BlogModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Blog', showBackButton: false),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16),
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                BlogModel blog = blogs[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: MyColors.greyLight2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        blog.body,
                        style: TextStyle(fontSize: 12, color: MyColors.grey.withOpacity(0.8), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          blog.diffForHumans,
                          style: TextStyle(fontSize: 12, color: MyColors.grey.withOpacity(0.8), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
