import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../models/butcher_profile_model.dart';
import '../screens/butcher_details.dart';
import 'ddb_tile.dart';

class HomeButcherWidget extends StatelessWidget {
  const HomeButcherWidget({
    super.key,
    required this.butcherCollection,
  });

  final CollectionReference<Object?> butcherCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: butcherCollection.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error : ${snapshot.error}"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];

                ButcherProfile butcher = ButcherProfile.fromSnapshot(document);
                return DDBTile(
                  title: butcher.fullName ?? '',
                  // address: butcher.address.toString(),
                  imagePath: butcher.profilePicUrl!,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ButcherDetailScreen(
                                  butcherDetails: butcher,
                                )));
                  },
                  address: 'butcher'.tr,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
