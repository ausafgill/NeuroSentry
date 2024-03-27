import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mental_healthapp/features/auth/controller/profile_controller.dart';
import 'package:mental_healthapp/features/dashboard/screens/goals/goals_home.dart';
import 'package:mental_healthapp/features/profile/screens/profile.dart';
import 'package:mental_healthapp/shared/constants/colors.dart';
import 'package:mental_healthapp/features/dashboard/screens/consultant/consultants_screen.dart';
import 'package:mental_healthapp/features/dashboard/screens/home.dart';
import 'package:mental_healthapp/shared/loading.dart';

class NavScreen extends ConsumerStatefulWidget {
  const NavScreen({super.key});

  @override
  ConsumerState<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends ConsumerState<NavScreen> {
  int _currIndex = 0;
  bool loading = true;

  final tabs = [
    const HomeScreen(),
    const ConsultScreen(),
    GoalHomeScreen(),
    const ProfileView(),
  ];
  @override
  void initState() {
    ref
        .read(profileControllerProvider)
        .downloadUserProfile()
        .then((value) => setState(() {
              loading = false;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currIndex,
                iconSize: 30,
                onTap: (value) {
                  setState(() {
                    _currIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: EColors.primaryColor,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.extension_rounded,
                        color: EColors.primaryColor,
                      ),
                      label: 'Addon'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.email,
                        color: EColors.primaryColor,
                      ),
                      label: 'Mails'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                        color: EColors.primaryColor,
                      ),
                      label: 'Profile')
                ]),
            body: tabs[_currIndex],
          );
  }
}
