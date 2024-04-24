import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';

import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  static const routeName = '/add-post';
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController desController = TextEditingController();
  bool isLoading = false;

  // void postImgg(
  //   String username,
  //   String profImg,
  //   String uid,
  // ) async {
  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     String response = await FirestoreMethod()
  //         .uploadPost(_file!, username, profImg, uid, desController.text);
  //     if (response == "Success") {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       clearImage();
  //       showSnackbar(context, "POSTED");
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       showSnackbar(context, response);
  //     }
  //   } catch (e) {
  //     showSnackbar(context, e.toString());
  //   }
  // }

  // selectImg() async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: Text("Choose a Option"),
  //           children: [
  //             SimpleDialogOption(
  //               padding: EdgeInsets.all(20),
  //               child: Text("Take a picture"),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 Uint8List file = await pickImage(ImageSource.camera);
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               },
  //             ),
  //             SimpleDialogOption(
  //               padding: EdgeInsets.all(20),
  //               child: Text("Choose from Gallery"),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 Uint8List file = await pickImage(ImageSource.gallery);
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }

  // void clearImage() {
  //   setState(() {
  //     _file = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "POST",
                style: TextStyle(color: EColors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          isLoading
              ? LinearProgressIndicator(
                  color: Colors.blue,
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(''
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: desController,
                    decoration: InputDecoration(
                        hintText: 'Write about post', border: InputBorder.none),
                    maxLines: 8,
                  ),
                ),
                SizedBox(
                    height: 45,
                    width: 45,
                    child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')))))
              ],
            ),
          )
        ],
      ),
    );
  }
}
