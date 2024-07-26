import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:airbnb_clone/presentation/guest/screens/guest_home_screen.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/host/screen/host_screen.dart';
import 'package:airbnb_clone/presentation/loginAndSign/screens/login_screen.dart';
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
  UserModel userModel = UserModel();
  String hostTitle = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (userModel.isHost!) {
      if (userModel.isCurentlyHost!) {
        hostTitle = 'Show My Guest Dashboard';
      } else {
        hostTitle = 'Show My Host Dashboard';
      }
    } else {
      hostTitle = 'become a Host';
    }
    // fetchData();
  }
  // Future<void> fetchData()
  // async{
  //   final id = FirebaseAuth.instance.currentUser!.uid;
  //   if (id != null) {
  //     userModel =await FireBaseUserFunctions().getUserInfo(id);
  //     if (userModel.isHost != null) {
  //       if (userModel.isHost!) {
  //         hostTitle = userModel.isHost! ? 'show my host dash' : 'show my guest dash';
  //       }else
  //     {
  //       hostTitle = 'become a host';
  //     }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
  UserModel userModel = UserModel();
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
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
                    backgroundImage:
                    userModel.displayImage,
                    radius: MediaQuery.of(context).size.width / 5.2,
                  ),
                ),
                Text(
                  Styles.model.firstName??"null",
                  style: const TextStyle(color: Colors.black,fontSize: 25),
                ),
                Text(
                  userModel.email.toString()??"null",
                  style: const TextStyle(color: Colors.black,fontSize: 25),
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
                        setState(() {
                          
                        });
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
      ),
    );
  }

  modifyHost() async {
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
      await functions.becomeHost(FirebaseAuth.instance.currentUser!.uid);
      userModel.isCurentlyHost = true;
      Get.to(const HostScreen());
    }
  }
}
