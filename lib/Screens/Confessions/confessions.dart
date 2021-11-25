import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../constant.dart';

class Confession extends StatefulWidget{
  @override
  _ConfessionState createState() => _ConfessionState();
}

class _ConfessionState extends State<Confession>{

  final _formkey = GlobalKey<FormState>();
  String? confession = "";
  String? userID, myName;

  getMyInfoFromSharedPreferences() async{
    userID = (await SharedPreferenceHelper().getUserId())!;
    myName = (await SharedPreferenceHelper().getDisplayName())!;
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
        title: Text("SchoolHub", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo")),
        backgroundColor: Color(0xff686795),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          SystemChannels.textInput.invokeMethod('TextInput.show');
          showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context){
                return Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top : 5.0, left: 10, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                                SystemChannels.textInput.invokeMethod('TextInput.hide');
                              },
                              child: Icon(
                                Icons.close_sharp,
                                color: kActiveIconColor,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async{
                                  FirebaseFirestore fb = FirebaseFirestore.instance;
                                  await fb.collection('confessions').add({'confession' : confession, 'timeStamp' : DateTime.now(), 'displayName' : myName, 'userID' : userID }).whenComplete(() {
                                    Navigator.pop(context);
                                  });

                              },
                                child: Text("Post", style: TextStyle(
                                    color: kActiveIconColor,
                                    fontSize: 20,
                                ),),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0.0),
                                backgroundColor: MaterialStateProperty.all<Color>(kBackgroundColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color(0xff686795))
                                    ),
                                )
                              )
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                          Container(
                            height: MediaQuery.of(context).size.height*0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        onChanged: (value){
                                          setState((){
                                            confession = value;
                                          });
                                        },
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type Your Confession! Your Privacy is Safe!",
                                            hintStyle: TextStyle(fontWeight: FontWeight.w500,)
                                        ),

                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xff686795)),
                            ),
                          ),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              }
          );
        },
        child: Icon(LineAwesomeIcons.pen),
        backgroundColor: Color(0xff686795),
      ),
      body: feedBody(context),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("confessions").orderBy("timeStamp", descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return (const Center(child: Text("It is Empty Here! Start Now."),));
            }
            else{
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index){
                    Timestamp timeStamp = snapshot.data!.docs[index]['timeStamp'];
                    String confession = snapshot.data!.docs[index]['confession'];
                    return ConfessionTile(timeStamp, confession);
                  });
            }
          },
        ),
        height: MediaQuery.of(context).size.height*0.9,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
      ),
    );
  }

  Widget ConfessionTile(Timestamp timeStamp, String confession){
   return Padding(
     padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
     child: Card(
       child: Column(
           children: [
             Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(30),
                     child: Image(
                       image: AssetImage("asset/images/avatar.png"),
                       width: 40,
                       height: 40,
                     )
                   ),
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Anonymous", style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.w500
                     ),),
                     Text(timeago.format(timeStamp.toDate()))
                   ],
                 ),
               ],
             ),
             Divider(
               thickness: 2.0,
             ),
             Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(left : 10.0, right: 10.0, bottom: 10.0),
                     child: Align(
                       child: Text(
                         confession,
                         style: TextStyle(
                           fontSize: 15.0,
                           fontWeight: FontWeight.w400
                         ),
                       ),
                       alignment: Alignment.topLeft,
                     ),
                   ),
                 ],
               ),
             )
           ],
         ),
     ),
   );
  }
}