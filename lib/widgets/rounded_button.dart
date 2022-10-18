import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String image;
  final double height;
  final Function()? onTap;
  const RoundedButton(
      {Key? key,
      required this.image,
      required this.color,
      required this.height,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(40, 40),
      child: ClipOval(
        child: Material(
          color: color,
          child: InkWell(
            splashColor: Colors.black12,
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  height: height,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
