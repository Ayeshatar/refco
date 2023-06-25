import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:refapp/model/User_model.dart';

class authenticationProvider with ChangeNotifier {
  bool? value = false;
  bool isUserCreated = false;
  String userRegisterationMessage = "";
  bool isUserLoggedIn = false;
  String userLoginMessage = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ////////////////////////////////////////////

  Future<void> createUser(String email,
      String password,
      String name,
      String referredBy,
      String referCode,) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      int dateTime = DateTime
          .now()
          .millisecondsSinceEpoch;
      String referCodetest = "AR" + "$dateTime";

      UserModel model = UserModel(
        email: email,
        name: name,
        myReferCode: referCodetest,
        referralCode: referCode,
        referredBy:  referredBy,
        countRefer: 2,
      );

      DocumentReference reference = await firestore.collection("User").doc();
      String id = reference.id;

      if (referCode.length > 0) {
        int referValue = getUserModel[0].countRefer! - 1;
        await firestore
            .collection("User")
            .doc(getUserModel[0].email)
            .update({"countRefer": referValue});

        await firestore
            .collection("User")
            .doc(getUserModel[0].email)
            .collection("ReferUser")
            .doc(email)
            .set(model.UserToMap());
      }
      await firestore
          .collection("User")
          .doc(email)
          .set(model.UserToMap())
          .onError((error, stackTrace) {
        throw error!;
      });





      userRegisterationMessage = "Sign Up Successfull...Thanks You...";
      isUserCreated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        userRegisterationMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        userRegisterationMessage = "The account already exists for that email.";
      } else {
        userRegisterationMessage = "Something went wrong else ${e.toString()}";
      }
      isUserCreated = false;
      notifyListeners();
    } catch (e) {
      isUserCreated = false;
      userRegisterationMessage = "Something went wrong ${e.toString()}";
      notifyListeners();
      print(e);
    }
  }

  bool isverifyfield = false;

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isUserLoggedIn = true;
      userLoginMessage = "Welcome.! Sign in Successfull";
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        userLoginMessage = "No user found for that email..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        userLoginMessage = "Wrong password provided for that user..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else {
        userLoginMessage = "Something went wrong..!";
        isUserLoggedIn = false;
        notifyListeners();
      }
    }
  }

  List<UserModel> getUserModel = [];

  mGetUserCode(String id) async {
    List<UserModel> getUserModel = [];
    await firestore
        .collection("User")
        .where("myReferCode", isEqualTo: id)
        .get()
        .then((value) =>
        value.docs.forEach((element) {
          getUserModel.add(UserModel.fromJson(element.data()));
        }));
    this.getUserModel = getUserModel;
    notifyListeners();
  }
  String _generateReferralCode(String name) {
    String code = name.substring(0, 3).toUpperCase();
    return code + Random().nextInt(999).toString();
    notifyListeners();
  }

  ///////////////////////////////////////////
  ///
  insertUser(String email, String refcode, String name, String password, String referredBy) async {
    String memberCount = "0";
//for first user
    await firestore
        .collection("membercount")
        .doc("vuJk1VWxyAAIMiPkAKO1")
        .get()
        .then((value) async {
      Map<String, dynamic> membercount = value.data()!;
      memberCount = membercount["count"].toString();
      if (memberCount == "0") {
        //for 1st User (centered node child)
        create(email, password);
        await firestore.collection("Users").doc().set({
          "email": email,
          "name": name,
          "refcode": "abc@123", //ref code for 1st user
          "referredBy": "user A",
          "membercount": memberCount,
        });
        //for increasing the number of member count
        int setcount = int.parse(memberCount) + 1;
        firestore.collection("membercount").doc("vuJk1VWxyAAIMiPkAKO1").set({
          "count": setcount.toString(),
        });
      }
      else if (memberCount == "1" || memberCount == "2") {
        //for users 2nd and 3rd member (centered node child)
        await firestore
            .collection("Users")
            .where("refcode", isEqualTo: refcode)
            .get()
            .then((value) async {
          if (value.docs.isNotEmpty) {
            create(email, password);
            await firestore.collection("Users").doc().set({
              "email": email,
              "name": name,
              "refcode": refcode,
              "referredBy":referredBy,
              "membercount": memberCount,
            });
//for increasing the number of member count
            int setcount = int.parse(memberCount) + 1;
            firestore.collection("membercount").doc("vuJk1VWxyAAIMiPkAKO1").set(
                {
                  "count": setcount.toString(),
                });
          }
        });
      } else {
        //for all users except 1st 2nd and 3rd member (centered node child)
        create(email, password);
        await firestore.collection("Users").doc().set({
          "email": email,
          "name": name,
          "refcode": refcode,
          "referredBy": referredBy,
          "membercount": memberCount,
        });
        //for increasing the number of member count
        int setcount = int.parse(memberCount) + 1;
        firestore.collection("membercount").doc("vuJk1VWxyAAIMiPkAKO1").set({
          "count": setcount.toString(),
        });
      }

      print(membercount["count"].toString());
    }).onError((error, stackTrace) {});

//
  }


  create(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      userRegisterationMessage = "Sign Up Successfull...Thanks You...";
      isUserCreated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        userLoginMessage = "No user found for that email..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        userLoginMessage = "Wrong password provided for that user..!";
        isUserLoggedIn = false;
        notifyListeners();
      } else {
        userLoginMessage = "Something went wrong..!";
        isUserLoggedIn = false;
        notifyListeners();
      }
    }
  }
}

