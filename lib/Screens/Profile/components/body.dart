import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/constant.dart';
import 'package:lpchub/functions/auth_functions.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';
import 'package:lpchub/functions/wrapper.dart';
import 'package:flutter/services.dart';


class Body extends StatefulWidget{
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>{

  showSnackBar(String text, Duration d){
    final snackBar = SnackBar(content: Text(text), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  final AuthService _auth = AuthService();

  late String myName, myProfilePic, myUserName, myEmail;

  getMyInfoFromSharedPreferences() async{
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
  }

  onScreenLoaded() async{
    await getMyInfoFromSharedPreferences();
    setState(() {
    });
  }

  @override
  void initState(){
    onScreenLoaded();
    super.initState();
  }

  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image(
                          image: AssetImage("asset/images/coverpic.png"),
                        ),
                        Positioned(
                          top: 50,
                          width: MediaQuery.of(context).size.width*1,
                          child: Column(
                            children: [
                              CircleAvatar(
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      myProfilePic
                                  ),
                                ),
                                radius: 60,
                                backgroundColor: Colors.white,
                              ),

                              Text(myName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                              SizedBox(height: 10,),
                              Text(myUserName),
                              Text(myEmail),
                            ],
                          ),
                        ),
                      ],
                      clipBehavior: Clip.none,
                    ),
                    // ClipRRect(
                    //     borderRadius: BorderRadius.circular(200),
                    //     child: Image.network(myProfilePic, width: 120,height: 120,)
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: (){
                  showSnackBar("Coming Soon!", Duration(milliseconds: 1000));
                },
                child: Container(
                    height: MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        color: kActiveIconColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(child: Text("Upgrade to PRO", style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                    ),))
                ),
              ),
            ),
            InkWell(
              onTap: (){
              },
              child: Container(
                  margin: EdgeInsets.only(left: 18, right: 18),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LineAwesomeIcons.user_shield,
                        color: Colors.black,
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: Text(
                          "Privacy",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                          ),
                          ),
                        ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,

                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Icon(
                    LineAwesomeIcons.handshake,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      "Community Guidelines",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,

                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Icon(
                    LineAwesomeIcons.star,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      "Rate our App",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,

                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Icon(
                    LineAwesomeIcons.discord,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      "Join Our Discord",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,

                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                children: [
                  Icon(
                    LineAwesomeIcons.alternate_share,
                    color: Colors.black,
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: Text(
                      "Share SchoolHub",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white,
                    width: 1.0,
                    style: BorderStyle.solid,

                  ),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: InkWell(
                onTap: (){
                  _auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
                },
                child: Row(
                  children: [
                    Icon(
                      LineAwesomeIcons.alternate_sign_out,
                      color: Colors.black,
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Text(
                        "Sign-Out",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}