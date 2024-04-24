import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/dashboard/controller/dashboard_controller.dart';
import 'package:mental_healthapp/features/dashboard/screens/home.dart';
import 'package:mental_healthapp/models/article_model.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';

class ArticlesViewScreen extends ConsumerStatefulWidget {
  const ArticlesViewScreen({super.key});

  @override
  ConsumerState<ArticlesViewScreen> createState() => _ArticlesViewScreenState();
}

class _ArticlesViewScreenState extends ConsumerState<ArticlesViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50),
            topLeft: Radius.circular(50),
          ),
        ),
        child: FutureBuilder<List<ArticleModel>>(
          future:
              ref.read(dashboardControllerProvider).getArticlesFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: EColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Show Bookmarks",
                    style: TextStyle(color: EColors.white, fontSize: 16),
                  ),
                  Icon(
                    Icons.bookmark,
                    color: EColors.white,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
