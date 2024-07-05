import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.router.dart';
import 'package:limetrack/ui/setup/setup_dialog_ui.dart';
import 'package:limetrack/ui/setup/setup_bottom_sheet_ui.dart';
import 'package:limetrack/ui/setup/setup_snackbar_ui.dart';
import 'package:limetrack/ui/setup/setup_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise the location services
  setupLocator();

  // register the custom dialogs and snackbar
  setupDialogUi();
  setupBottomSheetUi();
  setupSnackbarUi();

  runApp(MyApp(theme: await getTheme()));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Limetrack',
      theme: theme,
      initialRoute: Routes.startupView,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
