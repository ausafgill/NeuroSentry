import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_healthapp/views/home.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: Column(children: [
          Container(
              decoration: BoxDecoration(color: Colors.blue[800]),
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
                              color: Colors.blue[600],
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
                          fillColor: Colors.blue[600],
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
                  ],
                ),
              )),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                  color: Colors.grey[100]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryTIle(
                        color: Colors.purple.shade400,
                        title: "Relationship",
                      ),
                      CategoryTIle(
                        color: Colors.blue.shade400,
                        title: "Career",
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CategoryTIle(
                        color: Colors.orange,
                        title: "Education",
                      ),
                      CategoryTIle(
                        color: Colors.red.shade400,
                        title: "Other",
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Consultant",
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
                      color: Colors.green.shade200,
                      title: "Bobby Singer",
                      subTitle: "Education",
                      iconData: Icons.music_note),
                  ExcerciseTile(
                      color: Colors.purple.shade200,
                      title: "Dean Winchester",
                      subTitle: "Career",
                      iconData: Icons.book)
                ],
              ),
            ),
          ))
        ]));
  }
}

class CategoryTIle extends StatelessWidget {
  Color color;
  final String title;
  CategoryTIle({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 160,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.openSans(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
