// ignore_for_file: avoid_print
import 'package:airbnb_clone/data/firebase/FireBaseUserFunctions.dart';
import 'package:airbnb_clone/presentation/auth/screens/register_screen.dart';
import 'package:airbnb_clone/presentation/auth/widgets/custom_elevated_button.dart';
import 'package:airbnb_clone/presentation/auth/widgets/custom_text_field.dart';
import 'package:airbnb_clone/utils/styles_class.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // static const nav = 'LoginScreen';

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
                    Image.asset('assets/images/splash.png'),
                    Text(
                      'Hello, Welcome Back',
                      style: Styles.FirstFont,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                      obscureText: false,
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
                    CustomElvatedButton(
                      text: 'Login',
                      backgroundColor: Styles.primaryColor,
                      borderSideColor: Colors.transparent,
                      style: Styles.login,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FireBaseUserFunctions().login(
                              _emailController.text, _passController.text);
                          Fluttertoast.showToast(
                              msg: 'Valid and LOgin Success',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 18.0);
                          print('Login Success');
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
                          'Dont Have an Account?',
                          style: Styles.login2,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            'Register',
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
}
