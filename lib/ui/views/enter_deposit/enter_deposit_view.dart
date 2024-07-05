import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/models/bin.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'enter_deposit_viewmodel.dart';
import 'enter_deposit_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'code'),
  ],
)
class EnterDepositView extends StatelessWidget with $EnterDepositView {
  final Bin bin;

  EnterDepositView({super.key, required this.bin});

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return ViewModelBuilder<EnterDepositViewModel>.reactive(
      onModelReady: (model) async {
        listenToFormUpdated(model);

        codeController.text = bin.qrCode!;
        await model.getListOfDeposits();
      },
      onDispose: (_) => disposeForm(),
      disposeViewModel: false,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => model.navigateBack(),
          ),
          title: const Text('Deposit your food waste'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 25, 15, 10),
          child: Column(
            children: [
              LimeText.body(
                "Confirm which of the following food waste weights below you will deposit into this bin.",
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: model.transfers.keys.map((transfer) {
                      return CheckboxListTile(
                          value: model.transfers[transfer] ?? false,
                          title: Text('${(transfer.weight! / 1000).toStringAsFixed(1)}kg'),
                          subtitle: Text('weighed on ${DateFormat("d MMM 'at' HH:mm").format(transfer.timestamp)}'),
                          visualDensity: const VisualDensity(vertical: -2),
                          onChanged: (value) {
                            model.toggleTransferState(transfer, value);
                          });
                    }).toList(),
                  ),
                ),
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
                      : const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                ),
              ),
              SizedBox(
                height: UI.screenHeightPercentage(context, percentage: !isLandscape ? 0.045 : 0.10),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => EnterDepositViewModel(bin: bin),
    );
  }
}
