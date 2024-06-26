class PostdataModel{

  late final String DestinationPlace;
  late final String CurrentPlace;
  late final String Proffession;
  late final String description;
  late final String MobileNo;
  late final String PostedByUserid;
  late final String Profilepic;
  late final String Name;
  late final String Date;
  late final String Time;
  PostdataModel({required this.DestinationPlace,required this.Proffession,required this.description, required this.PostedByUserid,required this.MobileNo,required this.CurrentPlace,required this.Name,required this.Profilepic,required this.Date,required this.Time});
  factory PostdataModel.fromMap(Map<String, dynamic> map) {
    return PostdataModel(
      DestinationPlace: map['Destinationplace'],
      Proffession: map['Proffession'],
      description: map['Description'],
      PostedByUserid:map['PostedByUserid'],
      MobileNo: map['MobileNo'],
      CurrentPlace: map['CurrentPlace'],
      Name:map['Name'],
      Profilepic:map['Profilepic'],
      Time:map['Time'],
      Date:map['Date'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'Destinationplace': DestinationPlace,
      'Proffession': Proffession,
      'Description': description,
      'PostedByUserid':PostedByUserid,
      'MobileNo':MobileNo,
      'CurrentPlace':CurrentPlace,
      'Name':Name,
      'Profilepic':Profilepic,
      'Date':Date,
      'Time':Time,

    };

  }
}
