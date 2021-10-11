import 'package:flutter/material.dart';
import 'package:lpchub/Screens/Register/components/body.dart';
import 'package:lpchub/constant.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
            "Sign-Up",
          style: TextStyle(),
        ),
      ),
      body: Body(),
    );
  }
}