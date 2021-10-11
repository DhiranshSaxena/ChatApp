import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/Components/loading.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/Welcome/welcome_screen.dart';
import 'package:provider/src/provider.dart';

import 'helper.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isLogged = false;

  ready() async {
    await HelperFunc.getUserloggedIn().then((value) {
      setState(() {
        isLogged = value!;
        print(value);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ready();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLogged == null ? Loading() : isLogged ? Dash() : Loading();
  }
}