import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import 'package:refapp/Constant.dart';
import 'package:refapp/Providers/ValidationProvider.dart';
import 'package:refapp/UI/HomeScreen.dart';
import 'package:refapp/UI/registartionscreen.dart';
import 'package:refapp/Widget/FlushbarWidget.dart';
import 'package:refapp/Widget/TextFieldWidget.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/';
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RoundedLoadingButtonController buttonController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: Consumer<authenticationProvider>(builder: (context, value, child) {
        return 
        // Form(
        //   key: formKey,
        //   child: 
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  height: 50,
                ),
                RoundedLoadingButton(
                  controller: buttonController,
                  onPressed: () async {
                   // if (formKey.currentState!.validate()) {
                      await value.loginUser(email.text, password.text);
                      if (value.isUserLoggedIn) {
                        buttonController.success();
                        SuccessFlushbar(
                            context, "Sign In", "${value.userLoginMessage}");
                        Timer(Duration(seconds: 2), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                          buttonController.reset();
                        });
                      } else {
                        buttonController.error();
                        ErrorFlushbar(
                            context, "Sign in", "${value.userLoginMessage}");
                        Timer(Duration(seconds: 2), () {
                          buttonController.reset();
                        });
                      }
                    // } else {
                    //   buttonController.error();
                    //   Timer(Duration(seconds: 2), () {
                    //     buttonController.reset();
                    //   });
                    // }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationScreen()));
                  },
                  child: Text("I don't have an account? Sign Up"),
                ),
              ],
            ),
          );
        //);
      }),
    );
  }
}
