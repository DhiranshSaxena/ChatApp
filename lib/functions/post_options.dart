import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lpchub/constant.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PostFunctions with ChangeNotifier{

  TextEditingController commentController = TextEditingController();
  String postComment = "";

  Future addLike(BuildContext context, String postId, String? subDocID) async{
    return FirebaseFirestore.instance.collection('alumni').doc(postId).collection('Likes').doc(subDocID).set({

      'likes' : FieldValue.increment(1),
      'username' : await SharedPreferenceHelper().getUserName(),
      'displayName' :await SharedPreferenceHelper().getDisplayName(),
      'profilePic' : await SharedPreferenceHelper().getUserProfileUrl(),
      'userID' : await SharedPreferenceHelper().getUserId(),
      'time' : Timestamp.now()

    });
  }

  Future addComment(String postId, String comment) async{
    return FirebaseFirestore.instance.collection('alumni').doc(postId).collection('comments').doc(comment).set({

      'comment' : comment,
      'commentNumber' : FieldValue.increment(1),
      'username' : await SharedPreferenceHelper().getUserName(),
      'displayName' :await SharedPreferenceHelper().getDisplayName(),
      'profilePic' : await SharedPreferenceHelper().getUserProfileUrl(),
      'userID' : await SharedPreferenceHelper().getUserId(),
      'time' : Timestamp.now()

    });
  }



  showCommentSheet(BuildContext context, String docId){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height*0.75,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150),
                      child: Divider(
                        thickness: 4.0,
                        color: Colors.black54,
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Text("Comments", style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.63,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('alumni').doc(
                          docId
                        ).collection('comments').orderBy('time').snapshots(),
                        builder: (context, snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else{
                            return ListView(
                              children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
                                return Container(
                                  height: MediaQuery.of(context).size.height*0.15,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                            child: GestureDetector(
                                              child: CircleAvatar(
                                                backgroundColor: kBackgroundColor,
                                                radius: 15,
                                                backgroundImage: NetworkImage(
                                                  (documentSnapshot.data() as dynamic)['profilePic'],
                                                ),
                                              ),
                                            ),
                                          ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0, top: 8),
                                                child: Container(
                                                  child:
                                                      Text((documentSnapshot.data() as dynamic)['displayName'],
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16
                                                        ),
                                                      ),
                                                ),
                                              ),

                                          Container(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(LineAwesomeIcons.heart, size: 22),
                                                  onPressed: (){},
                                                ),
                                                Text('0',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(LineAwesomeIcons.reply, size: 22),
                                                  onPressed: (){},
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.arrow_forward_ios_outlined, size: 12,),
                                              onPressed: (){},
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width*0.75,
                                              child: Text(
                                                (documentSnapshot.data() as dynamic)['comment'],
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(LineAwesomeIcons.trash, color: Colors.red, size: 22,),
                                              onPressed: (){},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 300,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.grey.shade200,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: TextField(
                                onChanged: (value){
                                  postComment = value;
                                },
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Add a Comment',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                controller: commentController,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: FloatingActionButton(
                              backgroundColor: Colors.amber,
                              onPressed: (){
                                PostFunctions().addComment(docId, commentController.text).whenComplete(() {
                                  commentController.clear();
                                });
                              },
                              child: Icon(
                                LineAwesomeIcons.arrow_right,
                                color: Colors.grey,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
                ),
              ),
            ),
          );
        });
  }

  showLikes(BuildContext context, String postID){
    return showModalBottomSheet(
      backgroundColor: kBackgroundColor,
        context: context,
        builder: (context){
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.black54,
                  ),
                ),
                Container(
                  child: Text("Likes", style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.2,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('alumni').doc(postID).collection('Likes').snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else{
                        return new ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot){
                            return ListTile(
                              leading: GestureDetector(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    (documentSnapshot.data() as dynamic)['profilePic']
                                  ),
                                ),
                              ),
                              title: Text((documentSnapshot.data() as dynamic)['displayName'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text((documentSnapshot.data() as dynamic)['username'],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: (FirebaseAuth.instance.currentUser!.uid).toString() == (documentSnapshot.data() as dynamic)['userID'] ? Container(width: 0.0, height: 0.0,) : ElevatedButton(
                                onPressed: (){},
                                child: Text("Follow", style: TextStyle(
                                  color: Colors.amber.shade700,
                                  fontSize: 16,
                                ),),
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all<double>(0.0),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.amber.shade700)
                                      ),
                                    )
                                ),
                              )
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )
            ),
          );
        });
  }

}