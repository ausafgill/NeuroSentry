import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_healthapp/features/auth/screens/splash_screen.dart';
import 'package:mental_healthapp/firebase_options.dart';
import 'package:mental_healthapp/router.dart';
import 'package:mental_healthapp/shared/utils/goals_database.dart';
import 'package:mental_healthapp/theme/theme.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(
    ProviderScope(
      child: provider.MultiProvider(
        providers: [
          provider.Provider<Box>.value(value: box),
          provider.ChangeNotifierProvider(create: (_) => GoalDataBase(box)),
          provider.ChangeNotifierProvider(
            create: (_) => AppointmentsDB(myBox: box),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: EAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      home: const SplashScreen(),
    );
  }
}
