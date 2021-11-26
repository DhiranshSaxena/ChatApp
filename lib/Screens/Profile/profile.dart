import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Components/coming_soon.dart';
import 'package:lpchub/Screens/ChatScreen/chat_home.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/Memes/memes.dart';

import '../../constant.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget{
  final bool isActive1= true;
  final bool isActive= false;

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dash()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.dashcube,
                    color: isActive ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Meme()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // SvgPicture.asset(
                  //   "asset/icons/gym.svg",
                  //   color: isActive ? kActiveIconColor : kTextColor,
                  // ),
                  Icon(
                    LineAwesomeIcons.rocket_chat,
                    color: isActive ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Social",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComingSoon()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.laugh_face_with_beaming_eyes,
                    color: isActive ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Coming Soon",
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