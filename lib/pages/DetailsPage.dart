



import 'dart:io';

import 'package:connect2prof/bloc/appbloc.dart';
import 'package:connect2prof/databaseservices/StoreImageFile.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:connect2prof/validation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/events.dart';
import '../bloc/statesofapp.dart';

class DetailsPage extends StatefulWidget {
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}
class _DetailsPageState extends State<DetailsPage> {
  late final TextEditingController Email=new TextEditingController();
  late final TextEditingController Name=new TextEditingController();
  late final TextEditingController City=new TextEditingController();
  late final TextEditingController Mobile=new TextEditingController();
  late final TextEditingController Pincode=new TextEditingController();
  late final String jsonString;
  late BlocAddData _blocAddData;
  bool uploadstatus=false;
  String image='https://img.icons8.com/?size=512&id=12438&format=png';
  @override
  void initState() {
    _blocAddData = BlocAddData();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _blocAddData=BlocProvider.of<BlocAddData>(context);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double progress=0.0;
    return BlocBuilder<BlocAddData,AppStates>(bloc: _blocAddData, builder: (context,state){
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0.0, 0.0),
                    child: Center(child: Icon(Icons.arrow_back_ios,color: Colors.black)),
                  ),
                ),
              ),
            ),
            elevation: 0.0,
            title: Text('Profile',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30.0),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage(image),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    final res=await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      type: FileType.custom,
                                      allowedExtensions: ['png','jpg'],
                                    );
                                    if(res!=null){
                                      Storage store=Storage();
                                      final url=await store.upload(res.files.single.path.toString(), res.files.single.name.toString());
                                         setState(() {
                                           image=url.toString();
                                         });
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Icon(Icons.edit,color: Colors.white,),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ) ,
                        ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                      child: Text('Email address',style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      width: 550,
                      height: 50,
                      child: TextField(
                        controller: Email,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: "johndoe@gmail.com",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text('Full name',style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      width: 550,
                      height: 50,
                      child: TextField(
                        controller: Name,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text('Current living City',style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      width: 550,
                      height: 50,
                      child: TextField(
                        controller: City,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text('Pincode',style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      width: 550,
                      height: 50,
                      child: TextField(
                        controller: Pincode,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType:TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      child: Text('Mobile No',style: TextStyle(
                        fontFamily:'RobotoMono',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      width: 550,
                      height: 50,
                      child: TextField(
                        controller: Mobile,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        keyboardType:TextInputType.number,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          validationOfForm _valid=validationOfForm();
                          final status= _valid.validateform(Email.text.toString(), Pincode.text.toString(), Mobile.text.toString());
                          if(status=='true'){
                            final userDatamodel=UserDatamodel(Name: Name.text.toString(), Email: Email.text.toString(), currentplace: City.text.toString(), Mobile_no: Mobile.text.toString(), Profilepic: image.toString());
                            _blocAddData.add(AdddataEvent(userDatamodel));
                          }
                          else{
                            Get.snackbar("Error", "$status",
                              icon: Icon(Icons.close,color: Colors.black,),
                              backgroundColor: Colors.red,
                            );
                          }

                        },
                        child: Container(
                          width: 400,
                          height: 50,
                          child: progress==1?CircularProgressIndicator(color: Colors.white,):Center(child: Text('Next',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'MonoRoboto'),)),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    }
    );
  }
}
