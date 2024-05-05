import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/repository/profile_repository.dart';
import 'package:mental_healthapp/features/dashboard/repository/social_media_repository.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ArticleView extends ConsumerStatefulWidget {
  final String articleTitle;
  final String articleDes;
  final String videoUrl;
  final IconData iconData;
  const ArticleView({
    super.key,
    required this.articleTitle,
    required this.articleDes,
    required this.iconData,
    required this.videoUrl,
  });

  @override
  ConsumerState<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
  }

  Future bookMarkArticle() async {
    if (ref
        .read(profileRepositoryProvider)
        .profile!
        .bookMarkArticles
        .contains(widget.articleTitle)) {
      await ref
          .read(socialMediaRepositoryProvider)
          .unBookMarkArticles(widget.articleTitle);
    } else {
      await ref
          .read(socialMediaRepositoryProvider)
          .bookMarkArticle(widget.articleTitle);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => bookMarkArticle(),
            icon: Icon(
              ref
                      .read(profileRepositoryProvider)
                      .profile!
                      .bookMarkArticles
                      .contains(widget.articleTitle)
                  ? Icons.bookmark
                  : Icons.bookmark_outline,
            ),
          )
        ],
        backgroundColor: EColors.primaryColor,
        title: Text(
          "ARTICLE VIEW",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Icon(
                widget.iconData,
                color: EColors.primaryColor,
                size: 200,
              ),
            ),
            Text(
              "Description",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.articleDes,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Recommended Video",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
