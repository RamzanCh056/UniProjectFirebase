import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uni_project/splash_screen/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme:
      ThemeData(
          primaryColor:const Color (0xff00008b),
          colorScheme: const ColorScheme.light(
              primary: Color(0xffb2b2ff)
          ),
          appBarTheme: const AppBarTheme(
              color: Color(0xffb2b2ff)
          ),
          scaffoldBackgroundColor: const Color(0xFFfffafa),
          fontFamily: 'regular'),
      home:  const SplashScreen(),
    );
  }
}

