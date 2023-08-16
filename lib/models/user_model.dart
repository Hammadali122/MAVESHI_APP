import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userName;
  String mobileNumber;
  String userCardNumber;
  String userId;

  UserModel(
      {required this.userName,
      required this.mobileNumber,
      required this.userCardNumber,
      required this.userId});

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      userName: data['userName'],
      mobileNumber: data['mobileNumber'],
      userCardNumber: data['userCardNumber'],
      userId: data['userId'],
    );
  }
}
