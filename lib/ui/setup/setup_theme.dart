import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

Future<ThemeData> getTheme() async {
  final String themeStr = await rootBundle.loadString('assets/themes/limetrack_light_theme.json');
  final themeJson = jsonDecode(themeStr);

  return ThemeDecoder.decodeThemeData(themeJson)!;
}
