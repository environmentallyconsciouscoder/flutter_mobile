import 'package:flutter/material.dart';

class LimeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData? leadingIcon;
  final void Function()? onLeadingIconTap;
  final void Function()? onShareTap;
  final List<Widget>? actions;

  const LimeAppBar({
    super.key,
    this.leadingIcon,
    this.onLeadingIconTap,
    this.onShareTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: (leadingIcon != null) ? IconButton(icon: Icon(leadingIcon), onPressed: onLeadingIconTap) : null,
      title: Image.asset('assets/images/limetrack_logo_white_horizontal.webp', height: 30),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
