import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_button.dart';
import 'package:mental_healthapp/shared/constants/utils/helper_textfield.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneNum = TextEditingController();
  final TextEditingController _age = TextEditingController();
  bool isGenderSelected = false;
  String? genderValue;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _username.dispose();
    _dateController.dispose();
    _phoneNum.dispose();
    _age.dispose();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _onDropdownChanged(String? newValue) {
    if (newValue != null) {
      setState(() {
        isGenderSelected = true;
        genderValue = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Profile:",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            HelperTextField(
                htxt: 'Enter name',
                iconData: Icons.person,
                controller: _username,
                keyboardType: TextInputType.name),
            HelperTextField(
                htxt: 'Enter DOB',
                iconData: Icons.person,
                controller: _username,
                keyboardType: TextInputType.name),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _dateController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: const InputDecoration(
                    hintText: "Select DOB",
                    fillColor: EColors.softGrey,
                    border: InputBorder.none,
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_month_outlined)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: isGenderSelected
                      ? EColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  //border: Border.all(color: EColors.primaryColor),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    iconEnabledColor:
                        isGenderSelected ? EColors.light : EColors.black,
                    isExpanded: true,
                    underline: const SizedBox(),
                    borderRadius: BorderRadius.circular(20.0),
                    hint: Center(
                      child: Text(
                        genderValue ?? "Select Gender",
                        style: TextStyle(
                          color:
                              isGenderSelected ? EColors.light : EColors.black,
                        ),
                      ),
                    ),
                    focusColor: EColors.primaryColor,
                    onChanged: _onDropdownChanged,
                    items: <String>[
                      'Male',
                      'Female',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            HelperTextField(
                htxt: 'Enter Phone Number',
                iconData: Icons.call,
                controller: _phoneNum,
                keyboardType: TextInputType.number),
            HelperTextField(
                htxt: "Enter Age",
                iconData: Icons.numbers,
                controller: _age,
                keyboardType: TextInputType.number),
            Spacer(),
            HelperButton(name: 'Create Profile', onTap: () {})
          ],
        ),
      ),
    );
  }
}
