import 'package:airbnb_clone/data/models/booking_model.dart';
import 'package:airbnb_clone/data/models/contact_model.dart';
import 'package:airbnb_clone/data/models/review_model.dart';
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
    bookings =[];
    reviews = [];
    beds = {};
    bathrooms = {};
    rating = 0;
  }
  setImageNames()
  {
    images =[];
    for (var i = 0; i < displayImages!.length; i++) {
      images!.add('image${i}.png');

    }
  }
  
}
