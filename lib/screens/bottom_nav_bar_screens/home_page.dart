import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:maveshi/models/veterinary_doctor_model.dart';
import 'package:maveshi/screens/bottom_nav_bar_screens/search_screen.dart';
import 'package:maveshi/utils/colors.dart';
import 'package:maveshi/utils/fonts.dart';
import 'package:maveshi/widgets/language_controller.dart';
import 'package:maveshi/widgets/round_button.dart';
import 'package:maveshi/widgets/user_story.dart';

import '../../models/livestock_model.dart';
import '../../utils/all_pak_maveshi_mandi.dart';
import '../../widgets/category_card.dart';
import '../../widgets/ddb_tile.dart';
import '../../widgets/home_butcher_widget.dart';
import '../../widgets/home_driver_widget.dart';
import '../../widgets/my_drawer.dart';
import '../../widgets/recommended_card.dart';
import '../animal_categories_screens/buffalo_category_screen.dart';
import '../animal_categories_screens/bull_category_screen.dart';
import '../animal_categories_screens/cow_category_screen.dart';
import '../animal_categories_screens/goat_category_screen.dart';
import '../animal_categories_screens/lamb_category_screen.dart';
import '../animal_categories_screens/sheep_category_screen.dart';
import '../doctor_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'Home-Page';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

//=====================search=============================

  // ==========butcher ref==============================
  final CollectionReference butcherCollection =
      FirebaseFirestore.instance.collection('butcherCollection');
  // ==========doctor ref===============================
  final CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection('VeterinaryDoctor');

  //=============drivers reference======================
  final CollectionReference driveCollection =
      FirebaseFirestore.instance.collection('DriverCollection');

  showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Language"),
          actions: [
            ElevatedButton(
              onPressed: () {
                LanguageController.changeLanguage('us');
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('ENGLISH'),
            ),
            ElevatedButton(
              onPressed: () {
                LanguageController.changeLanguage('ur');
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('URDU'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColour.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'home'.tr,
        ),
        actions: [
          TextButton(
              onPressed: () => showLanguageDialog(context),
              child: Text(
                'language'.tr,
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //=============================================SEARCH======================================
              RoundButton(
                title: "search".tr,
                onPress: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
              ),

              //=========================================Different Categories=============================
              DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      indicatorColor: AppColour.primaryColor,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text: 'animals'.tr),
                        Tab(text: 'drivers'.tr),
                        Tab(text: 'butcher'.tr),
                        Tab(text: 'doctors'.tr)
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height *
                          0.31, //height of TabBarView
                      decoration: const BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.grey, width: 0.5))),
                      child: TabBarView(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: [
                                      CategoryCard(
                                        title: 'cow'.tr,
                                        image: 'assets/pictures/cows.png',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CowCategory(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                      CategoryCard(
                                        title: 'buffalo'.tr,
                                        image: 'assets/pictures/buf.jpeg',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BuffaloCategoryScreen(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                      CategoryCard(
                                        title: 'goat'.tr,
                                        image: 'assets/pictures/goatwhite.jpg',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const GoatCategoryScreen(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                      CategoryCard(
                                        title: 'sheep'.tr,
                                        image: 'assets/pictures/sheep.png',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SheepCategoryScreen(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                      CategoryCard(
                                        title: 'lamb'.tr,
                                        image: 'assets/pictures/lamb.jpg',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LambCategoryScreen(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                      CategoryCard(
                                        title: 'bull'.tr,
                                        image: 'assets/pictures/bull.jpeg',
                                        onPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const BullCategoryScreen(
                                                        animalType: '',
                                                      )));
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        //============================drivers===============================
                        HomeDriversWidget(driveCollection: driveCollection),
                        //-==========================butcher=================================
                        HomeButcherWidget(butcherCollection: butcherCollection),
                        //=============doctor================================================
                        SizedBox(
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: doctorCollection.snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error : ${snapshot.error}"));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapshot.data == null ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Center(
                                      child: Text('No data available'));
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data?.docs.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];

                                    DoctorProfileModel doctor =
                                        DoctorProfileModel.fromSnapshot(
                                            document);
                                    return DDBTile(
                                      title: doctor.fullName ?? '',
                                      // address: butcher.address.toString(),
                                      imagePath:
                                          doctor.profilePicture.toString(),
                                      press: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DoctorDetailScreen(
                                                      doctorDetail: doctor,
                                                    )));
                                      },
                                      address: 'doctor'.tr,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),

              //=================================RECOMMENDED====================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('recommended for you'.tr, style: AppFonts.boldText),
                    const SizedBox(height: 5),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('SellYourAnimal')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // Retrieve the list of documents from the snapshot
                          final documents = snapshot.data!.docs;

                          return SizedBox(
                            height: 105,
                            width: double.infinity,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: documents.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot document =
                                    snapshot.data!.docs[index];
                                Livestock livestock =
                                    Livestock.fromSnapshot(document);

                                return RecommendedCategoryCard(
                                  title: "Price :${livestock.price} " ??
                                      '', // Use the appropriate field from your data
                                  image: livestock.imagePath ??
                                      "", // Use the appropriate field from your data
                                  onPress: () {},
                                );
                              },
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),

              //==================================User stories===================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('all mandi'.tr, style: AppFonts.boldText),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 115,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: MaveshiMandi.maweshiMandiData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final city =
                                MaveshiMandi.maweshiMandiData[index]['city'];
                            final day =
                                MaveshiMandi.maweshiMandiData[index]['day'];
                            final image =
                                MaveshiMandi.maweshiMandiPics[index]['pic'];
                            return UserStory(
                              title: city ?? "",
                              image: image ?? "",
                              onPress: () {},
                              subTitle: day ?? "",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //==============================All Pakistan mall maveshi mandis===================
            ],
          ),
        ),
      ),
    );
  }
}
