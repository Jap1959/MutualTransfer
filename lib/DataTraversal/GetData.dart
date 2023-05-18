class Getdata{
  late final String Name;
  late final String Mobile;
  late final String Email;
  late final String Pincode;
  late final String City;
  Getdata({required this.Mobile,required this.Email,required this.Name,required this.Pincode,required this.City});
  Map<String, dynamic> SendData(){
    return <String, dynamic>{
      'Name': this.Name,
      'Email':this.Email,
      'currentplace': this.City,
      'Mobile_no': this.Mobile,
      'Pincode':this.Pincode,
    };
  }
}