import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/enums/site_type.dart';
import 'package:limetrack/enums/user_role.dart';
import 'package:limetrack/models/address.dart';
import 'package:limetrack/models/producer.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'producer_site_registration_viewmodel.dart';
import 'producer_site_registration_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'tradingAs'),
    FormTextField(name: 'addressLine1'),
    FormTextField(name: 'addressLine2'),
    FormTextField(name: 'addressLine3'),
    FormTextField(name: 'addressTown'),
    FormTextField(name: 'addressPostcode'),
    FormTextField(name: 'contactName'),
    FormTextField(name: 'contactEmail'),
    FormTextField(name: 'contactPhone'),
    FormTextField(name: 'contactMobile'),
    FormTextField(name: 'employees'),
  ],
)
class ProducerSiteRegistrationView extends StatelessWidget with $ProducerSiteRegistrationView {
  final Producer producer;
  final Address producerAddress;

  ProducerSiteRegistrationView({Key? key, required this.producer, required this.producerAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kcPrimaryColor;
      }
      return kcPrimaryDarkColor;
    }

    return ViewModelBuilder<ProducerSiteRegistrationViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);

        // pass the details from the previous page to our model
        model.setArguments(producer, producerAddress);

        // set the default values to use
        setDefaultTradingAdTextFieldValue();
        resetDefaultAddressTextFieldValues();
        setDefaultContactTextFieldValues();
      },
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      kcPrimaryColor,
                      kcPrimaryColor,
                      kcSecondaryColor,
                    ],
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: UI.screenHeightPercentage(context, percentage: 0.35),
                  child: Container(),
                ),
              ),
              CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: UI.screenHeightPercentage(context, percentage: !isLandscape ? 0.045 : 0.10),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 30.0,
                                horizontal: 20.0,
                              ),
                              child: Column(
                                children: [
                                  LimeText.headline(
                                    'Registration',
                                  ),
                                  UI.verticalSpaceExtraSmall,
                                  LimeText.body(
                                    'To finish, please tell us where your food waste is produced.',
                                    color: kcSecondaryColor,
                                    align: TextAlign.center,
                                  ),
                                  UI.verticalSpaceMedium,
                                  FocusTraversalGroup(
                                    policy: WidgetOrderTraversalPolicy(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        LimeText.headingFour('Company'),
                                        TextField(
                                          controller: tradingAsController,
                                          focusNode: tradingAsFocusNode,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Trading as (optional)',
                                          ),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autofocus: true,
                                          autocorrect: true,
                                        ),
                                        UI.verticalSpaceMedium,
                                        LimeText.headingFour('Address'),
                                        Row(
                                          children: [
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty.resolveWith(getColor),
                                              value: model.useSameAddressAsProducer,
                                              onChanged: (bool? value) {
                                                model.addressSameAsProducerOnChanged(value);

                                                if (value != null && value) {
                                                  setDefaultAddressTextFieldValues();
                                                } else {
                                                  resetDefaultAddressTextFieldValues();
                                                }
                                              },
                                            ),
                                            InkWell(
                                              onTap: model.addressSameAsProducerOnTap,
                                              child: const Text('Same as registered address'),
                                            ),
                                          ],
                                        ),
                                        TextField(
                                          controller: addressLine1Controller,
                                          focusNode: addressLine1FocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Line 1',
                                            errorText: model.getAddressLine1ErrorText,
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autocorrect: false,
                                          enabled: !model.useSameAddressAsProducer,
                                        ),
                                        TextField(
                                          controller: addressLine2Controller,
                                          focusNode: addressLine2FocusNode,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Line 2 (optional)',
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autocorrect: false,
                                          enabled: !model.useSameAddressAsProducer,
                                        ),
                                        TextField(
                                          controller: addressLine3Controller,
                                          focusNode: addressLine3FocusNode,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Line 3 (optional)',
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autocorrect: false,
                                          enabled: !model.useSameAddressAsProducer,
                                        ),
                                        TextField(
                                          controller: addressTownController,
                                          focusNode: addressTownFocusNode,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Town (optional)',
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autocorrect: false,
                                          enabled: !model.useSameAddressAsProducer,
                                        ),
                                        TextField(
                                          controller: addressPostcodeController,
                                          focusNode: addressPostcodeFocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Postcode',
                                            errorText: model.getAddressPostcodeErrorText,
                                          ),
                                          keyboardType: TextInputType.streetAddress,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.characters,
                                          autocorrect: false,
                                          enabled: !model.useSameAddressAsProducer,
                                        ),
                                        UI.verticalSpaceMedium,
                                        LimeText.headingFour('Contact'),
                                        Row(
                                          children: [
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty.resolveWith(getColor),
                                              value: model.useSameContactAsProducer,
                                              onChanged: (bool? value) {
                                                model.contactSameAsProducerOnChanged(value);

                                                if (value != null && value) {
                                                  setDefaultContactTextFieldValues();
                                                } else {
                                                  resetDefaultContactTextFieldValues();
                                                }
                                              },
                                            ),
                                            InkWell(
                                              onTap: model.contactSameAsProducerOnTap,
                                              child: const Text('Same as registered contact'),
                                            ),
                                          ],
                                        ),
                                        TextField(
                                          controller: contactNameController,
                                          focusNode: contactNameFocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Full name',
                                            errorText: model.getContactNameErrorText,
                                          ),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autocorrect: false,
                                          enabled: !model.useSameContactAsProducer,
                                        ),
                                        TextField(
                                          controller: contactEmailController,
                                          focusNode: contactEmailFocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Email',
                                            errorText: model.getContactEmailErrorText,
                                          ),
                                          keyboardType: TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          autocorrect: false,
                                          enabled: !model.useSameContactAsProducer,
                                        ),
                                        TextField(
                                          controller: contactPhoneController,
                                          focusNode: contactPhoneFocusNode,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Phone (optional)',
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\+0-9]'))],
                                          autocorrect: false,
                                          enabled: !model.useSameContactAsProducer,
                                        ),
                                        TextField(
                                          controller: contactMobileController,
                                          focusNode: contactMobileFocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Mobile',
                                            errorText: model.getContactMobileErrorText,
                                          ),
                                          keyboardType: TextInputType.phone,
                                          textInputAction: TextInputAction.next,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\+0-9]'))],
                                          autocorrect: false,
                                          enabled: !model.useSameContactAsProducer,
                                        ),
                                        UI.verticalSpaceMedium,
                                        LimeText.headingFour('Other important details'),
                                        DropdownButtonFormField<String>(
                                          items: SiteType.values.toList().map<DropdownMenuItem<String>>((SiteType siteType) {
                                            return DropdownMenuItem(
                                              value: siteType.appWriteEnum,
                                              child: Text(siteType.description),
                                            );
                                          }).toList(),
                                          value: model.siteType?.appWriteEnum,
                                          onChanged: model.siteTypeOnChanged,
                                          elevation: 4,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 2.0),
                                            child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                                          ),
                                          isExpanded: true,
                                          dropdownColor: kcPrimaryLightestColor,
                                          focusColor: Colors.white,
                                          decoration: const InputDecoration(
                                            labelText: 'This is a...',
                                            border: UnderlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode.always,
                                          validator: (value) => model.siteType == null ? 'required' : null,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        DropdownButtonFormField<String>(
                                          items: UserRole.values.toList().map<DropdownMenuItem<String>>((UserRole userRole) {
                                            return DropdownMenuItem(
                                              value: userRole.appWriteEnum,
                                              child: Text(userRole.description),
                                            );
                                          }).toList(),
                                          value: model.userRole?.appWriteEnum,
                                          onChanged: model.userRoleOnChanged,
                                          elevation: 4,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 2.0),
                                            child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                                          ),
                                          isExpanded: true,
                                          dropdownColor: kcPrimaryLightestColor,
                                          focusColor: Colors.white,
                                          decoration: const InputDecoration(
                                            labelText: 'My role here is...',
                                            border: UnderlineInputBorder(),
                                          ),
                                          autovalidateMode: AutovalidateMode.always,
                                          validator: (value) => model.userRole == null ? 'required' : null,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        TextField(
                                          controller: employeesController,
                                          decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Employees on-site (optional)',
                                          ),
                                          keyboardType: TextInputType.number,
                                          textInputAction: TextInputAction.done,
                                          autocorrect: false,
                                          onSubmitted: (value) => model.saveData(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  UI.verticalSpaceMedium,
                                  GestureDetector(
                                    onTap: model.isFinishButtonEnabled ? model.saveData : null,
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: model.isFinishButtonEnabled ? kcPrimaryColor : kcSecondaryUltraLightColor,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: model.isBusy
                                          ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                                          : Text(
                                              'Finish',
                                              style: TextStyle(
                                                color: model.isFinishButtonEnabled ? Colors.white : kcSecondaryLightestColor,
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
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: UI.screenHeightPercentage(context, percentage: !isLandscape ? 0.045 : 0.10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ProducerSiteRegistrationViewModel(),
    );
  }

  void setDefaultTradingAdTextFieldValue() {
    if (producer.tradingAs != null && producer.tradingAs!.isNotEmpty) {
      tradingAsController.text = producer.tradingAs!;
    }
  }

  void resetDefaultAddressTextFieldValues() {
    addressLine1Controller.text = '';
    addressLine2Controller.text = '';
    addressLine3Controller.text = '';
    addressTownController.text = '';
    addressPostcodeController.text = '';
  }

  void setDefaultAddressTextFieldValues() {
    addressLine1Controller.text = producerAddress.line1;
    addressLine2Controller.text = producerAddress.line2 ?? '';
    addressLine3Controller.text = producerAddress.line3 ?? '';
    addressTownController.text = producerAddress.town ?? '';
    addressPostcodeController.text = producerAddress.postcode;
  }

  void resetDefaultContactTextFieldValues() {
    contactNameController.text = '';
    contactEmailController.text = '';
    contactPhoneController.text = '';
    contactMobileController.text = '';
  }

  void setDefaultContactTextFieldValues() {
    contactNameController.text = producer.contact.name;
    contactEmailController.text = producer.contact.email ?? '';
    contactPhoneController.text = producer.contact.phone ?? '';
    contactMobileController.text = producer.contact.mobile ?? '';
  }
}
