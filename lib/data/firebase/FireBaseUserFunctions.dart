// ignore_for_file: avoid_print

import 'dart:io';
import 'package:airbnb_clone/core/constants/contants.dart';
import 'package:airbnb_clone/data/models/posting_model.dart';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:airbnb_clone/presentation/guest/screens/guest_home_screen.dart';
import 'package:airbnb_clone/presentation/profile/screen/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class FireBaseUserFunctions {
  UserModel userModel = UserModel();
  Future<void> signUp(String email, String password, String bio,
      String firstName, String lastName, String city, File userImg) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('credential${credential.user!.uid}');

      String userId = credential.user?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }
      print('1111111111111111');

      await saveUserDataToFireStore(
          bio, city, email, firstName, lastName, userId);

      dynamic imageUrl = await saveImgToFirebase(userImg, userId);
      print(imageUrl);
      userInfo.id = userId;
      userInfo.bio = bio;
      userInfo.city = city;
      userInfo.email = email;
      userInfo.displayImage = imageUrl;
      userInfo.password = password;
      userInfo.firstName = firstName;
      userInfo.lastName = lastName;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'displayImage': imageUrl});

      print('222222222222222');
      Fluttertoast.showToast(
        msg: "Account created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      print('3333333333333333333333');

      Get.to(ProfileScreen());
    } catch (e) {
      print('errrrrrrrrror$e');
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

  //!create collection and upload userdata to firestore
  Future<void> saveUserDataToFireStore(String bio, String city, String email,
      String firstName, String lastName, String id) async {
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

  //!upload img to firebase storage
  Future<String> saveImgToFirebase(File userImg, String userId) async {
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(userId)
        .child(userId + '.png');
    UploadTask uploadTask = reference.putFile(userImg);

    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void login(email, password) async {
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        String currentUserId = value.user!.uid;
        userInfo.id = currentUserId;
        await getImageFromStorage(currentUserId);
        await getUserInfo(currentUserId);
        print('id is ${userInfo.id}');
        Fluttertoast.showToast(
          msg: 'Login Success',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 18.0,
        );
        Get.to(const GuestHomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }
    }
  }

  getUserInfo(id) async {
    //th
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    userInfo.snapshot = data;
    userInfo.firstName = data['firstName'] ?? "";
    userInfo.lastName = data['lastName'] ?? "";
    userInfo.email = data['email'] ?? '';
    userInfo.bio = data['bio'] ?? "";
    userInfo.city = data['city'] ?? "";
    userInfo.isHost = data['isHost'] ?? "";
    print("data is ${userInfo.city}");
  }

  getImageFromStorage(id) async {
    if (userInfo.displayImage != null) {
      return userInfo.displayImage;
    }
    final imgData = await FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(id)
        .child(id + '.png')
        .getData(1024 * 1024);
    userInfo.displayImage = MemoryImage(imgData!);
    return userInfo.displayImage;
  }

  becomeHost(String id) async {
    userInfo.isHost = true;
    Map<String, dynamic> dataMap = {
      'isHost': true,
    };
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update(dataMap);
  }

  modifyCurrentlyHosting(bool isHosting) {
    userInfo.isCurentlyHost = isHosting;
  }

  static addPostInfoToFirestore() async {
    Map<String, dynamic> dataMap = {
      'address': posting.address,
      'amenities': posting.amenities,
      'bathrooms': posting.bathrooms,
      'discreption': posting.discreption,
      'beds': posting.beds,
      // 'city': posting.city,
      // 'country':posting.country,
      'hostId': userInfo.id,
      'images': posting.images,
      'name': posting.name,
      'price': posting.price,
      'rating': 3.5,
      'type': posting.type,
    };
    DocumentReference reference =
        await FirebaseFirestore.instance.collection('postings').add(dataMap);
    await userInfo.addPosting(posting);
  }

  static addImagesToFirebase() async {
    for (var i = 0; i < posting.displayImages!.length; i++) {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('postingImages')
          .child(posting.id!)
          .child(posting.images![i]);
      await reference
          .putData(posting.displayImages![i].bytes)
          .whenComplete(() {});
    }
  }
  // static getPostsFromFirestore()
  // async{
  //   List<String> myPostingIds = List<String>.from(snapshot!['myPostingIds']) ?? [];
  // }

}
