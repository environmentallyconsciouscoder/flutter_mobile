import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/enums/snackbar_type.dart';
import 'package:limetrack/ui/common/app_colors.dart';

void setupSnackbarUi() {
  final snackbarService = locator<SnackbarService>();

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.whiteOnRed,
    config: SnackbarConfig(
      backgroundColor: kcRedColor,
      titleColor: Colors.white,
      messageColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: 5,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.whiteOnGreen,
    config: SnackbarConfig(
      backgroundColor: kcPrimaryColor,
      titleColor: Colors.white,
      messageColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: 5,
    ),
  );

  snackbarService.registerCustomSnackbarConfig(
    variant: SnackbarType.whiteOnOrange,
    config: SnackbarConfig(
      backgroundColor: kcOrangeColor,
      titleColor: Colors.white,
      messageColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      borderRadius: 5,
    ),
  );
}
