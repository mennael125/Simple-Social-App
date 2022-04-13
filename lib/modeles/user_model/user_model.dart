class UserModel {
  late String name;

  late String phone;

  late String email;

  String? cover;

  String? image;

  late String bio;

  late String uID;

   // late bool isEmailVerified;

  UserModel(
      {required this.phone,
      required this.uID,
      // required this.isEmailVerified,
      required this.email,
      required this.cover,
      required this.image,
      required this.bio,
      required this.name});

  //constructor to receive data
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cover = json['cover'];
    image = json['image'];
    bio = json['bio'];

    uID = json['uID'];
     // isEmailVerified = json['isEmailVerified'];
  }

//fun to send data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'cover': cover,
      'image': image,
      'bio': bio,
      'uID': uID,
       // ' isEmailVerified': isEmailVerified
    };
  }
}
