import 'package:flutter/material.dart';

class BottomSheetItems extends StatelessWidget {
  final String title;
  const BottomSheetItems({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            color: const Color(0xff2769ab),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontFamily: 'Nunito'),
        )),
      ),
    );
  }
}
