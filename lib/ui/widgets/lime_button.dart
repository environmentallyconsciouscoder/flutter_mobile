import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/app_styles.dart';

class LimeButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;

  const LimeButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
  })  : outline = false,
        super(key: key);

  const LimeButton.outline({
    Key? key,
    required this.title,
    this.onTap,
    this.leading,
  })  : disabled = false,
        busy = false,
        outline = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? kcPrimaryColor : kcSecondaryColor,
                borderRadius: BorderRadius.circular(5.0),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: kcPrimaryColor, width: 1),
              ),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) const SizedBox(width: 5),
                  Text(
                    title,
                    style: bodyStyle.copyWith(
                      fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                      color: !outline ? Colors.white : kcPrimaryColor,
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
