
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/Screens/Welcome/welcome_screen.dart';
import 'package:lpchub/functions/database.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';
import 'package:lpchub/functions/user.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService
{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on Firebase User
  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid):null;
  }

  getCurrentUser(){
    return _auth.currentUser;
  }

   signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile', 'user_birthday']
    );

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);


    //Getting user data
    final userData = await FacebookAuth.instance.getUserData();



    // Once signed in, return the UserCredential
    UserCredential result = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    User? userDetails = result.user;

    if(result != null){
      SharedPreferenceHelper().saveUserEmail(userDetails!.email.toString());
      SharedPreferenceHelper().saveUserId(userDetails!.uid);
      SharedPreferenceHelper().saveUserName(userDetails!.email!.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName.toString());
      SharedPreferenceHelper().saveUserProfile(userDetails.photoURL.toString());

      Map<String, dynamic> userInfoMap = {
        "email" : userDetails.email,
        "username" : userDetails.email!.replaceAll("@gmail.com", ""),
        "name" : userDetails.displayName,
        "imageUrl" : userDetails.photoURL
      };

      DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfoMap).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dash()));
      });

    }

  }

  //signIn as Google
  loginWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);

    User? userDetails = result.user;

    if(result != null){
      SharedPreferenceHelper().saveUserEmail(userDetails!.email.toString());
      SharedPreferenceHelper().saveUserId(userDetails!.uid);
      SharedPreferenceHelper().saveUserName(userDetails!.email!.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveUserDisplayName(userDetails.displayName.toString());
      SharedPreferenceHelper().saveUserProfile(userDetails.photoURL.toString());

      Map<String, dynamic> userInfoMap = {
        "email" : userDetails.email,
        "username" : userDetails.email!.replaceAll("@gmail.com", ""),
        "name" : userDetails.displayName,
        "imageUrl" : userDetails.photoURL
      };

      DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfoMap).then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dash()));
      });
      
    }
  }

  //signIn as Anonymous
  Future signInAnon() async
  {
    try{
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signIn with Email and Password
  Future login(String Email, String Password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //Register with Email and Password
  Future signup(String Email, String Password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //FB LOGIN Trial
  Future checkLoggedIn(BuildContext context) async {
    _auth.authStateChanges().listen((user) async {
      if(user == null)
      {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dash(),));
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen(),));
      }
    });
  }

//Sign Out
  Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await _auth.signOut();
    await GoogleSignIn().disconnect();
  }

}