import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/features/chat/controller/chat_controller.dart';
import 'package:mental_healthapp/features/chat/screens/chat_consultant_screen.dart';
import 'package:mental_healthapp/features/dashboard/screens/consultant/book_appointments.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class ConsultantView extends ConsumerStatefulWidget {
  final String name;
  final String type;
  final String description;
  const ConsultantView({
    super.key,
    required this.name,
    required this.type,
    required this.description,
  });

  @override
  ConsumerState<ConsultantView> createState() => _ConsultantViewState();
}

class _ConsultantViewState extends ConsumerState<ConsultantView> {
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _reviewController.dispose();
    _ratingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: double.infinity,
                decoration: BoxDecoration(color: EColors.primaryColor),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: EColors.white, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          FontAwesomeIcons.userDoctor,
                          size: 80,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      widget.type,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: EColors.softGrey, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: IconButton(
                          onPressed: () async {
                            final chatModel = await ref
                                .read(chatControllerProvider)
                                .createOrGetOneToOneChatRoom(widget.name, true);
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatConsultantScreen(chatRoom: chatModel),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.chat),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About Doctor:',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.description,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Rating and Review:",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: List.generate(
                                  4,
                                  (index) => const Icon(Icons.star,
                                      color: Color.fromRGBO(255, 235, 59, 1))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: EColors.primaryColor,
                                      title: const Text('Add Review'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          HelperTextField(
                                              htxt: 'Give Review',
                                              iconData: Icons.file_copy,
                                              controller: _reviewController,
                                              keyboardType: TextInputType.text),
                                          HelperTextField(
                                              htxt: 'Give Rating',
                                              iconData: Icons.star_border,
                                              controller: _reviewController,
                                              keyboardType: TextInputType.text)
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              "Save",
                                              style: TextStyle(
                                                  color: EColors.white),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: EColors.white),
                                            ))
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: EColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Add Review',
                                  style: TextStyle(
                                      color: EColors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: 150,
                          child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text('User Name'),
                                    subtitle: Text(
                                        'He is a very good and reliable doctor'),
                                    trailing: Text('3/5'),
                                  ),
                                );
                              }))
                    ],
                  ),
                ),
              ),
              const Spacer(),
              HelperButton(
                  name: "Book Appointment",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookAppointment(
                          name: widget.name,
                          type: widget.type,
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
