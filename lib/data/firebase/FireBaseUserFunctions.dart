import 'dart:io';

import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireBaseUserFunctions {
  signUp(email, password, bio, firstName, lastName, city, userImg) async {
    UserModel? userModel;
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        String UserId = value.user!.uid;
        userModel?.id = UserId;
        userModel?.bio = bio;
        userModel?.city = city;
        userModel?.email = email;
        userModel?.displayImage = userImg;
        userModel?.password = password;
        userModel?.firstName = firstName;
        userModel?.lastName = lastName;
        await saveUserDataToFireStore(
                bio, city, email, firstName, lastName, UserId)
            .whenComplete(() async {
          await saveImgToFirebase(userImg, UserId);
        });
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0);
    }
  }

  Future<void> saveUserDataToFireStore(
      bio, city, email, firstName, lastName, id) async {
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

  saveImgToFirebase(File userImg, UserId) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(UserId)
        .child(UserId + '.png');
    await reference.putFile(userImg).whenComplete(() {});
    MemoryImage displayImg = MemoryImage(userImg.readAsBytesSync());
  }
}
