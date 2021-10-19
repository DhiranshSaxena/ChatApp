import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpchub/functions/sharedPref_helper.dart';

class MemeUpload extends StatefulWidget{
  @override
  _MemeUploadState createState() => _MemeUploadState();
}

class _MemeUploadState extends State<MemeUpload>{

  File? _image;

  String? userID, myName, myProfilePic;
  String? downloadUrl;
  final imagePicker = ImagePicker();

  var time = DateTime.now().millisecondsSinceEpoch.toString();
  var timeStamp = DateTime.now();

  getMyInfoFromSharedPreferences() async{
    userID = (await SharedPreferenceHelper().getUserId())!;
    myName = (await SharedPreferenceHelper().getDisplayName())!;
    myProfilePic = (await SharedPreferenceHelper().getUserProfileUrl())!;
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


  Future imagePickerMethod() async{
    //picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null){
        _image = File(pick.path);
      }
      else{
        showSnackBar("No File Selected", Duration(milliseconds: 400));
      }
    });
  }

  Future uploadImage() async{
    Reference ref = FirebaseStorage.instance.ref().child("memes/${userID}").child("post_$time.png");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();


    //uploading download url in the database
    FirebaseFirestore fb = FirebaseFirestore.instance;

    await fb.collection("memes").add({"url": downloadUrl, "displayName" : myName, "profileUrl" : myProfilePic,"timeStamp" : timeStamp});
  }

  showSnackBar(String text, Duration d){
    final snackBar = SnackBar(content: Text(text), duration: d,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff686795),
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Image Upload", style: TextStyle(fontSize: 24 ,fontFamily: "Cairo"),
        ),
        backgroundColor: Color(0xff686795),
      ),
      body: feedBody(context),
    );
  }

  Widget feedBody(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  height: 500,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Image Upload"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 4,
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xff686795)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: _image == null ?
                                      const Center(child: Text("No Image Selected"),) :
                                      Image.file(_image!)
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        imagePickerMethod();
                                      },
                                      child: Text("Select Image"),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff686795)
                                    ),
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        if(_image != null){
                                          uploadImage().whenComplete(() {
                                            showSnackBar("Image Uploaded Successfully", Duration(milliseconds: 1000));
                                            setState(() {
                                              _image = null;
                                            });
                                          }

                                          );
                                        }
                                        else{
                                          showSnackBar("Please Select the Image First", Duration(milliseconds: 1000));
                                        }
                                      },
                                      child: Text("Upload Image"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff686795)
                                    ),)
                                ],
                              ),
                            ),
                          ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
          height: MediaQuery.of(context).size.height*0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFF8F8F8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          ),
        ),
      ),
    );
  }
}