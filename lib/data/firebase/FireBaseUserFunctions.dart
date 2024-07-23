import 'dart:io';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FireBaseUserFunctions {
  UserModel userModel = UserModel();
  Future<void> signUp(String email, String password, String bio,
      String firstName, String lastName, String city, File userImg) async {
    UserModel userModel = UserModel();

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = credential.user?.uid ?? '';
      if (userId.isEmpty) {
        throw Exception('User ID is empty');
      }

      await saveUserDataToFireStore(
          bio, city, email, firstName, lastName, userId);

      String imageUrl = await saveImgToFirebase(userImg, userId);

      userModel.id = userId;
      userModel.bio = bio;
      userModel.city = city;
      userModel.email = email;
      userModel.displayImage = imageUrl;
      userModel.password = password;
      userModel.firstName = firstName;
      userModel.lastName = lastName;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'displayImage': imageUrl});

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
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        String currentUserId = value.user!.uid;
        userModel.id = currentUserId;
        getImageFromStorage(currentUserId);
        getUserInfo(currentUserId);
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
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    userModel.snapshot = data;
    userModel.firstName = data['firstName'];
    userModel.lastName = data['lastName'];
    userModel.bio = data['bio'];
    userModel.city = data['city'];
    userModel.isHost = data['isHost'];
  }

  getImageFromStorage(id) async {
    if (userModel.displayImage != null) {
      return userModel.displayImage;
    }
    final imgData = await FirebaseStorage.instance
        .ref()
        .child('userImages')
        .child(id)
        .child(id + '.png')
        .getData(1024 * 1024);
    userModel.displayImage = MemoryImage(imgData!);
    return userModel.displayImage;
  }
}
