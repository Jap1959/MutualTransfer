


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
}