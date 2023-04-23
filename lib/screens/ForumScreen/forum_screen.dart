import 'package:flutter/material.dart';
import 'package:yolustunde_mobile/models/dio/dio_response.dart';
import 'package:yolustunde_mobile/models/forum_model.dart';
import 'package:yolustunde_mobile/screens/Feedback/feedback_screen.dart';
import 'package:yolustunde_mobile/screens/NewForum/new_forum.dart';
import 'package:yolustunde_mobile/services/dio_service.dart';
import 'package:yolustunde_mobile/theme/colors.dart';
import 'package:yolustunde_mobile/widgets/my_app_bar.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  void initState() {
    super.initState();
    getForums();
  }

  List<ForumModel> forums = [];

  Future<void> getForums() async {
    DioResponse dioResponse = await DioService().request('customer/threads');
    if (dioResponse.isSuccessful) {
      forums = dioResponse.data['data'].map<ForumModel>((e) => ForumModel.fromMap(e)).toList();
      setState(() {});
    }
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<ForumModel> filteredForums = [];
    if (selectedIndex == 0) {
      filteredForums = forums.where((element) => element.type == 'chat').toList();
    } else if (selectedIndex == 1) {
      filteredForums = forums.where((element) => element.type == 'question').toList();
    } else if (selectedIndex == 2) {
      filteredForums = forums.where((element) => element.type == 'journal').toList();
    }
    return Scaffold(
      appBar: buildAppBar(title: 'Forum', showBackButton: false, actions: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewForum())).then((value) {
              if (value == true) {
                getForums();
              }
            });
          },
          child: Text('Yeni Konu', style: TextStyle(color: MyColors.yellow, fontSize: 16)),
        ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 0 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Sohbet')),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 1 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Sorum Var')),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedIndex == 2 ? MyColors.yellow : Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: MyColors.greyLight2),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Center(child: Text('Gündem')),
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: filteredForums.length,
                  itemBuilder: (context, index) {
                    ForumModel forum = filteredForums[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: MyColors.greyLight2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(forum.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(
                              'Konu: ${forum.message}',
                              style: TextStyle(fontSize: 14, color: MyColors.greyLight),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
