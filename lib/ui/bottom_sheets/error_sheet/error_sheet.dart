import 'package:flutter/material.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';

class ErrorSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const ErrorSheet({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: kcRedMediumColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title!,
            style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w900),
          ),
          UI.verticalSpaceTiny,
          Text(
            request.description!,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            softWrap: true,
          ),
          if (request.mainButtonTitle != null && request.mainButtonTitle!.isNotEmpty) ...[
            UI.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: UI.halfScreenWidth(context),
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () => completer(SheetResponse(confirmed: true)),
                    style: ElevatedButton.styleFrom(backgroundColor: kcBackgroundColor),
                    child: LimeText.bodyBold(request.mainButtonTitle!, color: kcRedMediumColor),
                  ),
                ),
              ],
            ),
          ],
          UI.verticalSpaceLarge,
        ],
      ),
    );
  }
}
