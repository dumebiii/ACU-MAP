import 'package:acumap/ui/common/app_colors.dart';
import 'package:acumap/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

class IconcolText extends StatelessWidget {
  const IconcolText({
    super.key,
    required this.sectext,
    required this.firsttext,
    required this.icon,
    required this.font1,
    required this.font2,
  });
  final Widget icon;
  final String firsttext;
  final String sectext;
  final double font1;
  final double font2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        horizontalSpaceSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                firsttext,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: font1,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: kblue,
                ),
              ),
              Text(
                sectext,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: font2,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  color: kblue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
