import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AnimalListTile extends StatelessWidget {
  final String name;
  final String subTitle;
  final String description;
  final String image;
  final VoidCallback onPress;
  final VoidCallback favPress;
  final IconData faveIcon;
  final Color color;
  const AnimalListTile(
      {Key? key,
      required this.name,
      required this.subTitle,
      required this.image,
      required this.description,
      required this.onPress,
      required this.faveIcon,
      required this.color,
      required this.favPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: onPress,
        child: Stack(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black87),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(fontFamily: 'Nunito'),
                          ),
                          Text(subTitle),
                          FittedBox(
                              child: Text(
                            description,
                            style: const TextStyle(fontSize: 10),
                          ))
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
                    onTap: favPress,
                    child: Icon(
                      Icons.favorite,
                      color: color,
                    ))),
            Positioned(
                top: 95.0,
                left: 290.0,
                right: 10.0,
                bottom: 10.0,
                child: Container(
                    height: 10,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.green),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text("for sale".tr,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
