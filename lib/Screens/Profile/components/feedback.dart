import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

class FeedbackScreen extends StatefulWidget{
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen>{

  final _formkey = GlobalKey<FormState>();
  String? feedback = "";

  var _controller = TextEditingController();

  showSnackBar(String text, Duration d){
    final snackBar = SnackBar(content: Text(text), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  late String myName, myUserName, myEmail;

  getMyInfoFromSharedPreferences() async{
    myName = (await SharedPreferenceHelper().getDisplayName())!;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF817DC0),
        title: Text("Feedback", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo"),),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 280,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                            child: Flexible(
                              child: TextFormField(
                                controller: _controller,
                                validator: (value){
                                  if((value == null)){
                                    return 'Invalid E-Mail';
                                  }
                                  else{
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                key: _formkey,
                                onChanged: (value){
                                  feedback = value;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Give Us A FeedBack ;)'
                                ),
                              ),
                            ),
                          ),
                          elevation: 5.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 150,
                      height: 40,
                      child: MaterialButton(
                        color: Color(0xFF817DC0),
                        onPressed: () async{
                          FirebaseFirestore fb = FirebaseFirestore.instance;
                          await fb.collection('feedback').add({'Name' : myName, 'Username' : myUserName, 'Email' : myEmail,'feedback' : feedback}).whenComplete(() {
                            showSnackBar("Submitted.", Duration(milliseconds: 400));
                            _controller.clear();
                          });
                        },
                        child: Text("Submit", style: TextStyle(color: Colors.white),),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Notes -", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("1. We are not saving your details. It will be completely anonymous."),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("2. Please, Be respectful while giving the feedbacks. You can suggest anything or any changes but we don't accept harsh language.")
                              ],
                            )
                        ),
                        elevation: 5.0,
                      ),
                    ),
                  ),
                    SizedBox(
                      height: 30,
                    ),],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}