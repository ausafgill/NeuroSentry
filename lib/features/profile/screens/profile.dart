import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mental_healthapp/features/auth/controller/auth_controller.dart';
import 'package:mental_healthapp/features/auth/controller/profile_controller.dart';
import 'package:mental_healthapp/features/auth/screens/login_screen.dart';
import 'package:mental_healthapp/features/profile/screens/booking_view.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/utils/goals_database.dart';
import 'package:provider/provider.dart' as provider;

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  Future logout() async {
    ref.read(authControllerProvider).signOutUser();
    final db = provider.Provider.of<GoalDataBase>(context, listen: false);
    db.clearHiveData();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: EColors.primaryColor,
        title: Text(
          "Profile View",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/man.png'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            ref.read(profileControllerProvider).getProfileName(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ProfileTile(
            name: 'Achievement',
            iconData: FontAwesomeIcons.medal,
            ontap: () {},
          ),
          ProfileTile(
            name: 'Bookings',
            iconData: FontAwesomeIcons.file,
            ontap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BookingView()));
            },
          ),
          ProfileTile(
            name: 'Reminders',
            iconData: FontAwesomeIcons.clock,
            ontap: () {},
          ),
          ProfileTile(
            name: 'Settings',
            iconData: Icons.settings,
            ontap: () {},
          ),
          ProfileTile(
            name: 'Logout',
            iconData: Icons.logout,
            ontap: logout,
          )
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final String name;
  final IconData iconData;
  VoidCallback ontap;
  ProfileTile(
      {super.key,
      required this.name,
      required this.iconData,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 200, 242, 244),
              borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            leading: Icon(iconData),
            title: Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}
