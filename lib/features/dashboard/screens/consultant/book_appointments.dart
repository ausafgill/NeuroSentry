import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/utils/goals_database.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';
import 'package:provider/provider.dart';

class BookAppointment extends StatefulWidget {
  final String name;
  final String type;
  const BookAppointment({super.key, required this.name, required this.type});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _appDate = TextEditingController();
  TextEditingController _time = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _appDate.dispose();
    _time.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _appDate.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        title: const Text(
          "Book Appointments",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book Your Appointment with ${widget.name} ",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  widget.type,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                HelperTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Return null if the input is valid
                    },
                    htxt: "Enter Name",
                    iconData: Icons.person,
                    controller: _nameController,
                    keyboardType: TextInputType.name),
                HelperTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Return null if the input is valid
                    },
                    htxt: 'Enter age',
                    iconData: Icons.numbers,
                    controller: _ageController,
                    keyboardType: TextInputType.number),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null; // Return null if the input is valid
                    },
                    controller: _appDate,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: const InputDecoration(
                        hintText: "Select Appointment Date",
                        fillColor: EColors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.calendar_month_outlined)),
                  ),
                ),
                HelperTextField(
                  htxt: "Enter Time",
                  iconData: FontAwesomeIcons.clock,
                  controller: _time,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                HelperButton(
                    name: 'Book Appointment',
                    onTap: () {
                      if (_key.currentState!.validate()) {
                        final db =
                            Provider.of<AppointmentsDB>(context, listen: false);
                        db.saveAppointment(
                            name: widget.name,
                            age: _ageController.text,
                            date: _appDate.text,
                            time: _ageController.text);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Booking Confirmed"),
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _ageController.clear();
                                        _appDate.clear();
                                        _nameController.clear();

                                        _time.clear();
                                      },
                                      icon: const Icon(Icons.done))
                                ],
                              );
                            });
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text(
                                  "Please Fill All The Fields In Correct Format"),
                            );
                          },
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
