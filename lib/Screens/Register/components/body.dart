import 'package:flutter/material.dart';
import 'package:lpchub/Screens/Login%20Successful/login_success_screen.dart';
import 'package:lpchub/constant.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                Text(
                  "Complete Profile",
                  style: TextStyle(
                    fontSize: (28.0 / 375.0) * size.width,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                Text("Complete your details to join SchoolHub"),
                SizedBox(height: size.height * 0.06),
                CircleAvatar(
                  backgroundColor: kPrimaryColor,
                      radius: 60.0,
                      backgroundImage: AssetImage("asset/images/avatar.png"),
                    ),
                SizedBox(height: size.height * 0.015),
                Container(
                  child: Text(
                      'Change Profile Picture',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value){},
                        validator: (value){},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: "Full Name",
                          hintText: "Enter Your Full Name",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        //ToDo: Name
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value){},
                        validator: (value){},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: "Your Standard",
                          hintText: "Enter Your Class Standard",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        //ToDo: Class
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value){},
                        validator: (value){},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: "Phone Number",
                          hintText: "Enter Your Phone Number",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        //ToDo: Phone Number
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value){},
                        validator: (value){},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: "School Name",
                          hintText: "Enter Your School Name",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        //ToDo: School
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Form(
                      child: TextFormField(
                        onChanged: (value){},
                        validator: (value){},
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: "City Name",
                          hintText: "Enter Your City Name",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        //ToDo: City
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginSuccessScreen()));
                      },
                      child: Text(
                        "Save Details",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: (30 / 812.0) * size.height,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}