import 'dart:io';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireBaseUserFunctions {
  Future<void> signUp(String email, String password, String bio, String firstName, String lastName, String city, File userImg) async {
    UserModel userModel = UserModel();

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = credential.user?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      // Save the user data to Firestore first
      await saveUserDataToFireStore(bio, city, email, firstName, lastName, userId);

      // Upload the image and get the download URL
      String imageUrl = await saveImgToFirebase(userImg, userId);

      // Update user model with image URL
      userModel.id = userId;
      userModel.bio = bio;
      userModel.city = city;
      userModel.email = email;
      userModel.displayImage = imageUrl;
      userModel.password = password;
      userModel.firstName = firstName;
      userModel.lastName = lastName;

      // Update Firestore with the image URL
      await FirebaseFirestore.instance.collection('users').doc(userId).update({'displayImage': imageUrl});

      Fluttertoast.showToast(
        msg: "Account created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Failed to create account: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
  }

  Future<void> saveUserDataToFireStore(String bio, String city, String email, String firstName, String lastName, String id) async {
    Map<String, dynamic> dataMap = {
      'bio': bio,
      'city': city,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isHost': false,
      'myPostingIds': [],
      'savedPostingIds': [],
      'earnings': 0
    };
    await FirebaseFirestore.instance.collection('users').doc(id).set(dataMap);
  }

  Future<String> saveImgToFirebase(File userImg, String userId) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(userId)
        .child(userId + '.png');
    UploadTask uploadTask = reference.putFile(userImg);

    // Wait for the upload to complete and get the download URL
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
