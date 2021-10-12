import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Screens/ChatScreen/chat_home.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';

import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant.dart';

class Meme extends StatefulWidget{
  @override
  _MemeState createState()  => _MemeState();
}

class _MemeState extends State<Meme>{
  final bool isActive1= true;
  final bool isActive= false;

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("SchoolHub", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo"),),
        ),
        backgroundColor: Color(0xFFF2BEA1),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10.0),
        //     child: IconButton(
        //       icon: Icon(Icons.camera_alt),
        //       onPressed: (){
        //         showModalBottomSheet(
        //             context: context,
        //             builder: (context){
        //               return Container(
        //                 height: MediaQuery.of(context).size.height*0.1,
        //                 width: MediaQuery.of(context).size.width,
        //                 decoration: BoxDecoration(
        //                     color: Color(0xFFF2BEA1),
        //
        //                 ),
        //                 child: Column(
        //                   children: [
        //                     Padding(
        //                       padding: const EdgeInsets.symmetric(horizontal: 150.0),
        //                       child: Divider(
        //                         thickness: 4.0,
        //                         color: Colors.black,
        //                       ),
        //                     ),
        //                     Row(
        //                       children: [
        //                         MaterialButton(
        //                           color: Color(0xFFF2BEA1),
        //                           onPressed: (){
        //                             Fluttertoast.showToast(msg: "Coming Soon!");
        //                           },
        //                           child: Text("Gallery", style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.w500,
        //                               fontSize: 20
        //                           ),),
        //                           elevation: 0.0,
        //                         ),
        //                         MaterialButton(
        //                           color: Color(0xFFF2BEA1),
        //                           onPressed: (){},
        //                           child: Text("Camera", style: TextStyle(
        //                               color: Colors.black,
        //                               fontWeight: FontWeight.w500,
        //                               fontSize: 20
        //                           ),),
        //                           elevation: 0.0,
        //                         )
        //                       ],
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                     ),
        //                   ],
        //                 ),
        //               );
        //             });
        //       },
        //     ),
        //   )
        // ],
      ),
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
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChatScreen()));
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
                    "Messages",
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
                  Icon(
                    LineAwesomeIcons.laugh_face_with_beaming_eyes,
                    color: isActive1 ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Memes",
                    style: TextStyle(color: isActive1 ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: feedBody(context),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          ),
        ),
      ),
    );
  }
}