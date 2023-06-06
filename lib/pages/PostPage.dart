


import 'package:connect2prof/CustomWidgets/ButtonAPP.dart';
import 'package:connect2prof/CustomWidgets/Colors.dart';
import 'package:connect2prof/CustomWidgets/LoadingButton.dart';
import 'package:connect2prof/CustomWidgets/Textfield.dart';
import 'package:connect2prof/CustomWidgets/TextfieldArea.dart';
import 'package:connect2prof/bloc/events.dart';
import 'package:connect2prof/usermodel/PostUploadDatamodel.dart';
import 'package:connect2prof/usermodel/PostdataModel.dart';
import 'package:connect2prof/validation.dart';
import 'package:connect2prof/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/PostPageBLoc.dart';
import '../bloc/ChatPageBLoc.dart';
import '../bloc/statesofapp.dart';
import '../usermodel/usermodel.dart';
import 'Homepage.dart';

class PostPage extends StatefulWidget {
  PostPage(this.Mobile,this.Name,this.Url);
  String Name;
  String Url;
  String Mobile;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController DestinationPlace=TextEditingController();
  final TextEditingController CurrentPlace=TextEditingController();
  final TextEditingController Proffession=TextEditingController();
  final TextEditingController description=TextEditingController();
   final TextEditingController Mobile=TextEditingController();
  final TextEditingController Name=TextEditingController();
  BlocPostAdd _blocAddPost=BlocPostAdd();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blocAddPost.stream.listen((state) {
      if(state is AddedState){
        WidgetsBinding.instance?.addPostFrameCallback((_) {

          Get.offAll(()=>Homepage(noticount: state.notiount, index:0,));
          // Use the context here
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Height=MediaQuery.of(context).size.height;
    final Width=MediaQuery.of(context).size.width;
    return BlocBuilder<BlocPostAdd,AppStates>(bloc: _blocAddPost, builder: (context,state)
     {
       if(state is LoginSucessState){

       }
         return Scaffold(
           backgroundColor: kPrimary,
           appBar: AppBar(
             backgroundColor: Colors.transparent,
             elevation: 0.0,
             title: Center(child: Text('Add a Post',
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
           body:
           Padding(
             padding: const EdgeInsets.fromLTRB(0.0, 8, 0.0, 0.0),
             child: Container(
               height: Height * 0.9,
               width: Width,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                   topRight: Radius.circular(20),
                   topLeft: Radius.circular(20),
                 ),
                 color: Colors.grey[100],
               ),
               child: Padding(
                 padding: const EdgeInsets.all(30.0),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextfieldApp(Email: Name,
                           HintText: 'Enter Your Name',
                           icon: Icons.person,
                           color: Colors.white,),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextfieldApp(Email: Proffession,
                           HintText: 'Enter Your Proffesion',
                           icon: Icons.work,
                           color: Colors.white,),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextfieldApp(Email: DestinationPlace,
                           HintText: "Enter your Required Place",
                           icon: Icons.location_on,
                           color: Colors.white,),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: TextfieldApp(Email: CurrentPlace,
                           HintText: 'Enter Your CurrentPlace',
                           icon: Icons.location_on,
                           color: Colors.white,),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           height: Height * 0.075,
                           width: Width,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.fromLTRB(
                                 0.0, 10, 0.0, 0.0),
                             child: InternationalPhoneNumberInput(
                               ignoreBlank: false,
                               autoValidateMode: AutovalidateMode.disabled,
                               selectorTextStyle: TextStyle(
                                   color: Colors.black),
                               textFieldController: Mobile,
                               formatInput: true,
                               keyboardType:
                               TextInputType.numberWithOptions(
                                   signed: true, decimal: true),
                               inputBorder: OutlineInputBorder(),
                               onSaved: (PhoneNumber number) {
                                 print('On Saved: $number');
                               },
                               onInputChanged: (PhoneNumber value) {
                                 print('------------------------------>$value');
                               },
                             ),
                           ),
                         ),
                       ),
                       Container(
                         height: Height * 0.5,
                         width: Width, decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.white
                       ),
                         child: Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: Column(

                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   CircleAvatar(
                                     backgroundImage: NetworkImage(
                                         widget.Url),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.fromLTRB(
                                         10, 8, 0.0, 0.0),
                                     child: Text(
                                         widget.Name, style: TextStyle(
                                         fontFamily: 'MonoRoboto',
                                         fontSize: 20,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.black)),
                                   ),

                                 ],
                               ),
                               TextfieldArea(Email: description,
                                 HintText: 'Write About Post.....',
                                 color: Colors.white,),
                             ],
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GestureDetector(
                           onTap: () {
                             final uid = FirebaseAuth.instance.currentUser?.uid;
                             validationOfForm _valid = validationOfForm();
                             final status = _valid.ValidatePost(
                                 Proffession.text.toString(),
                                 CurrentPlace.text.toString(),
                                 DestinationPlace.text.toString(),
                                 description.text.toString(),
                                 Name.text.toString());
                             if (uid != null && status == 'true') {
                               PostUploaddataModel Post = PostUploaddataModel(
                                   DestinationPlace: DestinationPlace.text
                                       .toString(),
                                   Proffession: Proffession.text.toString(),
                                   description: description.text.toString(),
                                   PostedByUserid: uid.toString(),
                                   MobileNo: Mobile.text.toString(),
                                   CurrentPlace: CurrentPlace.text.toString());
                               _blocAddPost.add(AddPostEvent(Post));
                             }
                             else {
                               Get.snackbar("Error", status
                                   ,
                                   colorText: Colors.red.shade600,
                                   icon: Icon(
                                     Icons.close, color: Colors.white,),
                                   snackPosition: SnackPosition.TOP,
                                   backgroundColor: Colors.white60
                               );
                             }
                           },
                           child: state is ButtonPressedState
                               ? LoadingButton()
                               : ButtonAPP(
                             Name: 'Add Post', icon: Icons.arrow_forward,),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         );
    });
  }
}

