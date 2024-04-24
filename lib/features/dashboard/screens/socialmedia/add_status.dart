import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';

class AddStatusScreen extends StatefulWidget {
  static const routeName = '/add-status';
  const AddStatusScreen({super.key});

  @override
  State<AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<AddStatusScreen> {
  TextEditingController _statusController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _statusController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        title: const Text(
          'Update Status',
          style: TextStyle(color: EColors.white, fontSize: 20),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "POST",
                style: TextStyle(color: EColors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _statusController,
              decoration: const InputDecoration(
                hintText: 'Share Your Thoughts',
                prefixIcon: Icon(
                  FontAwesomeIcons.pen,
                ),
              ),
              maxLines: 15,
            ),
          )
        ],
      ),
    );
  }
}
