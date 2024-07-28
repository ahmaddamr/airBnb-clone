import 'dart:async';
import 'package:airbnb_clone/presentation/auth/screens/login_screen.dart';
import 'package:airbnb_clone/presentation/guest/screens/guest_home_screen.dart';
import 'package:airbnb_clone/presentation/profile/screen/profile_screen.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshScreen> {
  // ignore: unused_field
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  _goNext() {
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const GuestHomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Styles.primaryColor,
                Styles.secondColor,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 2),
              stops: [0, 1],
              tileMode: TileMode.clamp),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash.png'),
              Text(
                'Welcome To AirBnb App',
                style: Styles.FirstFont,
              )
            ],
          ),
        ),
      ),
    );
  }
}
