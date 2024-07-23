import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:airbnb_clone/presentation/guest/screens/guest_home_screen.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/host/screen/host_screen.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  // const ProfileScreen({super.key});
  UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {},
              child: CircleAvatar(
                backgroundColor: Styles.primaryColor,
                radius: MediaQuery.of(context).size.width / 5.0,
                child: CircleAvatar(
                  backgroundImage: userModel.displayImage,
                  radius: MediaQuery.of(context).size.width / 5.2,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  userModel.getFullName(),
                  style: Styles.login,
                ),
                Text(
                  userModel.email.toString(),
                  style: Styles.login,
                ),
                ListView(
                  children: [
                    CustomContainer(
                      child: MaterialButton(
                        onPressed: () 
                        {
                          modifyHost();
                        },
                        child: ListTile(
                          leading: Text(''),
                          trailing: Icon(Icons.hotel),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  modifyHost() async{
    if (userModel.isHost!) {
      if (userModel.isCurentlyHost!) {
        userModel.isCurentlyHost = false;
        Get.to(const GuestHomeScreen());
      } else {
        userModel.isCurentlyHost = true;
        Get.to(const HostScreen());
      }
    } else {
      FireBaseUserFunctions functions = FireBaseUserFunctions();
    await  functions.becomeHost(FirebaseAuth.instance.currentUser!.uid);
    userModel.isCurentlyHost = true;
        Get.to(const HostScreen());
    }
  }
}
