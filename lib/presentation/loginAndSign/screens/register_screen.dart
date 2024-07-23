// ignore_for_file: avoid_print

import 'dart:io';

import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/presentation/home/screen/home_screen.dart';
import 'package:airbnb_clone/presentation/loginAndSign/screens/login_screen.dart';
import 'package:airbnb_clone/presentation/loginAndSign/widgets/custom_elevated_button.dart';
import 'package:airbnb_clone/presentation/loginAndSign/widgets/custom_text_field.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _CityController = TextEditingController();
  final TextEditingController _BioController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isSecurePassword = true;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Styles.primaryColor,
                Styles.secondColor,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 2),
              stops: [0, 1],
              tileMode: TileMode.clamp),
        ),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/signup.png'),
                    Text(
                      'Create New Account',
                      style: Styles.FirstFont,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomTextFormField(
                      hint: 'First Name',
                      obscureText: false,
                      controller: _firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field is Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      hint: 'Last Name',
                      obscureText: false,
                      controller: _lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field is Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      hint: 'City',
                      obscureText: false,
                      controller: _CityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field is Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      hint: 'Bio',
                      obscureText: false,
                      controller: _BioController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field is Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      hint: 'Email',
                      obscureText: false,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'The Field is Empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomTextFormField(
                      hint: 'Password',
                      suffixIcon: passwordShow(),
                      obscureText: isSecurePassword,
                      controller: _passController,
                      validator: (value) {
                        if (value!.length < 7) {
                          return 'Password Length Must Be More Than 7';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: MaterialButton(
                        onPressed: () async {
                          var img = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (img != null) {
                            imageFile = File(img.path);
                            setState(() {
                              imageFile;
                            });
                          }
                        },
                        child: imageFile == null
                            ? const Icon(Icons.add_a_photo)
                            : CircleAvatar(
                                backgroundColor: Styles.primaryColor,
                                radius: MediaQuery.of(context).size.width / 5.0,
                                child: CircleAvatar(
                                  backgroundImage: FileImage(imageFile!),
                                  radius:
                                      MediaQuery.of(context).size.width / 5.2,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    CustomElvatedButton(
                      text: 'Create Account',
                      backgroundColor: Styles.primaryColor,
                      borderSideColor: Colors.transparent,
                      style: Styles.login,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Fluttertoast.showToast(
                              msg: 'Valid',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          print('valid');
                          try {
                            print('valid2');
                            await FireBaseUserFunctions().signUp(
                              _emailController.text,
                              _passController.text,
                              _BioController.text,
                              _firstNameController.text,
                              _lastNameController.text,
                              _CityController.text,
                              imageFile!,
                            );
                            print('acc created ');
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          } catch (e) {
                            Fluttertoast.showToast(
                              msg: 'Account creation failed: $e',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 18.0,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: 'Not Valid',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          print('Not valid');
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an Account?',
                          style: Styles.login2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Login',
                            style: Styles.login2.copyWith(
                                color: Styles.primaryColor, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordShow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Text(
          isSecurePassword ? 'show' : 'hide',
        ),
      ),
    );
  }
}
