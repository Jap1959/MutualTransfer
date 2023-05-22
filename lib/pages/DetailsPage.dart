



import 'dart:io';

import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/LoadingButton.dart';
import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/bloc/appbloc.dart';
import 'package:connect2prof/databaseservices/StoreImageFile.dart';
import 'package:connect2prof/pages/Homepage.dart';
import 'package:connect2prof/usermodel/usermodel.dart';
import 'package:connect2prof/validation.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
     final Height=MediaQuery.of(context).size.height;
     final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocAddData,AppStates>(bloc: _blocAddData, builder: (context,state){
      return Scaffold(
        backgroundColor: kPrimary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Center(child: Text('Fill Your Details',
              style: TextStyle(fontFamily: 'MonoRoboto',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),)),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white,),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
            child: Container(
              height: Height*0.9,
              width: Width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Get Profile Completed", style: TextStyle(
                          fontFamily: 'RobotoMono',
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.grey[100],
                                backgroundImage: NetworkImage(state is UploadCompleted?state.url.toString():image),
                                child:state is UploadStartState?SpinKitCircle(color: kPrimary,):Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            progress=1;
                                          });
                                          final res=await FilePicker.platform.pickFiles(
                                            allowMultiple: false,
                                            type: FileType.custom,
                                            allowedExtensions: ['png','jpg'],
                                          );
                                          if(res!=null){
                                            _blocAddData.add(ProfileUploadEvent(res.files.single.name.toString(), res.files.single.path.toString()));
                                          }
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Icon(Icons.edit,color: Colors.white,),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: kPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ) ,
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextfieldApp(Email: Email, HintText: 'Enter  Email', icon: Icons.email_rounded, color: Colors.grey.shade100),
                        ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextfieldApp(Email: Name, HintText: "Enter Full Name", icon: Icons.person, color: Colors.grey.shade100),
                       ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextfieldApp(Email: City, HintText: "Enter city", icon: Icons.location_city, color: Colors.grey.shade100),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextfieldApp(Email: Pincode, HintText: "Enter Pincode", color: Colors.grey.shade100, icon: Icons.location_on,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextfieldApp(Email: Mobile, HintText: "Enter your Mobile number", icon: Icons.phone, color: Colors.grey.shade100),
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
                              if(state is DataUploadedState){
                                Get.offAll(()=>Homepage());
                              }

                            },
                            child:State==ButtonPressedState()?LoadingButton(): ButtonAPP(Name: 'Next',icon: Icons.arrow_forward,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
      );
    }
    );
  }
}
