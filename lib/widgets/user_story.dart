import 'package:flutter/material.dart';

import '../utils/fonts.dart';

class UserStory extends StatelessWidget {
  final String title;
  final String image;
  final String subTitle;
  final VoidCallback onPress;

  const UserStory({
    Key? key,
    required this.title,
    required this.image,
    required this.onPress,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Card(
        elevation: 3,
        child: SizedBox(
          height: 180,
          width: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 179,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    // Wrap with Flexible widget
                    child: Text(
                      title,
                      style: AppFonts.mandiText,
                      overflow: TextOverflow.ellipsis, // Add overflow property
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    // Wrap with Flexible widget
                    child: Text(
                      subTitle,
                      style: AppFonts.mandiText,
                      overflow: TextOverflow.ellipsis, // Add overflow property
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
