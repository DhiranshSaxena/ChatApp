import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/SignUp/signup_screen.dart';
import 'package:lpchub/functions/auth_functions.dart';
import 'package:lpchub/functions/helper.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

import '../../../constant.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  bool isHiddenPassword = true;

  String imageUrl = "https://firebasestorage.googleapis.com/v0/b/schoolhub-2.appspot.com/o/Default%2Fman.png?alt=media&token=01d42963-db52-4a01-8055-526fa6133692";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "asset/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "asset/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "asset/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formkey,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            onChanged: (value){},
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.email_outlined,
                                color: kPrimaryColor,
                              ),
                              hintText: "Your Email",
                              border: InputBorder.none,
                            ),
                              validator: (value){
                                if(!(value.toString().contains('@'))){
                                  return 'Invalid E-Mail';
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                setState((){
                                  email = value!;
                                });
                              }
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            obscureText: isHiddenPassword,
                            onChanged: (value){},
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: kPrimaryColor,
                              ),
                              suffixIcon: InkWell(
                                onTap: (){
                                  _tooglePasswordView();
                                },
                                child: Icon(
                                  Icons.visibility,
                                  color: kPrimaryColor,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                              validator: (value){
                                if(value.toString().length < 1){
                                  return 'Password Field is Empty';
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                setState((){
                                  password = value!;
                                });
                              }
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.8,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(29),
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                              color: kPrimaryLightColor,
                              onPressed: () async {
                                if(_formkey.currentState!.validate()){
                                  _formkey.currentState!.save();
                                  dynamic result = await _auth.login(email, password);
                                  if(result != null){
                                    HelperFunc.saveUserloggedIn(true);

                                    User? user = FirebaseAuth.instance.currentUser;
                                    SharedPreferenceHelper().saveUserEmail(email);
                                    SharedPreferenceHelper().saveUserId(user!.uid);
                                    SharedPreferenceHelper().saveUserName(email.replaceAll("@gmail.com", ""));
                                    SharedPreferenceHelper().saveUserProfile(imageUrl);
                                    SharedPreferenceHelper().getDisplayName();

                                    DocumentSnapshot ds = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
                                    String displayName = ds["name"].toString();

                                    SharedPreferenceHelper().saveUserDisplayName(displayName);

                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                      builder: (context) => Dash(),));
                                  }
                                }
                              },
                              child: Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              true ? "Don’t have an Account ? " : "Already have an Account ? ",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                true ? "Sign Up" : "Sign In",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tooglePasswordView(){
    if(isHiddenPassword == true){
      isHiddenPassword = false;
    }
    else{
      isHiddenPassword = true;
    }
    setState(() {

    });
  }

}