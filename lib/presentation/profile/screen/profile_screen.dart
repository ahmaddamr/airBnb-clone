import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel userModel = UserModel();
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
                Text(userModel.getFullName(),style: Styles.login,),
                Text(userModel.email.toString(),style: Styles.login,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
