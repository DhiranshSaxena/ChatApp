import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpchub/Components/app_theme.dart';
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
    if (a.compareTo(b)== 1) { // a < b returns -1, 0 if equal, 1 if b<a
      return "$b\_$a";
    } else {
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
        if(sendBy == false)
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profileUrl),
            radius: 15,
          ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: sendBy ? MyTheme.kAccentColor : Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              borderRadius: BorderRadius.only(
                bottomLeft: sendBy ? Radius.circular(12) : Radius.circular(0),
                topLeft: Radius.circular(16),
                bottomRight: sendBy ? Radius.circular(0) : Radius.circular(12),
                topRight: Radius.circular(16),
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
              // print("This is what it is returning right now - ${myUserName == ds["sendBy"]}");
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
      // backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff686795),
        // title: Text(widget.name, style: TextStyle(fontFamily: "Cairo", fontWeight: FontWeight.w500, fontSize: 22),),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(widget.profileUrl),
              backgroundColor: Colors.white,
            ),
            SizedBox(width: 10),
            Text(widget.name, style: MyTheme.chatSenderName,)
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.call, size: 28,),),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.videocam_outlined, size: 28,),),
          SizedBox(
            width: 10,
          )
        ],
        toolbarHeight: 90,
        centerTitle: false,
      ),
        backgroundColor: Color(0xff686795),
      body: Column(
        children: [
          Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: Container(
                  child: Stack(
                    children: [
                      chatMessage(),
                      Container(
                        padding: EdgeInsets.only(bottom: 7, left: 10, right: 10),
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey.shade200,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
                              Icon(
                                Icons.attach_file,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(
                                width: 10,
                              ),
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
              ))
        ],
      )
    );
  }
}