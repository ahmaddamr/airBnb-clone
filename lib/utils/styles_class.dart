import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static List<String> screenTitles = [
    'Explore',
    'Saved',
    'Trips',
    'Inbox',
    'Profile',
  ];
  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xff4443C2),
  );
  static TextStyle login =
      GoogleFonts.aboreto(fontSize: 28, color: Colors.white,
    fontWeight: FontWeight.bold,
      );
      static TextStyle login2 =
      GoogleFonts.aboreto(fontSize: 15, color: Colors.white,
    fontWeight: FontWeight.bold,
      );
  // ignore: non_constant_identifier_names
  static TextStyle FirstFont = GoogleFonts.aboreto(
    fontSize: 27,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static const Color primaryColor = Colors.pinkAccent;
  static const Color secondColor = Colors.amber;

  // static const TextStyle onboardingSubTitle = GoogleFonts.abel()
}
