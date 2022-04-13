class PostModel {
  late String name;
  String? userImage;

  late String postImage;

  late String postText;

  late String   dateTime;


  late String uID;

  PostModel(
      {required this.postImage,
      required this.uID,
      required this.postText,
      required this.userImage,
      required this.name,
      required this.dateTime,
      });

  //constructor to receive data
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    postText = json['postText'];
    postImage = json['postImage'];
    userImage = json['userImage'];
    dateTime = json['dateTime'];

    uID = json['uID'];
  }

//fun to send data
  Map<String, dynamic> toMap() {
    return {
      'dateTime':dateTime,
      'name': name,
      'postText': postText,
      'postImage': postImage,
      'userImage': userImage,
      'uID': uID,
    };
  }
}
