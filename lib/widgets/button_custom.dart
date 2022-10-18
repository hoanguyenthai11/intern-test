import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsApp.kPrimaryColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.black26,
        child: Container(
          alignment: Alignment.center,
          height: size.height * 0.05,
          width: size.width * 0.35,
          child: const Text(
            'ADD TO CART',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik'),
          ),
        ),
      ),
    );
  }
}
