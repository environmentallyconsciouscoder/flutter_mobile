import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/enums/bottom_sheet_type.dart';
import 'package:limetrack/ui/bottom_sheets/error_sheet/error_sheet.dart';
import 'package:limetrack/ui/bottom_sheets/floating_error_sheet/floating_error_sheet.dart';
import 'package:limetrack/ui/bottom_sheets/notice_sheet/notice_sheet.dart';
import 'package:limetrack/ui/bottom_sheets/warning_sheet/warning_sheet.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final Map<dynamic, Widget Function(BuildContext, SheetRequest<dynamic>, void Function(SheetResponse<dynamic>))> builders = {
    BottomSheetType.notice: (context, sheetRequest, completer) => NoticeSheet(completer: completer, request: sheetRequest),
    BottomSheetType.warning: (context, sheetRequest, completer) => WarningSheet(completer: completer, request: sheetRequest),
    BottomSheetType.error: (context, sheetRequest, completer) => ErrorSheet(request: sheetRequest, completer: completer),
    BottomSheetType.floatingError: (context, sheetRequest, completer) => FloatingErrorSheet(request: sheetRequest, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
