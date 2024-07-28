import 'package:airbnb_clone/data/models/user_model.dart';

class ContactModel {
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  dynamic displayImage;
  ContactModel(
      {this.id = '',
      this.firstName = '',
      this.lastName = '',
      this.displayImage});
  String getFullName() {
    // ignore: prefer_adjacent_string_concatenation
    return fullName = firstName??'' + ' ' + lastName!;
  }

  UserModel createUserFromContact() {
    return UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        displayImage: displayImage);
  }
}
