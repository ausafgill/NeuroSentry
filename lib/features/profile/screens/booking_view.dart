import 'package:flutter/material.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/utils/goals_database.dart';
import 'package:provider/provider.dart'; // Import Provider
// Import your AppointmentsDB class

class BookingView extends StatefulWidget {
  const BookingView({Key? key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: EColors.primaryColor,
      ),
      body: Consumer<AppointmentsDB>(
        builder: (context, appointmentsDB, child) {
          // Retrieve list of appointments from AppointmentsDB
          List<Appointment> appointments = appointmentsDB.appointments;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              Appointment appointment = appointments[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: EColors.softGrey,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            appointment.name,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          IconButton(
                              onPressed: () {
                                final db = Provider.of<AppointmentsDB>(context,
                                    listen: false);
                                db.deleteAppointment(appointment);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: EColors.warning,
                              ))
                        ],
                      ),
                      Text(appointment.age),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                              leading: Icon(Icons.calendar_month),
                              title: Text(appointment.date),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              leading: Icon(Icons.timer),
                              title: Text(appointment.time),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
