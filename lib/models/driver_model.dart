import 'package:cloud_firestore/cloud_firestore.dart';

class DriverProfileModel {
  final String? fullName;
  final String? address;
  final String? carType;
  final String? phone;
  final String? experience;
  final String? profilePicture;

  DriverProfileModel(
      {this.fullName,
      this.address,
      this.carType,
      this.phone,
      this.experience,
      this.profilePicture});

  factory DriverProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> dData = snapshot.data() as Map<String, dynamic>;
    return DriverProfileModel(
      fullName: dData['fullName'],
      phone: dData['phone'],
      address: dData['address'],
      experience: dData['experience'],
      profilePicture: dData['profilePicture'],
      carType: dData['carType'],
    );
  }
}
