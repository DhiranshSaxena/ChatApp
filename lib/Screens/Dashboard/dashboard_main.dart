import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/Components/coming_soon.dart';
import 'package:lpchub/Screens/Alumni/alumni.dart';
import 'package:lpchub/Screens/ChatScreen/chat_home.dart';
import 'package:lpchub/Screens/Confessions/confessions.dart';
import 'package:lpchub/Screens/Memes/memes.dart';
import 'package:lpchub/Screens/News/news_screen.dart';
import 'package:lpchub/Screens/Profile/profile.dart';
import 'package:lpchub/Screens/Resources/resources.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

import '../../constant.dart';
import 'components/category_card.dart';

class Dash extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: DashboardMain(),
    );
  }
}

class DashboardMain extends StatefulWidget{
  _DashboardMainState createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain>{

  greeting(){
    var hour = DateTime.now().hour;
    print(hour);
    if(hour <= 12){
      return "Morning";
    }
    else if(hour <= 16){
      return "Afternoon";
    }
    else if(hour <= 22){
      return "Evening";
    }
    else{
      return "Night";
    }
  }


  late String myName="", myProfilePic, myUserName, myEmail;

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

  final bool isActive1= true;
  final bool isActive= false;

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    String greetingMes = greeting();
    print(greetingMes);
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
                    color: isActive1 ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Dashboard",
                    style: TextStyle(color: isActive1 ? kActiveIconColor : kTextColor),
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
                    "Social",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ComingSoon()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Icon(
                    LineAwesomeIcons.laugh_face_with_beaming_eyes,
                    color: isActive ? kActiveIconColor : kTextColor,
                    size: 35,
                  ),
                  Text(
                    "Coming-Soon",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xff686795),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("asset/images/pilates.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProfileScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Color(0xff7C7B9B),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("asset/icons/menu.svg"),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Good ${greetingMes}, \n${myName}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29.5),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        icon: SvgPicture.asset("asset/icons/search.svg"),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Resources()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Spacer(),
                                      SvgPicture.asset("asset/icons/resources.svg", height: 70,width: 70,),
                                      Spacer(),
                                      Text(
                                        "Resources",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Alumni()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Spacer(),
                                      SvgPicture.asset("asset/icons/alumni.svg", height: 70,width: 70,),
                                      Spacer(),
                                      Text(
                                        "Alumni",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsScreen()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Spacer(),
                                      SvgPicture.asset("asset/icons/news.svg", height: 70,width: 70,),
                                      Spacer(),
                                      Text(
                                        "News Section",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: Container(
                            // padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 17),
                                  blurRadius: 17,
                                  spreadRadius: -23,
                                  color: kShadowColor,
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Confession()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: <Widget>[
                                      Spacer(),
                                      SvgPicture.asset("asset/icons/confession.svg", height: 70,width: 70,),
                                      Spacer(),
                                      Text(
                                        "Confessions",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}