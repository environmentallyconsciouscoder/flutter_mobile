import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/enums/bin_type.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/bin.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'register_bin_viewmodel.dart';
import 'register_bin_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'binCode'),
  ],
)
class RegisterBinView extends StatelessWidget with $RegisterBinView {
  final Bin bin;
  final ScanMode scanMode;

  RegisterBinView({super.key, required this.bin, this.scanMode = ScanMode.auto});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterBinViewModel>.reactive(
      onModelReady: (model) async {
        listenToFormUpdated(model);

        await model.initialise();

        binCodeController.text = model.bin.qrCode!;
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Column(
            children: [
              LimeText.headline('Register bin'),
              UI.verticalSpaceExtraSmall,
              LimeText.body(
                'Before you can use this bin, it needs to be assigned to an office. '
                'Select the office address where the bin is located and what kind of bin this is.',
                align: TextAlign.center,
              ),
              UI.verticalSpaceMedium,
              FocusTraversalGroup(
                policy: WidgetOrderTraversalPolicy(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: binCodeController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Bin code',
                      ),
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                    ),
                    DropdownButtonFormField<String>(
                      items: model.addresses.map<DropdownMenuItem<String>>((Address address) {
                        return DropdownMenuItem(
                          value: address.$id,
                          child: Text('${address.line1}${address.postcode.isNotEmpty ? ", ${address.postcode}" : ""}'),
                        );
                      }).toList(),
                      value: (model.addressId != null)
                          ? model.addressId
                          : (model.addresses.isNotEmpty)
                              ? model.addresses.first.$id
                              : null,
                      onChanged: (value) => model.addressId = value ?? '',
                      elevation: 4,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                      ),
                      isExpanded: true,
                      dropdownColor: kcPrimaryLightestColor,
                      focusColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: 'Location of bin',
                        border: UnderlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (model.addressId == null) ? 'required' : null,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    DropdownButtonFormField<String>(
                      items: BinType.values.toList().map<DropdownMenuItem<String>>((BinType value) {
                        return DropdownMenuItem(
                          value: value.appWriteEnum,
                          child: Text(value.description),
                        );
                      }).toList(),
                      onChanged: (value) => model.binType = value ?? '',
                      elevation: 4,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                      ),
                      isExpanded: true,
                      dropdownColor: kcPrimaryLightestColor,
                      focusColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: 'Type of bin',
                        border: UnderlineInputBorder(),
                      ),
                      value: model.binType,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ],
                ),
              ),
              UI.verticalSpaceLarge,
              GestureDetector(
                onTap: model.saveData,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: model.isBusy
                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                      : const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
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
      viewModelBuilder: () => RegisterBinViewModel(bin: bin, scanMode: scanMode),
    );
  }
}
