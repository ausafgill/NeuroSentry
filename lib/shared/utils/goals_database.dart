import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class GoalDataBase extends ChangeNotifier {
  final Box _myBox;

  GoalDataBase(this._myBox);

  void createDefault() {
    _myBox.put('GOALLIST', [
      ['No Goals Added', false]
    ]);
    notifyListeners();
  }

  void loadData() {
    notifyListeners();
  }

  List<dynamic> get goals => _myBox.get('GOALLIST', defaultValue: []);

  void saveTask(TextEditingController controller, BuildContext context) {
    List<dynamic> updatedGoals = [...goals];
    updatedGoals.add([controller.text, false]);
    _myBox.put('GOALLIST', updatedGoals);
    controller.clear();
    notifyListeners();
    Navigator.pop(context);
  }

  void deleteTask(int index) {
    List<dynamic> updatedGoals = [...goals];
    updatedGoals.removeAt(index);
    _myBox.put('GOALLIST', updatedGoals);
    notifyListeners();
  }

  void checkBox(int index, bool? value) {
    List<dynamic> updatedGoals = [...goals];
    updatedGoals[index][1] = !(updatedGoals[index][1] ?? false);
    _myBox.put('GOALLIST', updatedGoals);
    notifyListeners();
  }

  Future<void> clearHiveData() async {
    Hive.box('mybox').clear();
  }
}

class Appointment {
  final String name;
  final String time;
  final String age;
  final String date;

  Appointment({
    required this.name,
    required this.time,
    required this.age,
    required this.date,
  });
}

class AppointmentsDB extends ChangeNotifier {
  final Box myBox;

  AppointmentsDB({required this.myBox});

  void createDefault() {
    myBox.put('AppointmentList', []);
    notifyListeners();
  }

  void loadData() {
    notifyListeners();
  }

  List<Appointment> get appointments {
    return (myBox.get('AppointmentList', defaultValue: []) as List<dynamic>)
        .map((data) => Appointment(
              name: data['name'],
              time: data['time'],
              age: data['age'],
              date: data['date'],
            ))
        .toList();
  }

  void saveAppointment({
    required String name,
    required String time,
    required String age,
    required String date,
  }) {
    List<dynamic> updatedAppointments =
        List<dynamic>.from(myBox.get('AppointmentList', defaultValue: []));

    updatedAppointments.add({
      'name': name,
      'time': time,
      'age': age,
      'date': date,
    });

    myBox.put('AppointmentList', updatedAppointments);

    notifyListeners();
  }

  void deleteAppointment(Appointment appointment) {
    List<dynamic> updatedAppointments =
        List<dynamic>.from(myBox.get('AppointmentList', defaultValue: []));

    updatedAppointments.removeWhere((item) =>
        item['name'] == appointment.name &&
        item['time'] == appointment.time &&
        item['age'] == appointment.age &&
        item['date'] == appointment.date);

    myBox.put('AppointmentList', updatedAppointments);

    notifyListeners();
  }
}
