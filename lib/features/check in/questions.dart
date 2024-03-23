import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_healthapp/features/check%20in/final_report.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  PageController _pageController = PageController();
  TextEditingController _questionController = TextEditingController();
  int currIndex = 0;
  List questions = [
    [
      'How would you rate your overall mood on a scale from 1 to 10, with 1 being very low and 10 being very high?',
      'assets/images/emotion.png',
    ],
    [
      'How would you describe your sleep patterns? Good,Bad or Worst?',
      'assets/images/sleep.png'
    ],
    [
      'How would you rate your stress levels lately? On a Scale of 1-10',
      'assets/images/fear.png'
    ],
    [
      'How would you rate your excercise levels lately? On a Scale of 1-10',
      'assets/images/running.png'
    ],
    ['Did you eat healty today? ', 'assets/images/diet.png'],
  ];
  List responses = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    setState(() {
                      currIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            questions[index][1],
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              questions[index][0],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _questionController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Your Answer',
                                  fillColor: EColors.softGrey,
                                  filled: true),
                            ),
                          )
                        ],
                      ),
                    );
                  })),
          Spacer(),
          HelperButton(
              name: 'Next',
              onTap: () {
                responses.add(_questionController.text);
                _questionController.clear();
                print(responses);
                if (currIndex < questions.length - 1) {
                  _pageController.nextPage(
                      curve: Curves.easeIn,
                      duration: const Duration(milliseconds: 300));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FinalCheckInReport(
                                questions: questions,
                              )));
                }
              })
        ],
      ),
    );
  }
}




















// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Questionnaire App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuestionnaireScreen(),
//     );
//   }
// }

// class QuestionnaireScreen extends StatefulWidget {
//   @override
//   _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
// }

// class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
//   final List<String> questions = [
//     "How are you feeling today?",
//     "Have you experienced any stress lately?",
//     "How well are you sleeping?",
//     "Do you have any concerns about your mental health?",
//     "Are you satisfied with your overall well-being?"
//   ];

//   int _currentPageIndex = 0;
//   List<String> responses = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mental Health Questionnaire'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: PageView.builder(
//               itemCount: questions.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPageIndex = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return QuestionPage(
//                   question: questions[index],
//                   onSubmitted: (response) {
//                     responses.add(response);
//                     if (index < questions.length - 1) {
//                       // Move to the next question
//                       _currentPageIndex++;
//                     } else {
//                       // Process the responses or navigate to the next screen
//                       print(responses);
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Question ${_currentPageIndex + 1} of ${questions.length}',
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

// class QuestionPage extends StatelessWidget {
//   final String question;
//   final Function(String) onSubmitted;

//   const QuestionPage({
//     Key? key,
//     required this.question,
//     required this.onSubmitted,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             question,
//             style: TextStyle(fontSize: 18),
//           ),
//           SizedBox(height: 16),
//           TextField(
//             autofocus: true,
//             onSubmitted: onSubmitted,
//             decoration: InputDecoration(
//               hintText: 'Type your answer here',
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
