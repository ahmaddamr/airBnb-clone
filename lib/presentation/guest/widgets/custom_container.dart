import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
