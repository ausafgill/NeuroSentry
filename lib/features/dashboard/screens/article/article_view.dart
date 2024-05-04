import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ArticleView extends StatefulWidget {
  final String articleDes;
  final String videoUrl;
  final IconData iconData;
  const ArticleView(
      {super.key,
      required this.articleDes,
      required this.iconData,
      required this.videoUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        title: Text(
          "ARTICLE VIEW",
          style: Theme.of(context).textTheme.headlineSmall,),
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
