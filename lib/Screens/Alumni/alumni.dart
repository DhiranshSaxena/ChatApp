import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/Memes/memes.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../constant.dart';
import 'components/questions_screen.dart';

class Alumni extends StatefulWidget{

  @override
  _AlumniState createState() => _AlumniState();
}

class _AlumniState extends State<Alumni>{

  final bool isActive1 = true;
  final bool isActive = false;

  String displayName = "", displayPic = "", description = "", profession = "", timeStamp = "";
  late Timestamp TimeStamp;

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
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.dashcube,
                    color: isActive1 ? kBlueColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(color: isActive1 ? kBlueColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dash()));
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
                    color: isActive ? kBlueColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Social",
                    style: TextStyle(color: isActive ? kBlueColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Meme()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.laugh_face_with_beaming_eyes,
                    color: isActive ? kBlueColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Coming Soon",
                    style: TextStyle(color: isActive ? kBlueColor : kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("SchoolHub", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo")),
        backgroundColor: Color(0xff686795),
      ),
      body: feedBody(context),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("alumni").orderBy("timeStamp", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return (const Center(child: Text("It is Empty Here!"),));
            }
            else{
              List<AlumniTitlePanel> panels = [];
              final details = snapshot.data!.docs;
              for(var detail in details){
                final displayName = (detail.data() as dynamic)["displayName"];
                final displayPic = (detail.data() as dynamic)["displayPic"];
                final description = (detail.data() as dynamic)["Description"];
                final profession = (detail.data() as dynamic)["Profession"];
                final TimeStamp = (detail.data() as dynamic)["timeStamp"];
                final alumniTitlePanel = AlumniTitlePanel(
                  displayName : displayName,
                  displayPic: displayPic,
                  profession: profession,
                  timestamp: TimeStamp,
                  description: description,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionScreen(docName : displayName))
                    );
                  },
                );
                panels.add(alumniTitlePanel);
              }
              return ListView(
                  children: panels.isEmpty?[
                  SizedBox(
                    height: 10.0,
                  ),
                    Center(
                      child: Text(
                        'Nothing found',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 25.0),
                      ),
                    )
                    ] : panels,
                );
            }
          },
        ),
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
      ),
    );
  }
}


class AlumniTitlePanel extends StatefulWidget{

  final String displayName;
  final Function onTap;
  final String displayPic;
  final String description;
  final String profession;
  final Timestamp timestamp;

  const AlumniTitlePanel({required this.displayName,required this.displayPic,required this.profession, required this.timestamp,required this.description, required this.onTap});

  @override
  _AlumniTitlePanelState createState() => _AlumniTitlePanelState(displayName,displayPic,profession,timestamp,description,onTap);
}

class _AlumniTitlePanelState extends State<AlumniTitlePanel>{

  bool buttonPressed = false;
  final String displayName;
  final Function onTap;
  final String displayPic;
  final String description;
  final String profession;
  final Timestamp timestamp;

  _AlumniTitlePanelState(this.displayName,this.displayPic,this.profession,this.timestamp, this.description, this.onTap);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QuestionScreen(docName : displayName)));
        },
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Hero(
                          tag: 'displayImage',
                          child: Image.network(
                            displayPic,
                            width: 100,
                            height: 100,
                          ),
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(displayName, style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                      ),),
                      Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(profession, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                        ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Text(timeago.format(timestamp.toDate()), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),)
                    ],
                  ),
                ],
              ),
              Divider(
                thickness: 2.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left : 10.0, right: 10.0, bottom: 10.0),
                      child: Align(
                        child: Text(
                          description,
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}