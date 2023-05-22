


import 'package:email_validator/email_validator.dart';

class validationOfForm{
   String validateform(String  Email,String pincode,String Mobile){
      if(!EmailValidator.validate(Email)){
         return 'Enter a valid Email';
     }
      if(Mobile.length!=10){
         return "Invalid Mobile no";
      }
     if(pincode.length!=6){
        return "Invalid Mobile no";
     }
     return 'true';
   }
   String ValidatePost(String Proffession,String CurrentLocation,String RequiredLocation,String Description,String Name){
     if(Proffession.length==0){
       return 'Enter your Proffession';
     }
     if(Name.length==0){
       return 'Enter your Name';
     }
     if(Description.length<200){
       return 'Minimum 100 words';
     }
     if(CurrentLocation.length==0){
       return "Enter your CuurentLocation";
     }
     if(RequiredLocation.length==0){
       return "Enter your RequiredLocation";
     }
     return 'true';
   }
}