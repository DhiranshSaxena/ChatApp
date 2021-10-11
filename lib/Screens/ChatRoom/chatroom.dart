import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/functions/database.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';
import 'package:random_string/random_string.dart';

class ChatRoom extends StatefulWidget{

  final String profileUrl, chatWithUserName, name;
  ChatRoom(this.profileUrl, this.chatWithUserName, this.name);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom>{
  late String chatRoomId, messageId = "";
  late String myName, myProfilePic, myUserName, myEmail;

  late Stream messageStream;

  TextEditingController messageTextEditingController = TextEditingController();

  getMyInfoFromSharedPreferences() async{
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
    myUserName = (await SharedPreferenceHelper().getUserName())!;
    myEmail = (await SharedPreferenceHelper().getUserEmail())!;


    chatRoomId = getChatRoomIdByUserName(widget.chatWithUserName, myUserName);

  }

  getChatRoomIdByUserName(String a, String b){
    if(a.substring(0,1).codeUnitAt(0) > a.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }
    else{
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked){
    if(messageTextEditingController.text != ""){
      String message = messageTextEditingController.text;

      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message" : message,
        "sendBy" : myUserName,
        "ts" : lastMessageTs,
        "imageUrl" : myProfilePic
      };

      if(messageId == ""){
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods().addMessages(chatRoomId, messageId, messageInfoMap).then((value) {
            Map<String, dynamic> lastMessageInfoMap = {
              "lastMessage" : message,
              "lastMessageSendTs" : lastMessageTs,
              "lastMessageSendBy" : myUserName,
            };

            print(message);
            print(lastMessageTs);
            print(myUserName);
            print(lastMessageInfoMap);
            print(chatRoomId);
            DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);

            if(sendClicked){
              messageTextEditingController.text = "";

              messageId = "";
            }
          }
       );
    }
  }

  Widget chatMessageTile(String message, bool sendBy){
    return Row(
      mainAxisAlignment: sendBy ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF2BEA1),
              borderRadius: BorderRadius.only(
                bottomLeft: sendBy ? Radius.circular(24) : Radius.circular(0),
                topLeft: Radius.circular(24),
                bottomRight: sendBy ? Radius.circular(0) : Radius.circular(24),
                topRight: Radius.circular(24),
              )
            ),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            padding: EdgeInsets.all(16.0),
            child: Text(message),
          ),
        ),
      ],
    );
  }

  Widget chatMessage(){
    return StreamBuilder<dynamic>(
      stream: messageStream,
      builder: (context, snapshot){
        return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.only(bottom: 60, top: 10),
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              DocumentSnapshot ds = snapshot.data.docs[index];
              return chatMessageTile(ds["message"], myUserName == ds["sendBy"]);
            }) : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async{
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async{
    await getMyInfoFromSharedPreferences();
    getAndSetMessages();
  }

  @override
  void initState(){
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2BEA1),
        title: Text(widget.name, style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.bold, fontSize: 22),),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessage(),
            Container(
              padding: EdgeInsets.only(bottom: 7, left: 10, right: 10),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.black87.withOpacity(0.25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500)
                      ),
                    controller: messageTextEditingController,
                      onChanged: (value){
                        addMessage(false);
                      },
                    )),
                    GestureDetector(
                      onTap: (){
                        addMessage(true);
                      },
                        child: Icon(Icons.send,))
                  ],
                ),
            ),),
          ],
        ),
      ),
    );
  }
}