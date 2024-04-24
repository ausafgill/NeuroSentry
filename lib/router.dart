import 'package:flutter/material.dart';
import 'package:mental_healthapp/features/auth/screens/create_profile.dart';
import 'package:mental_healthapp/features/check_in/screens/final_report.dart';
import 'package:mental_healthapp/features/check_in/screens/mood_tracker.dart';
import 'package:mental_healthapp/features/check_in/screens/questions.dart';
import 'package:mental_healthapp/features/dashboard/screens/socialmedia/add_status.dart';
import 'package:mental_healthapp/features/dashboard/screens/socialmedia/addpostscreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CreateProfile.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateProfile(),
      );
    case FinalCheckInReport.routename:
      return MaterialPageRoute(
        builder: (context) => const FinalCheckInReport(),
      );

    case MoodTracker.routeName:
      return MaterialPageRoute(
        builder: (context) => const MoodTracker(),
      );
    case QuestionScreen.routeName:
      List<dynamic> args = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
        builder: (context) => QuestionScreen(
          questionType: args[0],
        ),
      );
    case AddPostScreen.routeName:
      return MaterialPageRoute(builder: (context) => AddPostScreen());
    case AddStatusScreen.routeName:
      return MaterialPageRoute(builder: (context) => AddStatusScreen());

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('This Page Does not Exist'),
          ),
        ),
      );
  }
}
