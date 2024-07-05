import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class LimeActivityCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String subtitle;
  final Future<void> Function()? onTap;
  final Future<void> Function()? onLongPress;
  final IconData? trailingIcon;
  final Future<void> Function()? onTrailingIconTap;

  const LimeActivityCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.onLongPress,
    this.trailingIcon,
    this.onTrailingIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kcPrimaryLightestColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: ListTile(
        leading: Icon(leadingIcon, size: 40, color: kcSecondaryLightColor),
        title: LimeText.body(title, color: kcSecondaryDarkColor),
        subtitle: LimeText.caption(subtitle, color: kcSecondaryLightColor),
        onTap: onTap,
        onLongPress: onLongPress,
        trailing: (trailingIcon != null)
            ? IconButton(
                icon: Icon(trailingIcon, size: 28, color: kcSecondaryLightColor),
                onPressed: onTrailingIconTap,
              )
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
