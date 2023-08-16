import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import './/widgets/animal_list_tile.dart';
import '../../models/livestock_model.dart';
import '../livestock_detail_screen.dart';

class GoatCategoryScreen extends StatefulWidget {
  static const routeName = 'goat-category';
  final String animalType;
  const GoatCategoryScreen({Key? key, required this.animalType})
      : super(key: key);

  @override
  State<GoatCategoryScreen> createState() => _GoatCategoryScreenState();
}

class _GoatCategoryScreenState extends State<GoatCategoryScreen> {
  bool isFavorite = false;

  final CollectionReference livestockCollection =
      FirebaseFirestore.instance.collection('SellYourAnimal');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('goat'.tr),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: livestockCollection
            .where('animalType', isEqualTo: "goat")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Livestock livestock = Livestock.fromSnapshot(document);

              return AnimalListTile(
                favPress: () {
                  setState(() {
                    bool isFavorite = !livestock.isFavorite;
                    livestockCollection.doc(livestock.uid).update({
                      'isFavorite': isFavorite,
                    });
                  });
                },
                faveIcon: isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
                name: livestock.sellerName ?? '',
                subTitle: livestock.price ?? '',
                image: livestock.imagePath ?? '',
                description: livestock.description ?? '',
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimalDetailScreen(
                                livestockDetails: livestock,
                              )));
                },
              );
            },
          );
        },
      ),
    );
  }
}
