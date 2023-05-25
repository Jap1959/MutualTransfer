class NotificationGetDatamodel{

  late final String Name;
  late final String Profilepic;
  late final String Date;
  late final String Time;
  late final String message;
  NotificationGetDatamodel({ required this.Name,required this.Date,required this.Time,required this.message,required this.Profilepic});
  factory NotificationGetDatamodel.fromMap(Map<String, dynamic> map) {
    return NotificationGetDatamodel(
      Time:map['Time'],
      Date:map['Date'], message: map['message'], Name: map['Name'], Profilepic: map["Profilepic"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
       'Name':Name,
      'Date':Date,
      'Time':Time,
      'message':message,
      'Profilepic':Profilepic,
    };

  }
}