import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_healthapp/features/auth/controller/profile_controller.dart';
import 'package:mental_healthapp/features/chat/controller/chat_controller.dart';
import 'package:mental_healthapp/features/chat/screens/chat_screen.dart';
import 'package:mental_healthapp/features/check_in/screens/final_report.dart';
import 'package:mental_healthapp/features/check_in/screens/mood_tracker.dart';
import 'package:mental_healthapp/features/dashboard/controller/dashboard_controller.dart';
import 'package:mental_healthapp/features/dashboard/screens/articles_screen.dart';
import 'package:mental_healthapp/models/article_model.dart';
import 'package:mental_healthapp/features/dashboard/screens/article_view.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/enums/question_type.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  QuestionType? worstType;
  getWorstScoreType() {
    if (ref.read(profileControllerProvider).isCompletedCheckin()) {
      worstType = ref.read(profileControllerProvider).getWorstScore();
      setState(() {});
    }
  }

  @override
  void initState() {
    getWorstScoreType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.primaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff16A9B1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                onPressed: () async {
                                  final chatModel = await ref
                                      .read(chatControllerProvider)
                                      .createOrGetChatRoom("help");
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChatScreen(chatRoom: chatModel),
                                      ),
                                    );
                                  }
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
                        const Text("Ready for Daily CheckIn",
                            style:
                                TextStyle(color: EColors.white, fontSize: 24)),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            FinalCheckInReport.routename,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: EColors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              child: Text("Let's get started"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "How Do You Feel?",
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/mood.png',
                              height: 50,
                              width: 50,
                            ),
                            InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                MoodTracker.routeName,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: EColors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  child: Text("Let's track your today's mood"),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Articles for you...",
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ArticlesViewScreen(),
                                ),
                              ),
                              child: Text(
                                "See All...",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: FutureBuilder<List<ArticleModel>>(
                          future: ref
                              .read(dashboardControllerProvider)
                              .getWorstArticleType(worstType),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              List<ArticleModel> articles = snapshot.data ?? [];
                              return ListView.builder(
                                itemCount: articles.length,
                                itemBuilder: (context, index) {
                                  ArticleModel article = articles[index];
                                  return ExcerciseTile(
                                    color: article.color,
                                    title: article.title,
                                    subTitle: article.subTitle,
                                    iconData: article.iconData,
                                    articleDes: article.description,
                                    videoUrl: article.videoUrl,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
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
  final Color color;
  final String title;
  final String subTitle;
  final IconData iconData;
  final String articleDes;
  final String videoUrl;

  const ExcerciseTile(
      {super.key,
      required this.color,
      required this.title,
      required this.subTitle,
      required this.iconData,
      required this.articleDes,
      required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleView(
                        articleDes: articleDes,
                        iconData: iconData,
                        videoUrl: videoUrl,
                      )));
        },
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
                          borderRadius: BorderRadius.circular(15),
                          color: color),
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
                            fontSize: 16,
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
      ),
    );
  }
}
