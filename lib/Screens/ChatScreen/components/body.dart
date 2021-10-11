import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lpchub/Screens/ChatRoom/chatroom.dart';
import 'package:lpchub/Screens/Dashboard/dashboard_main.dart';
import 'package:lpchub/functions/database.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

import '../../../constant.dart';

class Body extends StatefulWidget{
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body>{

  final bool isActive1= true;
  final bool isActive= false;
  bool isSearching = false;

  late String myName, myProfilePic, myUserName, myEmail;

  TextEditingController searchUsernameEditingController = TextEditingController();

  late Stream usersStream, chatRoomStream;

  getMyInfoFromSharedPreferences() async{
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;
    setState(() {
    });
  }

  getChatRoomIdByUserName(String a, String b){
    if(a.substring(0,1).codeUnitAt(0) > a.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }
    else{
      return "$a\_$b";
    }
  }

  onSearchButtonClick() async{
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods().getUserByUsername(searchUsernameEditingController.text);
    setState(() {});
  }

  Widget searchListUserTile({required String profileUrl,  name, email, username }){
    return GestureDetector(
      onTap: (){

        var chatRoomId = getChatRoomIdByUserName( username, myUserName);

        Map<String, dynamic> chatRoomInfoMap = {
          "users" : [ username, myUserName,]
        };

        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoom(profileUrl, username, name)));
      },
      child: Row(
        children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(33),
                child: Image.network(profileUrl, width: 65,height: 65,)
            ),
          SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 2,),
              Text(email)
            ],
          ),
        ],
      ),
    );
  }

  Widget searchUsersList(){
    return StreamBuilder<dynamic>(
        stream: usersStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return searchListUserTile(profileUrl: ds["imageUrl"], name: ds["name"], email : ds["email"], username : ds["username"]);
              }) : Center(child: CircularProgressIndicator(),) ;
        });
  }

  Widget chatRoomList(){
    return StreamBuilder<dynamic>(
        stream: chatRoomStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                return ChatRoomListTile(ds["lastMessage"], ds.id, myUserName);
              }) : Center(child: CircularProgressIndicator(),) ;
        });
  }

  getChatRooms() async{
    chatRoomStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async{
    await getMyInfoFromSharedPreferences();
    getChatRooms();
  }

  @override
  void initState(){
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Dash()));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/calendar.svg",
                    color: isActive ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "Today",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/gym.svg",
                    color: isActive1 ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "All Exercises",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SvgPicture.asset(
                    "asset/icons/Settings.svg",
                    color: isActive ? kActiveIconColor : kTextColor,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text("SchoolHub", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo"),)),
        backgroundColor: Color(0xFFF2BEA1),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
               isSearching ? Padding( padding: EdgeInsets.only(right: 12),
                    child:GestureDetector(onTap: (){
                      isSearching = false;
                      searchUsernameEditingController.text = "";
                      setState(() {

                    });},child: Icon(Icons.arrow_back))) : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(24)
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchUsernameEditingController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Username",

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            if(searchUsernameEditingController.text != ""){
                              onSearchButtonClick();
                            }
                          },
                            child: Icon(Icons.search)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            isSearching ? searchUsersList() : chatRoomList() ,
          ],
        ),
      ),
    );
  }
}
//
// class chatTile extends StatelessWidget{
//       late final String username;
//       late final String chatRoomId;
//       late final String lastMessage;
//
//       const chatTile({ required this.username, required this.chatRoomId, required this.lastMessage});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUsername;
  ChatRoomListTile(this.lastMessage, this.chatRoomId, this.myUsername);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "";

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.docs[0].id} ${querySnapshot.docs[0]["name"]}  ${querySnapshot.docs[0]["imgUrl"]}");
    name = "${querySnapshot.docs[0]["name"]}";
    profilePicUrl = "${querySnapshot.docs[0]["imgUrl"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatRoom(profilePicUrl,username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                profilePicUrl,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 3),
                Text(widget.lastMessage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
