class UserDatamodel{
  late final String Name;
  late final String Email;
  late final String currentplace;
  late final String Mobile_no;
  late final String Profilepic;
  late final String Proffession;
  late final String LastSeen;
  late final String is_online;
  late final String uid;
  UserDatamodel({required this.Name,required this.Email,required this.currentplace,required this.Mobile_no,required this.Profilepic,required this.Proffession,required this.is_online,required this.LastSeen,required this.uid});
  factory UserDatamodel.fromMap(Map<String, dynamic> map) {
    return UserDatamodel(
      Name: map['name'],
      currentplace: map['currentplace'],
      Mobile_no: map['Mobile'],
        Profilepic: map['Profilepic'],
      Email: map['Email'],
      Proffession: map['Proffession'], is_online: map['is_online'], LastSeen: map['Lastseen'], uid: map['uid'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'Email': Email,
      'currentplace': currentplace,
      'Mobile_no': Mobile_no,
      'Profilepic': Profilepic,
      'Proffession':Proffession,
      'is_online':is_online,
      'Lastseen':LastSeen,
      'uid':uid,
    };

  }
}
