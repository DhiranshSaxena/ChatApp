import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lpchub/constant.dart';

class ComingSoon extends StatefulWidget{
  _ComingSoonState createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon>{

  String email = "";
  var _controller = TextEditingController();

  showSnackBar(String text, Duration d){
    final snackBar = SnackBar(content: Text(text), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kActiveIconColor,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.05,
                  ),
                  Container(
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: Image(
                        image: AssetImage("asset/images/main.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("SchoolHub", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),),
                      Text("From Schaffen Softwares", style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.06,
              ),
              Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/scanner.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/salad.png",),
                                  width: 60,
                                  height: 60,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/article.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/job-search.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/webinar.png",),
                                  width: 55,
                                  height: 55,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/party.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/choose.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/pricing.png",),
                                  width: 55,
                                  height: 55,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/translate.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/tutorial.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/game-console.png",),
                                  width: 55,
                                  height: 55,
                                ),
                              )
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 40,
                              child: Container(
                                child: Image(
                                  image: AssetImage("asset/images/mobile-banking.png",),
                                  width: 50,
                                  height: 50,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              Container(
                margin: EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(29.5),
                ),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value){
                    email = value;
                  },
                  validator: (value){
                    if(!(value.toString().contains('@'))){
                      return 'Invalid E-Mail';
                    }
                    else{
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Your E-Mail For Updates",
                    icon: SvgPicture.asset("asset/icons/envelope.svg", width: 20, height: 20,),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 40,
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: () async{
                    FirebaseFirestore fb = FirebaseFirestore.instance;
                    await fb.collection('subscribe').add({'email' : email}).whenComplete(() {
                      showSnackBar("Submitted.", Duration(milliseconds: 400));
                      _controller.clear();
                    });
                  },
                  child: Text("Submit"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              Divider(
                color: Colors.white,
                thickness: 0.8,
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Text("Version 1.0.2", style: TextStyle(color: Colors.white),),
              ),
              Text("Schaffen Softwares", style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}