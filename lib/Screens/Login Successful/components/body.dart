import 'package:flutter/material.dart';
import '../../../constant.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.18),
          Image.asset(
            "asset/images/success.png",
            height: size.height * 0.4, //40%
          ),
          SizedBox(height: size.height * 0.08),
          Text(
            "Login Success",
            style: TextStyle(
              fontSize: (30.0 / 375.0) * size.width,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          SizedBox(
            width: size.width * 0.6,
            child: SizedBox(
              width: double.infinity,
              height: (56 / 812.0) * size.height,
              child: FlatButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: kPrimaryColor,
                onPressed: (){},
                child: Text(
                  "Back To Home",
                  style: TextStyle(
                    fontSize: (18.0 / 375.0) * size.width,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ),
          Spacer(),
        ],
      ),
    );
  }
}