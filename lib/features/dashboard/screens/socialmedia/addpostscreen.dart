import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/repository/profile_repository.dart';
import 'package:mental_healthapp/features/dashboard/repository/social_media_repository.dart';
import 'package:mental_healthapp/models/post_model.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/loading.dart';
import 'package:mental_healthapp/shared/utils/pick_image.dart';
import 'package:uuid/uuid.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  static const routeName = '/add-post';
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  TextEditingController desController = TextEditingController();
  bool isLoading = false;
  File? file;

  Future pickImage() async {
    file = await pickImageFromGallery(context);
    if (file != null) {
      setState(() {});
    }
  }

  Future addPost() async {
    setState(() {
      isLoading = true;
    });
    String postUid = const Uuid().v4();
    String? imageUrl;
    if (file != null) {
      imageUrl = await ref
          .read(socialMediaRepositoryProvider)
          .uploadPostPicture(file!, postUid);
    }
    PostModel post = PostModel(
      postUid: postUid,
      profileUid: FirebaseAuth.instance.currentUser!.uid,
      userName: ref.read(profileRepositoryProvider).profile!.profileName,
      description: desController.text,
      postTime: DateTime.now(),
      likes: 0,
      commentCount: 0,
      likesProfileUid: [],
      profilePic: ref.read(profileRepositoryProvider).profile!.profilePic,
      imageUrl: imageUrl,
      isGroupShare: false,
    );
    desController.clear();

    await ref.read(socialMediaRepositoryProvider).addPost(post);

    setState(() {
      isLoading = false;
    });
    if (mounted) {
      Navigator.pop(context);
    }
  }

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
    final size = MediaQuery.of(context).size;
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: EColors.primaryColor,
              actions: [
                TextButton(
                  onPressed: addPost,
                  child: const Text(
                    "POST",
                    style: TextStyle(color: EColors.white),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: size.width * 0.8,
                    width: size.width * 0.8,
                    decoration: file == null
                        ? BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          )
                        : BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: FileImage(file!),
                            ),
                          ),
                    child: file == null
                        ? const Center(
                            child: Text(
                              'No Image Selected',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: ref
                                      .read(profileRepositoryProvider)
                                      .profile!
                                      .profilePic ==
                                  null
                              ? const AssetImage('assets/images/man.png')
                                  as ImageProvider
                              : NetworkImage(ref
                                  .read(profileRepositoryProvider)
                                  .profile!
                                  .profilePic!),
                          radius: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: desController,
                          decoration: const InputDecoration(
                              hintText: 'Write about post',
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
