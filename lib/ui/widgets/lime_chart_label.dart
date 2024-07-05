import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class LimeChartLabel extends StatelessWidget {
  final Color iconColor;
  final String label;
  final Color labelColor;

  const LimeChartLabel({
    super.key,
    required this.iconColor,
    required this.label,
    this.labelColor = kcSecondaryLightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 50,
          decoration: BoxDecoration(shape: BoxShape.circle, color: iconColor),
        ),
        UI.horizontalSpaceTiny,
        LimeText.analyticsChartLabel(label, color: labelColor),
      ],
    );
  }
}
