import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_healthapp/features/auth/controller/profile_controller.dart';
import 'package:mental_healthapp/features/chat/screens/message_screen.dart';
import 'package:mental_healthapp/features/dashboard/controller/dashboard_controller.dart';
import 'package:mental_healthapp/models/consultant_model.dart';
import 'package:mental_healthapp/features/dashboard/screens/consultant/consultant_view.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';

class ConsultScreen extends ConsumerStatefulWidget {
  const ConsultScreen({super.key});

  @override
  ConsumerState<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends ConsumerState<ConsultScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: EColors.primaryColor),
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
                              "Hi ${ref.read(profileControllerProvider).getProfileName()}",
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${DateTime.now().day} ${DateTime.now().month},${DateTime.now().year}",
                              style: GoogleFonts.openSans(
                                  color: Colors.grey[300], fontSize: 15),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: EColors.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MessageScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.chat,
                              color: EColors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _searchController,
                      onChanged: (query) => setState(() {}),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        fillColor: EColors.primaryColor,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 40,
                        ),
                        hintText: 'Search',
                        hintStyle:
                            const TextStyle(color: Colors.white, fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50)),
                      color: Colors.grey[100]),
                  child: Column(
                    children: [
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 200,
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.65,
                          ),
                          child: StreamBuilder<List<ConsultantModel>>(
                            stream: ref
                                .read(dashboardControllerProvider)
                                .getConsultantsFromFirebase(
                                  _searchController.text.trim(),
                                ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<ConsultantModel> consultants =
                                    snapshot.data ?? [];
                                return ListView.builder(
                                  itemCount: consultants.length,
                                  itemBuilder: (context, index) {
                                    ConsultantModel consultant =
                                        consultants[index];
                                    print(consultant.name);
                                    print('THIS IS THE REVIEW LADS HAHA');
                                    print(consultant.ratingsAndReview);
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ConsultantView(
                                              ratings:
                                                  consultant.ratingsAndReview,
                                              name: consultant.name,
                                              type: consultant.type,
                                              description:
                                                  consultant.description,
                                            ),
                                          ),
                                        );
                                      },
                                      child: ConsultantTile(
                                        title: consultant.name,
                                        subTitle: consultant.type,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsultantTile extends StatelessWidget {
  final Color color;
  final String title;
  final String subTitle;

  const ConsultantTile({
    super.key,
    this.color = Colors.blue,
    required this.title,
    required this.subTitle,
  });

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
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        FontAwesomeIcons.userTie,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
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

class CategoryTIle extends StatelessWidget {
  final Color color;
  final String title;
  const CategoryTIle({super.key, required this.color, required this.title});

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
