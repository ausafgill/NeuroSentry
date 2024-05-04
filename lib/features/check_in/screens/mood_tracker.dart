import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class MoodTracker extends StatefulWidget {
  static const routeName = '/mood-tracker';
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  String selectedEmoji = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: EColors.primaryColor,
        body: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            color: EColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'assets/images/man.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: EColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome User",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/mood.png',
                          height: 50,
                        ),
                        Text(
                          "Mood Tracker",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please select Your Current Mood',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedEmoji = '😕';
                                });
                              },
                              child: Text(
                                '😕',
                                style: selectedEmoji == '😕'
                                    ? const TextStyle(fontSize: 75)
                                    : const TextStyle(fontSize: 50),
                              )),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmoji = '😃';
                              });
                            },
                            child: Text(
                              '😃',
                              style: selectedEmoji == '😃'
                                  ? const TextStyle(fontSize: 75)
                                  : const TextStyle(fontSize: 50),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmoji = '😢';
                              });
                            },
                            child: Text(
                              '😢',
                              style: selectedEmoji == '😢'
                                  ? const TextStyle(fontSize: 75)
                                  : const TextStyle(fontSize: 50),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmoji = '😡';
                              });
                            },
                            child: Text(
                              '😡',
                              style: selectedEmoji == '😡'
                                  ? const TextStyle(fontSize: 75)
                                  : const TextStyle(fontSize: 50),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedEmoji = '😴';
                              });
                            },
                            child: Text(
                              '😴',
                              style: selectedEmoji == '😴'
                                  ? const TextStyle(fontSize: 75)
                                  : const TextStyle(fontSize: 50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Select words that describe your Mood',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MoodDescriptionTile(
                          title: 'HAPPY',
                        ),
                        MoodDescriptionTile(title: 'DEPRESSED'),
                        MoodDescriptionTile(title: 'ANGRY')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MoodDescriptionTile(
                          title: 'NERVOUS',
                        ),
                        MoodDescriptionTile(title: 'SAD'),
                        MoodDescriptionTile(title: 'GRATEFUL'),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MoodDescriptionTile(
                          title: 'LONELY',
                        ),
                        MoodDescriptionTile(title: 'EXCITED'),
                        MoodDescriptionTile(title: 'ANNOYED')
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    HelperButton(
                      name: 'Submit',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ))
        ]));
  }
}

class MoodDescriptionTile extends StatefulWidget {
  final String title;
  const MoodDescriptionTile({super.key, required this.title});

  @override
  State<MoodDescriptionTile> createState() => _MoodDescriptionTileState();
}

class _MoodDescriptionTileState extends State<MoodDescriptionTile> {
  bool ontap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ontap = !ontap;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: ontap ? EColors.primaryColor : EColors.softGrey,
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(widget.title),
        ),
      ),
    );
  }
}
