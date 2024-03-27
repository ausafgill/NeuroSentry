import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/dashboard/controller/dashboard_controller.dart';
import 'package:mental_healthapp/features/dashboard/screens/home.dart';
import 'package:mental_healthapp/models/article_model.dart';

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
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
          ),
          child: Expanded(
            child: FutureBuilder<List<ArticleModel>>(
              future: ref
                  .read(dashboardControllerProvider)
                  .getArticlesFromFirebase(),
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
        ),
      ),
    );
  }
}
