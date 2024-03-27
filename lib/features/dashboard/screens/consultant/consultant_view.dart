import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/features/chat/controller/chat_controller.dart';
import 'package:mental_healthapp/features/chat/screens/chat_screen.dart';
import 'package:mental_healthapp/features/dashboard/screens/consultant/book_appointments.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
      ),
      body: Column(
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
                            .createOrGetChatRoom(widget.name);
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChatScreen(chatRoom: chatModel),
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
              ],
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
    );
  }
}
