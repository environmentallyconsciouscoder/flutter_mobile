import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/enums/caddy_size.dart';
import 'package:limetrack/enums/scan_mode.dart';
import 'package:limetrack/enums/waste_type.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'register_caddy_viewmodel.dart';
import 'register_caddy_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'caddyCode'),
  ],
)
class RegisterCaddyView extends StatelessWidget with $RegisterCaddyView {
  final Caddy caddy;
  final ScanMode scanMode;

  RegisterCaddyView({super.key, required this.caddy, this.scanMode = ScanMode.auto});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterCaddyViewModel>.reactive(
      onModelReady: (model) async {
        listenToFormUpdated(model);

        await model.initialise();

        caddyCodeController.text = model.caddy.qrCode!;
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
          child: Column(
            children: [
              LimeText.headline('Register caddy'),
              UI.verticalSpaceExtraSmall,
              LimeText.body(
                'Before you can use this caddy, it needs to be assigned to an office. '
                'Select the office address, the caddy size and the type of food waste it will contain.',
                align: TextAlign.center,
              ),
              UI.verticalSpaceMedium,
              FocusTraversalGroup(
                policy: WidgetOrderTraversalPolicy(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: caddyCodeController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Caddy code',
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
                        labelText: 'Location of caddy',
                        border: UnderlineInputBorder(),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => (model.addressId == null) ? 'required' : null,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    DropdownButtonFormField<String>(
                      items: CaddySize.values.toList().map<DropdownMenuItem<String>>((CaddySize caddySize) {
                        return DropdownMenuItem(
                          value: caddySize.volume.toString(),
                          child: Text(caddySize.description),
                        );
                      }).toList(),
                      value: model.size,
                      onChanged: (value) => model.size = value ?? '',
                      elevation: 4,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                      ),
                      isExpanded: true,
                      dropdownColor: kcPrimaryLightestColor,
                      focusColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: 'Size of caddy',
                        border: UnderlineInputBorder(),
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    DropdownButtonFormField<String>(
                      items: WasteType.values.toList().map<DropdownMenuItem<String>>((WasteType value) {
                        return DropdownMenuItem(
                          value: value.appWriteEnum,
                          child: Text(value.description),
                        );
                      }).toList(),
                      value: model.wasteType,
                      onChanged: (value) => model.wasteType = value ?? '',
                      elevation: 4,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 2.0),
                        child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                      ),
                      isExpanded: true,
                      dropdownColor: kcPrimaryLightestColor,
                      focusColor: Colors.white,
                      decoration: const InputDecoration(
                        labelText: 'Type of food waste',
                        border: UnderlineInputBorder(),
                      ),
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
      viewModelBuilder: () => RegisterCaddyViewModel(caddy: caddy, scanMode: scanMode),
    );
  }
}
