import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/enums/simple_company_type.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'producer_registration_viewmodel.dart';
import 'producer_registration_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'companyName'),
    FormTextField(name: 'companyNumber'),
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
  ],
)
class ProducerRegistrationView extends StatelessWidget with $ProducerRegistrationView {
  ProducerRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return ViewModelBuilder<ProducerRegistrationViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
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
                                    'Before you can continue, you will need to provide some details about how your company is registered.',
                                    color: kcSecondaryColor,
                                    align: TextAlign.center,
                                  ),
                                  UI.verticalSpaceMedium,
                                  FocusTraversalGroup(
                                    policy: WidgetOrderTraversalPolicy(),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        LimeText.headingFour('Business'),
                                        TextField(
                                          controller: companyNameController,
                                          focusNode: companyNameFocusNode,
                                          decoration: InputDecoration(
                                            border: const UnderlineInputBorder(),
                                            labelText: 'Business name',
                                            errorText: model.getCompanyNameErrorText,
                                          ),
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          textCapitalization: TextCapitalization.words,
                                          autofocus: true,
                                          autocorrect: true,
                                        ),
                                        DropdownButtonFormField<String>(
                                          items:
                                              SimpleCompanyType.values.toList().map<DropdownMenuItem<String>>((SimpleCompanyType simpleCompanyType) {
                                            return DropdownMenuItem(
                                              value: simpleCompanyType.appWriteEnum,
                                              child: Text(simpleCompanyType.description),
                                            );
                                          }).toList(),
                                          value: model.simpleCompanyType?.appWriteEnum,
                                          onChanged: model.simpleCompanyTypeOnChanged,
                                          elevation: 4,
                                          icon: const Padding(
                                            padding: EdgeInsets.only(right: 2.0),
                                            child: Icon(Icons.expand_circle_down, color: kcPrimaryColor),
                                          ),
                                          isExpanded: true,
                                          dropdownColor: kcPrimaryLightestColor,
                                          focusColor: Colors.white,
                                          decoration: const InputDecoration(
                                            labelText: 'Business type',
                                            border: UnderlineInputBorder(),
                                          ),
                                          validator: (value) => model.simpleCompanyType == null ? 'required' : null,
                                          autovalidateMode: AutovalidateMode.always,
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                        if (model.simpleCompanyType != null && model.simpleCompanyType == SimpleCompanyType.registeredCompany)
                                          TextField(
                                            controller: companyNumberController,
                                            focusNode: companyNumberFocusNode,
                                            decoration: InputDecoration(
                                              border: const UnderlineInputBorder(),
                                              labelText: 'Company registration number',
                                              errorText: model.getCompanyNumberErrorText,
                                            ),
                                            keyboardType: TextInputType.number,
                                            textInputAction: TextInputAction.next,
                                            autocorrect: false,
                                          ),
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
                                        LimeText.headingFour('Registered address'),
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
                                        ),
                                        UI.verticalSpaceMedium,
                                        LimeText.headingFour(
                                            (model.simpleCompanyType == SimpleCompanyType.registeredCompany) ? 'Company contact' : 'Primary contact'),
                                        LimeText.small('The main business contact, who may be different to daily on-site contact'),
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
                                          textInputAction: TextInputAction.done,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\+0-9]'))],
                                          autocorrect: false,
                                          onSubmitted: (value) => model.saveData(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  UI.verticalSpaceMedium,
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
      viewModelBuilder: () => ProducerRegistrationViewModel(),
    );
  }
}
