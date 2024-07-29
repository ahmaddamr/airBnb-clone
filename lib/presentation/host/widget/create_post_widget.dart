import 'package:flutter/material.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.all(10),
            width: 350,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add),
                Text(
                  'Create a Listing',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          );
  }
}