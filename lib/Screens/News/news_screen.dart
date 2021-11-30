import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Screens/ChatScreen/chat_home.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:timeago/timeago.dart' as timeago;


import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpchub/Screens/Memes/components/image_upload.dart';

import '../../constant.dart';

class NewsScreen extends StatefulWidget{
  @override
  _NewsScreenState createState()  => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>{

  final bool isActive1= true;
  final bool isActive= false;

  showSnackBar(String text, Duration d){
    final snackBar = SnackBar(content: Text(text), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff686795),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("SchoolHub", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo"),
        ),
        backgroundColor: Color(0xff686795),

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
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("news").orderBy("timeStamp", descending: true).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return (const Center(child: Text("No Image uploaded"),));
              }
              else{
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index){
                      String memeUrl = snapshot.data!.docs[index]['url'];
                      String profileUrl = snapshot.data!.docs[index]['profileUrl'];
                      Timestamp timeStamp = snapshot.data!.docs[index]['timeStamp'];
                      String displayName = snapshot.data!.docs[index]['displayName'];
                      return MemeTile(memeUrl, profileUrl, timeStamp, displayName);
                    });
              }
            },
          ),
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          ),
        ),
      ),
    );
  }

  Widget MemeTile(String memeUrl, String profileUrl, Timestamp timestamp ,String displayName){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      profileUrl,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayName, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),),
                    Text(timeago.format(timestamp.toDate()))
                  ],
                ),
              ],
            ),
            Image.network(memeUrl, fit: BoxFit.cover,),
          ],
        ),
      ),
    );
  }

}