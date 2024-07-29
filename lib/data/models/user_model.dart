import 'package:airbnb_clone/data/models/booking_model.dart';
import 'package:airbnb_clone/data/models/contact_model.dart';
import 'package:airbnb_clone/data/models/posting_model.dart';
import 'package:airbnb_clone/data/models/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends ContactModel {
  String? email;
  String? password;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurentlyHost;
  DocumentSnapshot? snapshot;
  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;
  List<PostingModel>? myPostings;
  UserModel({
    String? id,
    String? firstName,
    String? lastName,
    String? displayImage,
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
    bookings = [];
    reviews = [];
    myPostings = [];
  }
  addPosting(PostingModel post) async {
    myPostings!.add(post);
    List<String> myPostingsList = [];
    myPostings!.forEach((element) {
      myPostingsList.add(element.id!);
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'myPostingIds': myPostingsList});
  }
}
