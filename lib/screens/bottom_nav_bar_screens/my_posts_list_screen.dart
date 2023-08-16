import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:maveshi/screens/auth/different_auth/sell_yr_animal.dart';
import 'package:maveshi/utils/utils.dart';

import '../../models/livestock_model.dart';
import '../auth/sign_in_screen.dart';

class MyPostsScreen extends StatefulWidget {
  static const routeName = '/my-posts';

  const MyPostsScreen({super.key});

  @override
  _MyPostsScreenState createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  String? currentUserID;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

//=================current user=====================================
  void fetchCurrentUser() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        currentUserID = currentUser.uid;
      });
    }
  }

  //==============post deletion=====================================
  void deletePost(String postId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('SellYourAnimal')
                      .doc(currentUserID)
                      .delete();
                  Navigator.of(context).pop();
                } catch (error) {
                  Utils().toastMessage(error.toString());
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Posts'),
      ),
      floatingActionButton: currentUserID != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SellYourAnimal(animalType: '')));
              },
              child: const Text('Sell'),
            )
          : Center(
              child: AlertDialog(
                  title: Text("attention".tr),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: Text('sign in'.tr))
                  ],
                  content: Text('sign in please'.tr)),
            ),
      body: currentUserID != null
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('SellYourAnimal')
                  .where('uid', isEqualTo: currentUserID)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error fetching posts'),
                  );
                }
                final posts = snapshot.data?.docs;
                if (posts == null || posts.isEmpty) {
                  return const Center(
                    child: Text('No posts found'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (ctx, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Livestock livestock = Livestock.fromSnapshot(document);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Card(
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black87),
                                      child: Image.network(
                                        livestock.imagePath ?? "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              doneMark(),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                livestock.sellerName ?? "",
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito'),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              doneMark(),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Text(livestock.price ?? ""),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 0.0,
                                left: 300.0,
                                right: 0.0,
                                bottom: 70.0,
                                child: InkWell(
                                    onTap: () {
                                      deletePost(currentUserID!);
                                    },
                                    child: const Icon(Icons.delete)))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text('User not logged in'),
            ),
    );
  }

  CircleAvatar doneMark() {
    return const CircleAvatar(
      radius: 8,
      child: Icon(
        Icons.done,
        color: Colors.white,
        size: 12,
      ),
    );
  }
}
