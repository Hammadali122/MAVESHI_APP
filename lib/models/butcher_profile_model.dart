import 'package:cloud_firestore/cloud_firestore.dart';

class ButcherProfile {
  final String? fullName;
  final String? address;
  final String? member;
  final String? phone;
  final String? experience;
  final String? profilePicUrl;

  ButcherProfile({
    this.fullName,
    this.address,
    this.member,
    this.phone,
    this.experience,
    this.profilePicUrl,
  });

  factory ButcherProfile.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ButcherProfile(
        fullName: data['fullName'],
        address: data['address'],
        experience: data['experience'],
        member: data['member'],
        phone: data['phone'],
        profilePicUrl: data['profilePicture']);
  }
}
