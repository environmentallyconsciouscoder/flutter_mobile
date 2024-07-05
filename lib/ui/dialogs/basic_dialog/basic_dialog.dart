import 'package:flutter/material.dart';

import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/enums/basic_dialog_status.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

class BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const BasicDialog({
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
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04,
            ),
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
                const SizedBox(height: 10.0),
                LimeText.subheading(
                  request.title ?? '',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                LimeText.body(
                  request.description ?? '',
                  align: TextAlign.center,
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (request.secondaryButtonTitle != null)
                      SizedBox(
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () => completer(DialogResponse(confirmed: false)),
                          child: LimeText.dialogButton(
                            request.secondaryButtonTitle!,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => completer(DialogResponse(confirmed: true)),
                        child: LimeText.dialogButton(
                          request.mainButtonTitle ?? '',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: _getStatusColor(request.data),
              child: Icon(
                //_getStatusIcon(request.customData),
                _getStatusIcon(request.data),
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(dynamic data) {
    if (data is BasicDialogStatus) {
      switch (data) {
        case BasicDialogStatus.error:
          return kcRedColor;
        case BasicDialogStatus.warning:
          return kcOrangeColor;
        default:
          return kcPrimaryColor;
      }
    } else {
      return kcPrimaryColor;
    }
  }

  IconData _getStatusIcon(dynamic data) {
    if (data is BasicDialogStatus) {
      switch (data) {
        case BasicDialogStatus.error:
          return Icons.close;
        case BasicDialogStatus.warning:
          return Icons.warning_amber;
        default:
          return Icons.check;
      }
    } else {
      return Icons.check;
    }
  }
}
