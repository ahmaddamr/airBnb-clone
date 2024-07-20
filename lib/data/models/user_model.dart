import 'package:airbnb_clone/data/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel extends ContactModel {
  String? email;
  String? password;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurentlyHost;
  DocumentSnapshot? snapshot;
  UserModel({
    String? id,
    String? firstName,
    String? lastName,
    MemoryImage? displayImage,
    this.email = '',
    this.city = '',
    this.country = '',
    this.bio = '',
  }) : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            displayImage: displayImage) {
    isHost = false;
    isCurentlyHost = false;
  }
  
}
