import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './/widgets/animal_list_tile.dart';
import '../../models/livestock_model.dart';
import '../../utils/utils.dart';
import '../livestock_detail_screen.dart';

class SheepCategoryScreen extends StatefulWidget {
  final String animalType;
  static const routeName = 'sheep-category';

  const SheepCategoryScreen({Key? key, required this.animalType})
      : super(key: key);

  @override
  State<SheepCategoryScreen> createState() => _SheepCategoryScreenState();
}

class _SheepCategoryScreenState extends State<SheepCategoryScreen> {
  late List<Livestock> livestockList;
  bool isFavorite = false;
  final CollectionReference livestockCollection =
      FirebaseFirestore.instance.collection('SellYourAnimal');
  @override
  void initState() {
    super.initState();
    livestockList = [];
    fetchLivestockData();
  }

  void fetchLivestockData() {
    livestockCollection
        .where('animalType', isEqualTo: 'sheep')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        setState(() {
          livestockList = querySnapshot.docs
              .map((DocumentSnapshot document) =>
                  Livestock.fromSnapshot(document))
              .toList();
        });
      }
    }).catchError((error) {
      Utils().toastMessage('Error fetching livestock data: $error');
    });
  }

  void toggleFavoriteStatus(int index) {
    setState(() {
      livestockList[index].isFavorite = !livestockList[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheep'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: livestockCollection
            .where('animalType', isEqualTo: 'sheep')
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
                  favPress: () => toggleFavoriteStatus(index),
                  faveIcon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: livestock.isFavorite ? Colors.red : Colors.black,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AnimalDetailScreen(
                                  livestockDetails: livestock,
                                )));
                  },
                  name: livestock.sellerName ?? '',
                  subTitle: livestock.price ?? '',
                  image: livestock.imagePath ?? '',
                  description: livestock.description ?? '');
            },
          );
        },
      ),
    );
  }
}
