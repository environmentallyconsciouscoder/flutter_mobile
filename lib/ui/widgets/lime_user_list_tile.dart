import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class LimeUserListTile extends StatelessWidget {
  final IconData? icon;
  final String name;
  final String email;
  final DateTime joinedDate;
  final bool enabled;
  final Function(BuildContext)? onDelete;

  const LimeUserListTile({
    super.key,
    this.icon,
    required this.name,
    required this.email,
    required this.joinedDate,
    this.enabled = true,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Slidable(
          enabled: enabled,
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const StretchMotion(),
            children: [
              CustomSlidableAction(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                onPressed: onDelete,
                child: const Icon(Icons.delete_outline, size: 32),
              ),
            ],
          ),
          child: Card(
            color: kcPrimaryLightestColor,
            elevation: 2.0,
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(icon, size: 32.0, color: kcPrimaryDarkerColor),
                    ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LimeText.headingFive(name, color: kcPrimaryDarkestColor),
                        LimeText.body(email, color: kcPrimaryDarkestColor),
                        UI.verticalSpaceTiny,
                        LimeText.small(DateFormat('d MMMM yyy').format(joinedDate.toLocal()), color: kcPrimaryDarkerColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
