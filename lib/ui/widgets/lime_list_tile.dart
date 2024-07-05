import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class LimeListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  //final Future<void> Function() onPressed;
  final void Function() onPressed;

  const LimeListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: kcPrimaryLightestColor,
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(icon, size: 32.0, color: kcPrimaryDarkerColor),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LimeText.headingFive(title, color: kcPrimaryDarkestColor),
                      UI.verticalSpaceTiny,
                      LimeText.small(subtitle, color: kcPrimaryDarkerColor),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.arrow_forward_ios, size: 32.0, color: kcPrimaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
