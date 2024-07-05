import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/formatters/upper_case_text_formatter.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'qr_code_entry_dialog_viewmodel.dart';
import 'qr_code_entry_dialog.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'code'),
  ],
)
class QrCodeEntryDialog extends StatelessWidget with $QrCodeEntryDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  QrCodeEntryDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrCodeEntryDialogViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UI.verticalSpaceExtraSmall,
                    LimeText.subheading(
                      request.title ?? '',
                      align: TextAlign.center,
                    ),
                    if (request.description != null) UI.verticalSpaceExtraSmall,
                    if (request.description != null)
                      LimeText.body(
                        request.description ?? '',
                        align: TextAlign.center,
                      ),
                    UI.verticalSpaceExtraSmall,
                    TextField(
                      controller: codeController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.qr_code),
                        border: const UnderlineInputBorder(),
                        labelText: 'Code',
                        errorText: model.getCodeErrorText,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [UpperCaseTextFormatter()],
                      autofocus: true,
                      autocorrect: false,
                      onSubmitted: (value) => completer(DialogResponse(confirmed: true, data: codeController.text.trim())),
                    ),
                    UI.verticalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (request.secondaryButtonTitle != null)
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () => completer(DialogResponse(confirmed: false)),
                              child: LimeText.dialogButton(request.secondaryButtonTitle!, color: Colors.black),
                            ),
                          ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed:
                                model.isButtonEnabled ? () => completer(DialogResponse(confirmed: true, data: codeController.text.trim())) : null,
                            child: LimeText.dialogButton(request.mainButtonTitle ?? '', color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: -28,
              child: CircleAvatar(
                minRadius: 16,
                maxRadius: 28,
                backgroundColor: kcPrimaryColor,
                child: Icon(
                  Icons.qr_code,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => QrCodeEntryDialogViewModel(),
    );
  }
}
