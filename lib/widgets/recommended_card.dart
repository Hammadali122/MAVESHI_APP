import 'package:flutter/material.dart';

class RecommendedCategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPress;
  const RecommendedCategoryCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        elevation: 3,
        child: SizedBox(
          height: 110,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 109,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      softWrap: true,
                      title,
                      style: const TextStyle(fontSize: 13),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
