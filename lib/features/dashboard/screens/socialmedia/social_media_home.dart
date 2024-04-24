import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/features/dashboard/screens/socialmedia/add_status.dart';
import 'package:mental_healthapp/features/dashboard/screens/socialmedia/addpostscreen.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class SocialHome extends StatefulWidget {
  static const routeName = '/social-home';
  const SocialHome({super.key});

  @override
  State<SocialHome> createState() => _SocialHomeState();
}

class _SocialHomeState extends State<SocialHome> {
  TextEditingController _postController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _postController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: EColors.softGrey,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                          radius: 20,
                        ),
                        Expanded(
                            child: HelperTextField(
                                htxt: 'Share Your Thoughts',
                                iconData: FontAwesomeIcons.pen,
                                controller: _postController,
                                keyboardType: TextInputType.text))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddPostScreen.routeName);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.photoFilm,
                                )),
                            Text("MEDIA")
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  FontAwesomeIcons.calendar,
                                )),
                            Text("EVENT")
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AddStatusScreen.routeName);
                                },
                                icon: Icon(
                                  FontAwesomeIcons.newspaper,
                                )),
                            Text("STORY")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return PostCard();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isAnimating = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: EColors.black)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      radius: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'User NAME',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ]),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text("Follow"),
                                    ),
                                    ListTile(
                                      title: Text("Unfollow"),
                                    ),
                                    ListTile(
                                      title: Text("Message"),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.more_vert))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1690304404143-cf0d706f4f59?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite_border,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.chat_bubble,
                          )),
                    ],
                  ),
                  Icon(Icons.bookmark_border)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [Text('LIKES')],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Text(
                    'username',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('des')
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "View All 200 comments",
                  ),
                  Text('Date'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
