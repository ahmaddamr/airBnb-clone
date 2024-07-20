import 'package:airbnb_clone/firebase_options%20copy.dart';
import 'package:airbnb_clone/presentation/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   await FirebaseAppCheck.instance.activate(
// webRecaptchaSiteKey: 'recaptcha-v3-site-key',
// );
  runApp(const AirBnbClone());
}

class AirBnbClone extends StatelessWidget {
  const AirBnbClone({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpalshScreen(),
    );
  }
}
