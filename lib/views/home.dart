import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_healthapp/views/consultscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff16A9B1),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff16A9B1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hi Jared",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "6 Feb,2024",
                                  style: GoogleFonts.openSans(
                                      color: Colors.grey[300], fontSize: 15),
                                ),
                              ],
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color(0xff16A9B1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.notifications_active,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(20),
                              fillColor: Color(0xff16A9B1),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 40,
                              ),
                              hintText: 'Search',
                              hintStyle:
                                  TextStyle(color: Colors.white, fontSize: 18),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "How Do You Feel?",
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              "...",
                              style: GoogleFonts.openSans(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            EmojiTile(
                              emoji: "😔",
                              txt: "Badly",
                            ),
                            EmojiTile(emoji: "😊", txt: "Fine"),
                            EmojiTile(emoji: "😃", txt: "Well"),
                            EmojiTile(emoji: "😁", txt: "Excellent")
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Excercises",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "...",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    ExcerciseTile(
                        color: Colors.orange,
                        title: "Speaking skills",
                        subTitle: "16 Excercises",
                        iconData: Icons.favorite),
                    ExcerciseTile(
                        color: Colors.blue,
                        title: "Reading Speed",
                        subTitle: "12 Excercises",
                        iconData: Icons.person),
                    ExcerciseTile(
                        color: Colors.red,
                        title: "Running",
                        subTitle: "16 Excercises",
                        iconData: Icons.run_circle)
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ExcerciseTile extends StatelessWidget {
  Color color;
  final String title;
  final String subTitle;
  final IconData iconData;

  ExcerciseTile(
      {super.key,
      required this.color,
      required this.title,
      required this.subTitle,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: color),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        iconData,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      subTitle,
                      style: GoogleFonts.openSans(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "...",
                style: GoogleFonts.openSans(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmojiTile extends StatelessWidget {
  final String emoji;
  final String txt;
  EmojiTile({super.key, required this.emoji, required this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            txt,
            style: GoogleFonts.openSans(
              color: Colors.white,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
