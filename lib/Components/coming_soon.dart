import 'package:flutter/material.dart';
import 'package:lpchub/constant.dart';

class ComingSoon extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: kActiveIconColor,
      body: Container(
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
              height: MediaQuery.of(context).size.height*0.08,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    backgroundImage: AssetImage("asset/images/scanner.png"),
                  ),
                  CircleAvatar(backgroundColor: Colors.white,),
                  CircleAvatar(backgroundColor: Colors.white,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}