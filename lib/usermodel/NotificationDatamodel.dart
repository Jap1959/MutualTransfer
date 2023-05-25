class NotificationDatamodel{

  late final String PostedByUserid;
  late final String Date;
  late final String Time;
  late final String message;
  NotificationDatamodel({ required this.PostedByUserid,required this.Date,required this.Time,required this.message});
  factory NotificationDatamodel.fromMap(Map<String, dynamic> map) {
    return NotificationDatamodel(
      PostedByUserid:map['PostedByUserid'],
      Time:map['Time'],
      Date:map['Date'], message: map['message'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'PostedByUserid':PostedByUserid,
      'Date':Date,
      'Time':Time,
      'message':message,
    };

  }
}