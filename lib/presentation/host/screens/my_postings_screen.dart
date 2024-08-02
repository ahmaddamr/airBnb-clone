import 'package:airbnb_clone/core/constants/contants.dart';
import 'package:airbnb_clone/presentation/host/screens/create_listing_screen.dart';
import 'package:airbnb_clone/presentation/host/widget/create_post_widget.dart';
import 'package:airbnb_clone/presentation/host/widget/post_listTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostingsScreen extends StatefulWidget {
  const MyPostingsScreen({super.key});

  @override
  State<MyPostingsScreen> createState() => _MyPostingsScreenState();
}

class _MyPostingsScreenState extends State<MyPostingsScreen> {
  @override
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: userInfo.myPostings!.length + 1,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.topCenter,
          child: InkWell(
            onTap: () {
              Get.to(CreateListingScreen(
                  posting: (index == userInfo.myPostings!.length)
                      ? null
                      : userInfo.myPostings![index]));
            },
            child: (index == userInfo.myPostings!.length)
                ? const CreatePostWidget()
                : PostListtile(
                    post: userInfo.myPostings![index],
                  ),
          ),
        );
      },
    ));
  }
}
