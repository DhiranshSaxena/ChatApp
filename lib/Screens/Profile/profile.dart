import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpchub/Screens/ChatScreen/chat_home.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';

import '../../constant.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget{
  final bool isActive1= true;
  final bool isActive= false;

  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dash()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/calendar.svg",
                    color: isActive ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "Today",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/gym.svg",
                    color: isActive ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "All Exercises",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/Settings.svg",
                    color: isActive1 ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Body(),
    );
  }
}