import 'package:flutter/material.dart';

class DDBTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback press;
  final String address;
  const DDBTile({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.press,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: InkWell(
        onTap: press,
        child: Card(
          elevation: 5,
          child: Container(
            width: 120,
            height: 100,
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
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    imagePath,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Nunito',
                  ),
                ),
                Text(
                  address,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Nunito',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
