import 'dart:io';

import 'package:airbnb_clone/core/constants/contants.dart';
import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/presentation/guest/screens/guest_home_screen.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/host/screens/host_screen.dart';
import 'package:airbnb_clone/presentation/auth/screens/login_screen.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // const ProfileScreen({super.key});

  String hostTitle = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userInfo.isHost!) {
      if (userInfo.isCurentlyHost!) {
        hostTitle = 'Show My Guest Dashboard';
      } else {
        hostTitle = 'Show My Host Dashboard';
      }
    } else {
      hostTitle = 'become a Host';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Styles.primaryColor,
                radius: MediaQuery.of(context).size.width / 5.0,
                child: CircleAvatar(
                  backgroundImage: userInfo.displayImage,
                  radius: MediaQuery.of(context).size.width / 5.2,
                ),
              ),
              Text(
                userInfo.firstName ?? "null",
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
              Text(
                userInfo.email ?? "null",
                style: const TextStyle(color: Colors.black, fontSize: 25),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomContainer(
                  child: MaterialButton(
                    onPressed: () {},
                    child: const ListTile(
                      leading: Text(
                        'personal Information',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomContainer(
                  child: MaterialButton(
                    onPressed: () {
                      modifyHost();
                      setState(() {});
                    },
                    child: ListTile(
                      leading: Text(
                        hostTitle,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.hotel),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomContainer(
                  child: MaterialButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: const ListTile(
                      leading: Text(
                        'LogOut',
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Icon(Icons.logout),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  modifyHost() async {
    if (userInfo.isHost!) {
      if (userInfo.isCurentlyHost!) {
        userInfo.isCurentlyHost = false;
        Get.to(const GuestHomeScreen());
      } else {
        userInfo.isCurentlyHost = true;
        Get.to( HostScreen());
      }
    } else {
      FireBaseUserFunctions functions = FireBaseUserFunctions();
      await functions.becomeHost(FirebaseAuth.instance.currentUser!.uid);
      userInfo.isCurentlyHost = true;
      Get.to( HostScreen());
    }
  }
}
