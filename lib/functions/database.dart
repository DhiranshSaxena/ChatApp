import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

class DatabaseMethods{
  Future<void> addUserInfoToDB(String userId, Map <String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).set(userInfoMap);
  }

  Future<Stream<QuerySnapshot>>  getUserByUsername(String username) async{
    return await FirebaseFirestore.instance.collection("users").where("username", isEqualTo: username).snapshots();
  }

  Future addMessages(String chatRoomId, String messageId, Map<String, dynamic> messageInfoMap) async{
    return FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).collection("chats").doc(messageId).set(messageInfoMap);
  }
  
  updateLastMessageSend(String chatRoomId, Map<String, dynamic> lastMessageInfoMap){
    FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).update(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async{
    final snapshot = await FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).get();

    if(snapshot.exists){
      return true;
    }else{
      return FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>>  getChatRoomMessages(chatRoomId) async{
    return FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).collection("chats").orderBy("ts", descending: true).snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async{
    String? myName = await SharedPreferenceHelper().getUserName();
    return FirebaseFirestore.instance.collection("chatRooms").orderBy("lastMessageSendTs", descending: true).where("users", arrayContains: myName).snapshots();
    
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
  }

}