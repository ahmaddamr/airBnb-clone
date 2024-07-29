import 'package:airbnb_clone/data/models/booking_model.dart';
import 'package:airbnb_clone/data/models/contact_model.dart';
import 'package:airbnb_clone/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PostingModel {
  String? id;
  String? name;
  String? type;
  double? price;
  String? discreption;
  String? address;
  String? city;
  String? country;
  double? rating;
  ContactModel? host;
  List<String>? images;
  List<MemoryImage>? displayImages;
  List<String>? amenities;
  Map<String, int>? beds;
  Map<String, int>? bathrooms;
  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;

  PostingModel(
      {this.id = '',
      this.name = '',
      this.type = '',
      this.price = 0,
      this.discreption = '',
      this.address = '',
      this.city = '',
      this.country = '',
      this.host}) {
    images = [];
    amenities = [];
    bookings = [];
    reviews = [];
    beds = {};
    bathrooms = {};
    rating = 0;
  }
  setImageNames() {
    images = [];
    for (var i = 0; i < displayImages!.length; i++) {
      images!.add('image${i}.png');
    }
  }

  getPostingsInfoFromFirestore() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('postings').doc(id).get();
  }

  getPsotInfoFromSnapshot(DocumentSnapshot snapshot) {
    address = snapshot['address'];
    amenities = List<String>.from(snapshot['amenities'] ?? []);
    bathrooms = Map<String, int>.from(snapshot['bathrooms'] ?? {});
    beds = Map<String, int>.from(snapshot['beds'] ?? {});
    city = snapshot['city'] ?? '';
    name = snapshot['name'] ?? '';
    price = snapshot['price'].toDouble() ?? 0.0;
    rating = snapshot['rating'].toDouble() ?? 2.5;
    type = snapshot['type'] ?? "";

    country = snapshot['country'] ?? '';
    discreption = snapshot['discreption'] ?? '';
    String hostId = snapshot['hostId'] ?? "";
    host = ContactModel(id: hostId);
    images = List<String>.from(snapshot['imageNames']) ?? [];
  }

  getAllImagesFromStorage() async {
    displayImages = [];
    for (var i = 0; i < images!.length; i++) {
      final imgData = await FirebaseStorage.instance
          .ref()
          .child('postingImages')
          .child(id!)
          .child(images![i])
          .getData(1024 * 1024);
          displayImages!.add(MemoryImage(imgData!));
    }
    return displayImages;
  }
}
