import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_healthapp/models/goals_model.dart';
import 'package:mental_healthapp/features/dashboard/screens/goals/goals_detail.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/utils/goals_database.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';
import 'package:provider/provider.dart';

class GoalHomeScreen extends StatefulWidget {
  GoalHomeScreen({Key? key}) : super(key: key);

  @override
  State<GoalHomeScreen> createState() => _GoalHomeScreenState();
}

class _GoalHomeScreenState extends State<GoalHomeScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Goals",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: EColors.primaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "What area do you want to improve?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(GoalModel.goalList.length, (index) {
                    List<GoalModel> list = GoalModel.goalList;
                    return CategoryTIle(
                      img: list[index].img,
                      title: list[index].title,
                      goalList: list[index].goals,
                    );
                  }),
                ),
              ),
              const Divider(),
              HelperButton(
                name: 'Create Your Personalized Goal',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Add Goal"),
                        content: HelperTextField(
                          controller: controller, // Create a new controller
                          htxt: 'Enter Goal Details',
                          iconData: Icons.add,
                          keyboardType: TextInputType.name,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              final db = Provider.of<GoalDataBase>(context,
                                  listen: false);
                              db.saveTask(
                                  controller, context); // Call saveTask method
                            },
                            child: const Text("Save"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "My Goals:",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Consumer<GoalDataBase>(
                builder: (context, db, _) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: db.goals.length,
                      itemBuilder: (context, index) {
                        return GoalTile(
                          title: db.goals[index][0],
                          onCompleted: db.goals[index][1],
                          deleteTask: (context) {
                            db.deleteTask(index); // Call deleteTask method
                          },
                          onChanged: (value) {
                            db.checkBox(index, value); // Call checkBox method
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoalTile extends StatefulWidget {
  final String title;
  final bool onCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteTask;

  GoalTile(
      {super.key,
      required this.title,
      required this.onCompleted,
      required this.deleteTask,
      required this.onChanged});

  @override
  State<GoalTile> createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: widget.deleteTask,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 162, 233, 236),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Checkbox(
                value: widget.onCompleted,
                onChanged: widget.onChanged,
                activeColor: Colors.black,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    decoration: widget.onCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTIle extends StatelessWidget {
  final String img;
  final String title;
  final List goalList;
  CategoryTIle(
      {super.key,
      required this.img,
      required this.title,
      required this.goalList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GoalDetails(name: title, img: img, goalList: goalList)));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 90,
              width: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(img)),
                  color: EColors.grey,
                  borderRadius: BorderRadius.circular(25)),
            ),
            Container(
              height: 90,
              width: 160,
              color: Colors.white.withOpacity(0.4),
            ),
            Text(
              title,
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
