import 'dart:io';

import 'package:airbnb_clone/core/constants/contants.dart';
import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/data/models/posting_model.dart';
import 'package:airbnb_clone/presentation/auth/widgets/custom_elevated_button.dart';
import 'package:airbnb_clone/presentation/auth/widgets/custom_text_field.dart';
import 'package:airbnb_clone/presentation/guest/widgets/custom_container.dart';
import 'package:airbnb_clone/presentation/host/screens/host_screen.dart';
import 'package:airbnb_clone/presentation/host/widget/amenities.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateListingScreen extends StatefulWidget {
    CreateListingScreen({super.key,this.posting});
  PostingModel? posting;

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen> {
  final formKey = GlobalKey<FormState>();
  bool isLoading= false ;

  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController discreptionController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController amentiesController = TextEditingController();

  String residenceSelected = '';
  Map<String, int>? beds;
  Map<String, int>? bathrooms;
  List<MemoryImage>? images;
  selectImageFromGallery(int i) async {
    var pickImg = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImg != null) {
      MemoryImage newImg = MemoryImage((File(pickImg.path)).readAsBytesSync());
      if (i < 0) {
        images!.add(newImg);
      } else {
        images![i] = newImg;
      }
      setState(() {});
    }
  }

  initialValues() {
    nameController = TextEditingController(text: '');

    priceController = TextEditingController(text: '');
    discreptionController = TextEditingController(text: '');

    addressController = TextEditingController(text: '');
    amentiesController = TextEditingController(text: '');
    residenceSelected = Styles.residenceTypes.first;
    beds = {
      'small': 0,
      'medium': 0,
      'large': 0,
    };
    bathrooms = {
      'Full': 0,
      'half': 0,
    };
    images = [];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomContainer(),
        title: const Text('Create, Update a Listing'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: nameController,
                  hint: 'Listing Name',
                  obscureText: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter a Valid Name ';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: DropdownButton(
                  items: Styles.residenceTypes.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      residenceSelected = value.toString();
                    });
                  },
                  isExpanded: true,
                  value: residenceSelected,
                  hint: const Text('select Property type'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: priceController,
                  hint: 'price \$ / night',
                  obscureText: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter a Valid price ';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              // const Text('\$ / night', style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: discreptionController,
                  hint: 'Discreption',
                  obscureText: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter a Valid Discreption';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextFormField(
                  controller: addressController,
                  hint: 'address',
                  obscureText: false,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please Enter a Valid Address';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const Text('Beds', style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Amenities(
                          type: 'Twin/Single',
                          startValue: beds!['small']!,
                          decreaseValue: () {
                            beds!['small'] = beds!['small']! - 1;
                            if (beds!['small']! < 0) {
                              beds!['small'] = 0;
                            }
                          },
                          increaseValue: () {
                            beds!['small'] = beds!['small']! + 1;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Amenities(
                          type: 'Double',
                          startValue: beds!['medium']!,
                          decreaseValue: () {
                            beds!['medium'] = beds!['medium']! - 1;
                            if (beds!['medium']! < 0) {
                              beds!['medium'] = 0;
                            }
                          },
                          increaseValue: () {
                            beds!['medium'] = beds!['medium']! + 1;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70.0),
                      child: Amenities(
                          type: 'queen/king',
                          startValue: beds!['large']!,
                          decreaseValue: () {
                            beds!['large'] = beds!['large']! - 1;
                            if (beds!['large']! < 0) {
                              beds!['large'] = 0;
                            }
                          },
                          increaseValue: () {
                            beds!['large'] = beds!['large']! + 1;
                          }),
                    ),
                    const Text(
                      'Bathrooms',
                      style: TextStyle(fontSize: 20),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: Amenities(
                            type: 'Full',
                            startValue: bathrooms!['Full']!,
                            decreaseValue: () {
                              bathrooms!['Full'] = bathrooms!['Full']! - 1;
                              if (bathrooms!['Full']! < 0) {
                                bathrooms!['Full'] = 0;
                              }
                            },
                            increaseValue: () {
                              bathrooms!['Full'] = bathrooms!['Full']! + 1;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: Amenities(
                            type: 'Half',
                            startValue: bathrooms!['half']!,
                            decreaseValue: () {
                              bathrooms!['half'] = bathrooms!['half']! - 1;
                              if (bathrooms!['half']! < 0) {
                                bathrooms!['half'] = 0;
                              }
                            },
                            increaseValue: () {
                              bathrooms!['half'] = bathrooms!['half']! + 1;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomTextFormField(
                            controller: amentiesController,
                            hint: 'Amenties',
                            obscureText: false,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Please Enter a Valid Amenties ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const Text(
                          'Photos',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 25),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: images!.length + 1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 25,
                                    crossAxisSpacing: 25,
                                    childAspectRatio: 3 / 2),
                            itemBuilder: (context, index) {
                              if (index == images!.length) {
                                return IconButton(
                                    onPressed: () {
                                      selectImageFromGallery(-1);
                                    },
                                    icon: const Icon(Icons.add));
                              }
                              return MaterialButton(
                                onPressed: () {},
                                child: Image(image: images![index]),
                              );
                            },
                          ),
                        ),
                        isLoading ? const Center(child: CircularProgressIndicator()) : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child:  CustomElvatedButton(
                            text: 'Upload',
                            backgroundColor: Styles.primaryColor,
                            borderSideColor: Colors.transparent,
                            style: Styles.login,
                            onPressed: () async {
                              if (!formKey.currentState!.validate()) {
                                
                                return Fluttertoast.showToast(
                                  msg: "Not Valid",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0,
                                );
                              }
                              if (residenceSelected == '') {
                                return Fluttertoast.showToast(
                                  msg: "Empty Field",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0,
                                );
                              }
                              if (images!.isEmpty) {
                                return Fluttertoast.showToast(
                                  msg: "Photos are Required",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0,
                                );
                              }
                              setState(() {
                                isLoading = true;
                                  
                                });
                              posting.name = nameController.text;
                              posting.price =
                                  double.parse(priceController.text);
                              posting.discreption = discreptionController.text;
                              posting.address = addressController.text;
                              posting.amenities =
                                  amentiesController.text.split(',');
                              posting.beds = beds;
                              posting.bathrooms = bathrooms;
                              posting.displayImages = images;
                              posting.type = residenceSelected;
                              posting.host =
                                  AppConstants.createContactFromUserModel();
                              posting.setImageNames();
                              //if this new or old post
                              posting.rating = 0;
                              posting.bookings = [];
                              posting.reviews = [];
                              await FireBaseUserFunctions
                                  .addPostInfoToFirestore();
                                  setState(() {
                              isLoading = false;
                                
                              });
                              await FireBaseUserFunctions.addImagesToFirebase();
                              // setState(() {
                              // isLoading = false;
                                
                              // });
                              Get.to(const HostScreen());
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
