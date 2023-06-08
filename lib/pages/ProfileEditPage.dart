import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CustomWidgets/ButtonAPP.dart';
import '../CustomWidgets/Colors.dart';
import '../CustomWidgets/LoadingButton.dart';
import '../CustomWidgets/Textfield.dart';
import '../bloc/AdddataBloc.dart';
import '../bloc/events.dart';
import '../bloc/statesofapp.dart';
import '../usermodel/usermodel.dart';
import '../validation.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({required this.Name,required this.Mobile,required this.url,required this.Email,required this.City});
  String Name;
  String City;
  String Mobile;
  String Email;
  String url;

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late final TextEditingController Email=new TextEditingController(text: widget.Email);
  late final TextEditingController Name=new TextEditingController(text: widget.Name);
  late final TextEditingController City=new TextEditingController(text: widget.City);
  late final TextEditingController Mobile=new TextEditingController(text: widget.Mobile);
  late final TextEditingController Pincode=new TextEditingController();
  late final TextEditingController Proffesion=new TextEditingController();
  late BlocAddData _blocAddData;
  void initState() {
    _blocAddData = BlocAddData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocAddData,AppStates>(bloc: _blocAddData, builder: (context,state){
      return Scaffold(
          backgroundColor: kPrimary,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Center(child: Text('Update Your Details',
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
                                backgroundImage: NetworkImage(state is UploadCompleted?state.url.toString():widget.url),
                                child:state is UploadStartState?SpinKitCircle(color: kPrimary,):Column(
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
                          child: TextfieldApp(Email:Proffesion , HintText: 'Enter  Proffession', icon: Icons.work, color: Colors.grey.shade100),
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
                          child: State is ButtonPressedState?LoadingButton():GestureDetector(
                            onTap: () async {
                              validationOfForm _valid=validationOfForm();
                              final status= _valid.validateform(Email.text.toString(), Pincode.text.toString(), Mobile.text.toString());
                              SharedPreferences prefs=await SharedPreferences.getInstance();
                              String? image=prefs.getString('Url');

                              print(image.toString());
                              if(status=='true'){
                                final uid=FirebaseAuth.instance.currentUser?.uid;
                                final userDatamodel=UserDatamodel(Name: Name.text.toString(), Email: Email.text.toString(), currentplace: City.text.toString(), Mobile_no: Mobile.text.toString(), Profilepic:image!, Proffession: Proffesion.text.toString(), is_online: 'true', LastSeen: '', uid: uid.toString() );
                                _blocAddData.add(ProfileUpdateEvent(userDatamodel));
                              }
                              else{
                                Get.snackbar("Error", "$status",
                                  icon: Icon(Icons.close,color: Colors.black,),
                                  backgroundColor: Colors.red,
                                );
                              }
                              },
                            child: state is ButtonNotPressedState?LoadingButton():ButtonAPP(Name: 'Update',icon: Icons.arrow_forward,),
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
