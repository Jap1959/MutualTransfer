class PostUploaddataModel{

  late final String DestinationPlace;
  late final String CurrentPlace;
  late final String Proffession;
  late final String description;
  late final String MobileNo;
  late final String PostedByUserid;
  PostUploaddataModel({required this.DestinationPlace,required this.Proffession,required this.description, required this.PostedByUserid,required this.MobileNo,required this.CurrentPlace});
  factory PostUploaddataModel.fromMap(Map<String, dynamic> map) {
    return PostUploaddataModel(
      DestinationPlace: map['Destinationplace'],
      Proffession: map['Proffession'],
      description: map['Description'],
      PostedByUserid:map['PostedByUserid'],
      MobileNo: map['MobileNo'],
      CurrentPlace: map['CurrentPlace'],
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
    };

  }
}
