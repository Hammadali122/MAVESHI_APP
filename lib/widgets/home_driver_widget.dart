import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../models/driver_model.dart';
import '../screens/driver_details_screen.dart';
import 'ddb_tile.dart';

class HomeDriversWidget extends StatelessWidget {
  const HomeDriversWidget({
    super.key,
    required this.driveCollection,
  });

  final CollectionReference<Object?> driveCollection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder<QuerySnapshot>(
          stream: driveCollection.snapshots(),
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
                DocumentSnapshot document1 = snapshot.data!.docs[index];
                DriverProfileModel driver =
                    DriverProfileModel.fromSnapshot(document1);
                return DDBTile(
                    title: driver.fullName ?? '',
                    address: 'driver'.tr,
                    imagePath: driver.profilePicture!,
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DriverDetailsScreen(driverDetails: driver)));
                    });
              },
            );
          },
        ),
      ),
    );
  }
}
