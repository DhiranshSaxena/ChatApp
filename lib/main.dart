import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/services.dart';
import 'package:lpchub/functions/wrapper.dart';
import 'constant.dart';


Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SchoolHub',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Wrapper(),
    );
  }
}