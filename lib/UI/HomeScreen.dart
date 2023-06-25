import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refapp/UI/Homescreen.dart';
import 'package:refapp/UI/TreeScreen.dart';
import 'package:refapp/UI/loginscreen.dart';
import 'package:refapp/UI/registartionscreen.dart';
import 'package:share_plus/share_plus.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home SCreen"),

        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () async {
              final sendingurl = "";
              await Share.share("Centered Node ReferalCode: abc@123".toString());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              width: 40,
              height: 40,
              child: Icon(
                Icons.share,
                color: Colors.yellow,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),],
        ),




      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * .8,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .orderBy("name", descending: false)
                    .snapshots(),
                builder: (
                  contex,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length < 1) {
                        return const Center(
                          child: Text("No Member"),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                        return ListTile(
                            leading: Text(
                          snapshot.data!.docs[index]['membercount'].toString(),
                        ),
                        subtitle: Text(
                          snapshot.data!.docs[index]['refcode'].toString(),
                        ),
                        title: Text(
                          snapshot.data!.docs[index]['email'].toString(),
                        ));
                      });
                    } else if (snapshot.hasError) {
                      return const Text("An Error Occour");
                    } else {
                      return const Text("Not Found");
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),

            // ListView.builder(
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return GratituteMomentsWidget(title: "jsdhckjshjkcskjcs",subtitle: "adjjkahxkjnxks",time: "wenj::",);
            //     }),
          ),
        ],
      ),
    );
  }
}
