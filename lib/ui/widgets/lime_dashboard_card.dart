import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class LimeDashboardCard extends StatelessWidget {
  final String header;
  final String body;
  final String footer;
  final void Function()? onTap;

  const LimeDashboardCard({
    super.key,
    required this.header,
    required this.body,
    required this.footer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: kcPrimaryLightColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: SizedBox(
          width: UI.screenWidthPercentage(context, percentage: 0.4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 5.0),
            child: Column(
              children: [
                LimeText.dashboardHeader(header),
                UI.verticalSpaceMinute,
                LimeText.dashboardBody(body),
                UI.verticalSpaceMinute,
                LimeText.dashboardFooter(footer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
