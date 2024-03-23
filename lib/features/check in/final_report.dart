import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

class FinalCheckInReport extends StatefulWidget {
  final List questions;
  const FinalCheckInReport({super.key, required this.questions});

  @override
  State<FinalCheckInReport> createState() => _FinalCheckInReportState();
}

class _FinalCheckInReportState extends State<FinalCheckInReport> {
  List emotionTile = [
    ['Mindset based on mood', 'assets/images/emotion.png'],
    ['My Sleep', 'assets/images/sleep.png'],
    ['Overcome Stress', 'assets/images/fear.png'],
    ['My Nutrition', 'assets/images/diet.png'],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EColors.primaryColor,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            color: EColors.primaryColor,
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "My CheckIn",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    color: Colors.blue,
                                    value: 40,
                                    title: 'A',
                                    radius: 20,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.green,
                                    value: 20,
                                    title: 'B',
                                    radius: 30,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.red,
                                    value: 20,
                                    title: 'C',
                                    radius: 20,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  PieChartSectionData(
                                    color: Colors.yellow,
                                    value: 10,
                                    title: 'D',
                                    radius: 20,
                                    titleStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                                sectionsSpace: 0,
                                centerSpaceRadius: 30,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Your daily progress!",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    HelperButton(name: 'Journal', onTap: () {}),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CheckInTile(
                          img: emotionTile[0][1],
                          title: emotionTile[0][0],
                        ),
                        CheckInTile(
                          img: emotionTile[1][1],
                          title: emotionTile[1][0],
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CheckInTile(
                            img: emotionTile[2][1],
                            title: emotionTile[2][0],
                          ),
                          CheckInTile(
                            img: emotionTile[3][1],
                            title: emotionTile[3][0],
                          ),
                        ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckInTile extends StatelessWidget {
  final String img;
  final String title;
  const CheckInTile({super.key, required this.img, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.16,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              color: EColors.softGrey, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Image.asset(
                img,
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
    );
  }
}
