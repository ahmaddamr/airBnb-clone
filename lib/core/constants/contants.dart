import 'package:airbnb_clone/data/models/contact_model.dart';
import 'package:airbnb_clone/data/models/posting_model.dart';
import 'package:airbnb_clone/data/models/user_model.dart';
import 'package:airbnb_clone/data/posting/posting_functions.dart';

UserModel userInfo =
    UserModel(); //all app can access this object, this is the only object taht contains the data of the user.
PostingFunctions postingFunctions = PostingFunctions();
PostingModel posting = PostingModel();

class AppConstants {
  static ContactModel createContactFromUserModel() {
    return ContactModel(
        firstName: userInfo.firstName,
        lastName: userInfo.lastName,
        displayImage: userInfo.displayImage);
  }
}
