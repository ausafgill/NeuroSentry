import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_healthapp/features/auth/controller/auth_controller.dart';
import 'package:mental_healthapp/features/auth/controller/profile_controller.dart';
import 'package:mental_healthapp/features/auth/repository/profile_repository.dart';
import 'package:mental_healthapp/features/auth/screens/login_screen.dart';
import 'package:mental_healthapp/features/profile/screens/book_marks_screen.dart';
import 'package:mental_healthapp/features/profile/screens/booking_view.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/shared/utils/pick_image.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  Future logout() async {
    ref.read(authControllerProvider).signOutUser();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Future pickImage() async {
    File? file = await pickImageFromGallery(context);
    if (file != null) {
      await ref.read(profileControllerProvider).uploadPicture(file);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: ref
                                .read(profileRepositoryProvider)
                                .profile!
                                .profilePic ==
                            null
                        ? const AssetImage('assets/images/man.png')
                        : NetworkImage(ref
                            .read(profileRepositoryProvider)
                            .profile!
                            .profilePic!) as ImageProvider,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: size.width * 0.6,
                child: GestureDetector(
                  onTap: pickImage,
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.cyan,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            ref.read(profileControllerProvider).getProfileName(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Following: ${ref.read(profileRepositoryProvider).profile!.followingCount}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'Followers: ${ref.read(profileRepositoryProvider).profile!.followerCount}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
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
            name: 'Book Marks',
            iconData: FontAwesomeIcons.clock,
            ontap: () =>
                Navigator.pushNamed(context, BookMarksScreen.routeName),
          ),
          ProfileTile(
            name: 'Settings',
            iconData: Icons.settings,
            ontap: () {},
          ),
          ProfileTile(
            name: 'Logout',
            iconData: Icons.logout,
            ontap: () {
              Hive.box('mybox').clear();
              logout();
            },
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
