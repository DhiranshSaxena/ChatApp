import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Components/support.dart';
import 'package:lpchub/Screens/Alumni/components/details.dart';
import 'package:lpchub/constant.dart';
import 'package:lpchub/functions/post_options.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

class QuestionScreen extends StatefulWidget{

  final String docName;
  QuestionScreen({required this.docName});

  @override
  _QuestionScreenState createState() => _QuestionScreenState(docName);
}

class _QuestionScreenState extends State<QuestionScreen> {

  String? displayName, displayPic, profession, description, question1, answer1,
      question2, answer2, question3, answer3, question4, answer4, question5,
      answer5;

  String? link = "https://www.buymeacoffee.com/SchaffenSofts";

  String Name = "";

  String docName;

  _QuestionScreenState(this.docName);

  late String myName, myProfilePic, myUserName, myEmail;


  getMyInfoFromSharedPreferences() async {
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreferences();
    setState(() {});
  }

  Details details = Details();

  void getDetails() async {
    var sn = FirebaseFirestore.instance.collection('alumni').doc(docName)
        .get()
        .then((value) {
      setState(() {
        details.displayname = (value.data() as dynamic)['displayName'];
        details.description = (value.data() as dynamic)['Description'];
        details.profession = (value.data() as dynamic)['Profession'];
        details.displaypic = (value.data() as dynamic)['displayPic'];
        details.question1 = (value.data() as dynamic)['Question1'];
        details.answer1 = (value.data() as dynamic)['Answer1'];
        details.question2 = (value.data() as dynamic)['Question2'];
        details.answer2 = (value.data() as dynamic)['Answer2'];
        details.question3 = (value.data() as dynamic)['Question3'];
        details.answer3 = (value.data() as dynamic)['Answer3'];
        details.question4 = (value.data() as dynamic)['Question4'];
        details.answer4 = (value.data() as dynamic)['Answer4'];
        details.question5 = (value.data() as dynamic)['Question5'];
        details.answer5 = (value.data() as dynamic)['Answer5'];
      });
    });
  }

  Likes totalLikes = Likes();
  Colour colour = Colour();

  void heartColour() async {
    FirebaseFirestore.instance.collection('alumni').doc(docName).collection(
        'Likes').doc(myName).get().then((value) =>
    {
      if(value.exists){
        setState(() {
          colour.heartColour = true;
        })
      }
      else
        {
          setState(() {
            colour.heartColour = false;
          })
        }
    });
  }

  void getLikesComment() async {
    var query = FirebaseFirestore.instance.collection('alumni')
        .doc(docName)
        .collection('Likes');
    var snapshot = await query.get();
    var count = snapshot.size;

    var query1 = FirebaseFirestore.instance.collection('alumni')
        .doc(docName)
        .collection('comments');
    var snapshot1 = await query1.get();
    var countComment = snapshot1.size;

    setState(() {
      totalLikes.likes = count.toString();
      totalLikes.comment = countComment.toString();
    });
  }


  @override
  void initState() {
    onScreenLoaded();
    getDetails();
    getLikesComment();
    heartColour();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Image(image: AssetImage(
                                  "asset/images/alumni_coverpic.png")),
                              Positioned(
                                top: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 1,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      child: CircleAvatar(
                                        radius: 55,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          details.displaypic,
                                        ),
                                      ),
                                      radius: 60,
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            clipBehavior: Clip.none,
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Text(
                                      details.displayname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18
                                      ),
                                    ),
                                    Text(details.profession),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.description),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        details.question1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.answer1),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        details.question2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.answer2),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        details.question3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.answer3),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        details.question4,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.answer4),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15),
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(
                                        details.question5,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Text(details.answer5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text(
              "Comments",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: Icon(
                          LineAwesomeIcons.heart,
                          color: colour.heartColour ? Colors.red : Colors.black,
                        ),
                        onTap: () {
                          PostFunctions().addLike(
                              context, details.displayname, myName);
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            PostFunctions().showLikes(
                                context, details.displayname);
                          },
                          child: Container(child: Text(totalLikes.likes))),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          PostFunctions().showCommentSheet(
                              context, details.displayname);
                        },
                        child: Icon(
                            LineAwesomeIcons.alternate_comment
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            PostFunctions().showLikes(
                                context, details.displayname);
                          },
                          child: Container(child: Text(totalLikes.comment))),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Support()));
                    },
                    child: Text("Sponsor", style: TextStyle(
                      color: Colors.amber.shade700,
                      fontSize: 20,
                    ),),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0.0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.amber.shade700)
                          ),
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}