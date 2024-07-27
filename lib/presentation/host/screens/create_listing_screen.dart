import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';

class CreateListingScreen extends StatelessWidget {
  const CreateListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomContainer(),
        title: const Text('Create, Update a Listing'),
      ),
      
    );
  }
}
