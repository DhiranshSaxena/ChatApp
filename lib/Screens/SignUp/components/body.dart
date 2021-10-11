import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/Login/login_screen.dart';
import 'package:lpchub/Screens/Register/register_screen.dart';
import 'package:lpchub/functions/auth_functions.dart';
import 'package:lpchub/functions/database.dart';
import 'package:lpchub/functions/helper.dart';

import '../../../constant.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String imageUrl = "gs://schoolhub-2.appspot.com/Default/man.png";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "asset/images/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "asset/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "asset/icons/signup.svg",
                  height: size.height * 0.35,
                ),
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
                                  Icons.person,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Your Name",
                                border: InputBorder.none,
                              ),
                              validator: (value){
                                if(value.toString().length < 3){
                                  return 'Username is so small';
                                }
                                else{
                                  return null;
                                }
                              },
                              onSaved: (value){
                                setState((){
                                  username = value!;
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
                              obscureText: true,
                              onChanged: (value){},
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: Icon(
                                  Icons.visibility,
                                  color: kPrimaryColor,
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (value){
                                if(value.toString().length < 6){
                                  return 'Password is so small';
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
                                  // dynamic result = await _auth.signup(
                                  //     email, password);
                                  // if(result != null){
                                  //   HelperFunc.saveUserloggedIn(true);
                                  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  //     builder: (context) => Dashboard(),));
                                  // }

                                  await AuthService().signup(email, password).then((result){
                                   if(result != null){
                                     Map<String,String> userDataMap = {
                                       "name" : username,
                                       "email" : email,
                                       "username" : result.email!.replaceAll("@gmail.com", ""),
                                       "imageUrl" : imageUrl
                                     };

                                     DatabaseMethods().addUserInfoToDB(result.uid, userDataMap).then((value) {
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dash()));
                                     });

                                   }
                                  });
                                }
                              },
                              child: Text(
                                "SIGN-UP",
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
                              false ? "Don’t have an Account ? " : "Already have an Account ? ",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                false ? "Sign Up" : "Sign In",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                          width: size.width * 0.8,
                          child: Row(
                            children: <Widget>[
                              buildDivider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              buildDivider(),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "asset/icons/facebook.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "asset/icons/twitter.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                print("Tap");
                                AuthService().loginWithGoogle(context);
                                HelperFunc.saveUserloggedIn(true);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: kPrimaryLightColor,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  "asset/icons/google-plus.svg",
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            )
                          ],
                        )
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
  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}