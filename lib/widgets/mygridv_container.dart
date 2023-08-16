import 'package:flutter/material.dart';

class MyGridviewContainer extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback press;
  const MyGridviewContainer({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.white24,
                  blurRadius: 4,
                  offset: Offset(4, 8), // Shadow position
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
                FittedBox(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'Nunito',
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
