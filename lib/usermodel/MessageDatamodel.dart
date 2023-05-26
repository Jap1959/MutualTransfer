
class MessageDatamodel{
  late final String PostedByUserid;
  late final String Date;
  late final String message;
  MessageDatamodel({ required this.PostedByUserid,required this.Date,required this.message});
  factory MessageDatamodel.fromMap(Map<String, dynamic> map) {
    return MessageDatamodel(
      PostedByUserid:map['PostedByUserid'],
      Date:map['Date'], message: map['message'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'PostedByUserid':PostedByUserid,
      'Date':Date,
      'message':message,
    };

  }
}