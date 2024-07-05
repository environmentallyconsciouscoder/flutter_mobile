import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'enter_weight_viewmodel.dart';
import 'enter_weight_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'code'),
    FormTextField(name: 'weight'),
  ],
)
class EnterWeightView extends StatelessWidget with $EnterWeightView {
  final Caddy caddy;

  EnterWeightView({super.key, required this.caddy});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EnterWeightViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);

        codeController.text = caddy.qrCode!;
      },
      onDispose: (_) => disposeForm(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => model.navigateBack(),
          ),
          title: const Text('Weigh your food waste'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                LimeText.body(
                  "Weigh your food waste caddy, including the contents. We'll take care of the rest.",
                  align: TextAlign.center,
                ),
                UI.verticalSpaceMedium,
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.qr_code),
                    border: UnderlineInputBorder(),
                    labelText: 'QR code',
                  ),
                  readOnly: true,
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.scale),
                    border: const UnderlineInputBorder(),
                    labelText: 'Weight (kg)',
                    errorText: model.getWeightErrorText,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.next,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\.0-9]'))],
                  autofocus: true,
                  autocorrect: false,
                ),
                UI.verticalSpaceLarge,
                GestureDetector(
                  onTap: model.isContinueButtonEnabled ? model.saveData : null,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: model.isContinueButtonEnabled ? kcPrimaryColor : kcSecondaryUltraLightColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: model.isBusy
                        ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                        : Text(
                            'Continue',
                            style: TextStyle(
                              color: model.isContinueButtonEnabled ? Colors.white : kcSecondaryLightestColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => EnterWeightViewModel(caddy: caddy),
    );
  }
}
