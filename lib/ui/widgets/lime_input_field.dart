import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';

class LimeInputField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
  );

  LimeInputField({
    Key? key,
    required this.controller,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: ThemeData(primaryColor: kcPrimaryColor),
      child: TextField(
        controller: controller,
        style: const TextStyle(height: 1),
        obscureText: password,
        decoration: InputDecoration(
          hintText: placeholder,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: kcSecondaryLightestColor,
          prefixIcon: leading,
          suffixIcon: trailing != null
              ? GestureDetector(
                  onTap: trailingTapped,
                  child: trailing,
                )
              : null,
          border: circularBorder.copyWith(
            borderSide: const BorderSide(color: kcSecondaryLightestColor),
          ),
          errorBorder: circularBorder.copyWith(
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedBorder: circularBorder.copyWith(
            borderSide: const BorderSide(color: kcPrimaryColor),
          ),
          enabledBorder: circularBorder.copyWith(
            borderSide: const BorderSide(color: kcSecondaryLightestColor),
          ),
        ),
      ),
    );
  }
}
