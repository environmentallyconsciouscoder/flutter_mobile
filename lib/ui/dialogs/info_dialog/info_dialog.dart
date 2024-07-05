import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class InfoDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                UI.verticalSpaceMinute,
                LimeText.subheading(request.title ?? '', color: kcSecondaryDarkColor, align: TextAlign.center),
                UI.verticalSpaceTiny,
                LimeText.body(request.description ?? '', color: kcSecondaryLightColor, align: TextAlign.center),
                UI.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () => completer(DialogResponse(confirmed: true)),
                          child: const Text(' OK '),
                        ),
                      ),
                    ),
                  ],
                ),
                UI.verticalSpaceExtraSmall,
              ],
            ),
          ),
          const Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: kcPrimaryColor,
              child: Icon(Icons.info_outline, size: 45, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
