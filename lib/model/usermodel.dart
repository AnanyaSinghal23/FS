// class UserModel {
//   String? uid;
//   String? email;
//   String? password;

//   UserModel({this.uid, this.email, this.password});

//   UserModel.fromMap(Map<String, dynamic>map) {
//     uid = map["uid"];
//     email = map["email"];
//     password = map["password"];
//   }

//   Map<String, dynamic> toMap() {
//     return {
//     "uid":uid,
//     "email":email,
//     "password":password,
//     };
//   }
// }

class UserModel{
  final String? id;
  final String email;
  final String password;
  final String first;
  final String last;
  final String? middle;
  final int mob;
  
  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.first,
    required this.last,
    this.middle,
    required this.mob,
  });

  toJson(){
    return{
      "email id":email,
      "first name":first,
      "last name":last,
      "middle name":middle,
      "mobile number":mob,
      "password":password,
    };
  }
}