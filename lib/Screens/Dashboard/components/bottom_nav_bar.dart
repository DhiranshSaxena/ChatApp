import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant.dart';

class BottomNavBar extends StatelessWidget {

  final bool isActive1= true;
  final bool isActive= false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: (){},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SvgPicture.asset(
                  "asset/icons/calendar.svg",
                  color: isActive1 ? kActiveIconColor : kTextColor,
                ),
                Text(
                  "Today",
                  style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){},
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
            onTap: (){},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SvgPicture.asset(
                  "asset/icons/Settings.svg",
                  color: isActive ? kActiveIconColor : kTextColor,
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
    );
  }
}