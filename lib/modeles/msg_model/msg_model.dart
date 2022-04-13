class MsgModel {
  late String receiverID;

  late String senderID;

  late String text;

   late String dateTime;




   // late bool isEmailVerified;

  MsgModel(
      {required this.senderID,
      required this.text,
      required this.dateTime,
      required this.receiverID});

  //constructor to receive data
  MsgModel.fromJson(Map<String, dynamic> json) {
    receiverID = json['receiverID'];
    text = json['text'];
    senderID = json['senderID'];
    dateTime = json['dateTime'];

  }

//fun to send data
  Map<String, dynamic> toMap() {
    return {
      'receiverID': receiverID,
      'text': text,
      'senderID': senderID,
      'dateTime': dateTime,
    };
  }
}
