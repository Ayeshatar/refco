import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:refapp/Providers/ValidationProvider.dart';
import 'package:refapp/UI/HomeScreen.dart';
import 'package:refapp/Widget/FlushbarWidget.dart';
import 'package:refapp/Widget/TextFieldWidget.dart';
import 'package:refapp/model/User_model.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/';
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referCode = TextEditingController();
  TextEditingController referredBy= TextEditingController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Consumer<authenticationProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textfieldcheck(
                  name: "Name",
                  controller: name,
                ),
                SizedBox(
                  height: 20,
                ),
                textfieldcheck(
                  name: "Email",
                  controller: email,
                ),
                SizedBox(
                  height: 20,
                ),
                textfieldcheck(
                  name: "Password",
                  controller: password,
                ),
                SizedBox(
                  height: 20,
                ),
                textfieldcheckNoValid(
                  name: "Referral Code",
                  controller: referCode,
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedLoadingButton(
                  controller: buttonController,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                    value.insertUser(email.text.toString(),referredBy.text.toString(), referCode.text.toString(), name.text.toString(), password.text.toString());
                    //   buttonController.start(); // start the loading animation
                    //   var user = await value.mGetUserCode(referCode.text);
                    //   if (user != null) {
                    //  //   buttonController.success(); // show success animation
                    //     // Navigate to next screen, pass userModel as parameter
                    //   } else {
                    //     // buttonController.error(); // show error animation
                    //     // // Show snackbar message
                    //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     //   content: Text(
                    //     //       "User not found. Please check the referral code."),
                    //     // ));
                    //   }
                    //  await value.mGetUserCode(referCode.text);
                      if (value.getUserModel.length == 1 &&
                          value.getUserModel[0].countRefer! > 0) {
                            buttonController.success();
                        await value.createUser(
                          email.text,
                          password.text,
                          name.text,
                          referCode.text,
                            referredBy.text,
                        );
                        if (value.isUserCreated) {
                        //  buttonController.success();
                          SuccessFlushbar(context, "Registartion",
                              "${value.userRegisterationMessage}");
                          Timer(Duration(seconds: 2), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                            buttonController.reset();
                          });
                        } else {
                        //  buttonController.error();
                          ErrorFlushbar(context, "Registartion",
                              "${value.userRegisterationMessage}");
                          Timer(Duration(seconds: 2), () {
                            buttonController.reset();
                          });
                        }
                      } else {}
                    } else {
                      buttonController.error();
                      Timer(Duration(seconds: 2), () {
                        buttonController.reset();
                      });
                    }
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
