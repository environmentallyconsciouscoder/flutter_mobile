// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CompanyNameValueKey = 'companyName';
const String CompanyNumberValueKey = 'companyNumber';
const String TradingAsValueKey = 'tradingAs';
const String AddressLine1ValueKey = 'addressLine1';
const String AddressLine2ValueKey = 'addressLine2';
const String AddressLine3ValueKey = 'addressLine3';
const String AddressTownValueKey = 'addressTown';
const String AddressPostcodeValueKey = 'addressPostcode';
const String ContactNameValueKey = 'contactName';
const String ContactEmailValueKey = 'contactEmail';
const String ContactPhoneValueKey = 'contactPhone';
const String ContactMobileValueKey = 'contactMobile';

final Map<String, TextEditingController>
    _ProducerRegistrationViewTextEditingControllers = {};

final Map<String, FocusNode> _ProducerRegistrationViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ProducerRegistrationViewTextValidations = {
  CompanyNameValueKey: null,
  CompanyNumberValueKey: null,
  TradingAsValueKey: null,
  AddressLine1ValueKey: null,
  AddressLine2ValueKey: null,
  AddressLine3ValueKey: null,
  AddressTownValueKey: null,
  AddressPostcodeValueKey: null,
  ContactNameValueKey: null,
  ContactEmailValueKey: null,
  ContactPhoneValueKey: null,
  ContactMobileValueKey: null,
};

mixin $ProducerRegistrationView on StatelessWidget {
  TextEditingController get companyNameController =>
      _getFormTextEditingController(CompanyNameValueKey);
  TextEditingController get companyNumberController =>
      _getFormTextEditingController(CompanyNumberValueKey);
  TextEditingController get tradingAsController =>
      _getFormTextEditingController(TradingAsValueKey);
  TextEditingController get addressLine1Controller =>
      _getFormTextEditingController(AddressLine1ValueKey);
  TextEditingController get addressLine2Controller =>
      _getFormTextEditingController(AddressLine2ValueKey);
  TextEditingController get addressLine3Controller =>
      _getFormTextEditingController(AddressLine3ValueKey);
  TextEditingController get addressTownController =>
      _getFormTextEditingController(AddressTownValueKey);
  TextEditingController get addressPostcodeController =>
      _getFormTextEditingController(AddressPostcodeValueKey);
  TextEditingController get contactNameController =>
      _getFormTextEditingController(ContactNameValueKey);
  TextEditingController get contactEmailController =>
      _getFormTextEditingController(ContactEmailValueKey);
  TextEditingController get contactPhoneController =>
      _getFormTextEditingController(ContactPhoneValueKey);
  TextEditingController get contactMobileController =>
      _getFormTextEditingController(ContactMobileValueKey);
  FocusNode get companyNameFocusNode => _getFormFocusNode(CompanyNameValueKey);
  FocusNode get companyNumberFocusNode =>
      _getFormFocusNode(CompanyNumberValueKey);
  FocusNode get tradingAsFocusNode => _getFormFocusNode(TradingAsValueKey);
  FocusNode get addressLine1FocusNode =>
      _getFormFocusNode(AddressLine1ValueKey);
  FocusNode get addressLine2FocusNode =>
      _getFormFocusNode(AddressLine2ValueKey);
  FocusNode get addressLine3FocusNode =>
      _getFormFocusNode(AddressLine3ValueKey);
  FocusNode get addressTownFocusNode => _getFormFocusNode(AddressTownValueKey);
  FocusNode get addressPostcodeFocusNode =>
      _getFormFocusNode(AddressPostcodeValueKey);
  FocusNode get contactNameFocusNode => _getFormFocusNode(ContactNameValueKey);
  FocusNode get contactEmailFocusNode =>
      _getFormFocusNode(ContactEmailValueKey);
  FocusNode get contactPhoneFocusNode =>
      _getFormFocusNode(ContactPhoneValueKey);
  FocusNode get contactMobileFocusNode =>
      _getFormFocusNode(ContactMobileValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ProducerRegistrationViewTextEditingControllers.containsKey(key)) {
      return _ProducerRegistrationViewTextEditingControllers[key]!;
    }
    _ProducerRegistrationViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ProducerRegistrationViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ProducerRegistrationViewFocusNodes.containsKey(key)) {
      return _ProducerRegistrationViewFocusNodes[key]!;
    }
    _ProducerRegistrationViewFocusNodes[key] = FocusNode();
    return _ProducerRegistrationViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    companyNameController.addListener(() => _updateFormData(model));
    companyNumberController.addListener(() => _updateFormData(model));
    tradingAsController.addListener(() => _updateFormData(model));
    addressLine1Controller.addListener(() => _updateFormData(model));
    addressLine2Controller.addListener(() => _updateFormData(model));
    addressLine3Controller.addListener(() => _updateFormData(model));
    addressTownController.addListener(() => _updateFormData(model));
    addressPostcodeController.addListener(() => _updateFormData(model));
    contactNameController.addListener(() => _updateFormData(model));
    contactEmailController.addListener(() => _updateFormData(model));
    contactPhoneController.addListener(() => _updateFormData(model));
    contactMobileController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the dynamic
  void _updateFormData(dynamic model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          CompanyNameValueKey: companyNameController.text,
          CompanyNumberValueKey: companyNumberController.text,
          TradingAsValueKey: tradingAsController.text,
          AddressLine1ValueKey: addressLine1Controller.text,
          AddressLine2ValueKey: addressLine2Controller.text,
          AddressLine3ValueKey: addressLine3Controller.text,
          AddressTownValueKey: addressTownController.text,
          AddressPostcodeValueKey: addressPostcodeController.text,
          ContactNameValueKey: contactNameController.text,
          ContactEmailValueKey: contactEmailController.text,
          ContactPhoneValueKey: contactPhoneController.text,
          ContactMobileValueKey: contactMobileController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        CompanyNameValueKey: _getValidationMessage(CompanyNameValueKey),
        CompanyNumberValueKey: _getValidationMessage(CompanyNumberValueKey),
        TradingAsValueKey: _getValidationMessage(TradingAsValueKey),
        AddressLine1ValueKey: _getValidationMessage(AddressLine1ValueKey),
        AddressLine2ValueKey: _getValidationMessage(AddressLine2ValueKey),
        AddressLine3ValueKey: _getValidationMessage(AddressLine3ValueKey),
        AddressTownValueKey: _getValidationMessage(AddressTownValueKey),
        AddressPostcodeValueKey: _getValidationMessage(AddressPostcodeValueKey),
        ContactNameValueKey: _getValidationMessage(ContactNameValueKey),
        ContactEmailValueKey: _getValidationMessage(ContactEmailValueKey),
        ContactPhoneValueKey: _getValidationMessage(ContactPhoneValueKey),
        ContactMobileValueKey: _getValidationMessage(ContactMobileValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ProducerRegistrationViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey = validatorForKey(
        _ProducerRegistrationViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _ProducerRegistrationViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ProducerRegistrationViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ProducerRegistrationViewTextEditingControllers.clear();
    _ProducerRegistrationViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get companyNameValue =>
      this.formValueMap[CompanyNameValueKey] as String?;
  String? get companyNumberValue =>
      this.formValueMap[CompanyNumberValueKey] as String?;
  String? get tradingAsValue => this.formValueMap[TradingAsValueKey] as String?;
  String? get addressLine1Value =>
      this.formValueMap[AddressLine1ValueKey] as String?;
  String? get addressLine2Value =>
      this.formValueMap[AddressLine2ValueKey] as String?;
  String? get addressLine3Value =>
      this.formValueMap[AddressLine3ValueKey] as String?;
  String? get addressTownValue =>
      this.formValueMap[AddressTownValueKey] as String?;
  String? get addressPostcodeValue =>
      this.formValueMap[AddressPostcodeValueKey] as String?;
  String? get contactNameValue =>
      this.formValueMap[ContactNameValueKey] as String?;
  String? get contactEmailValue =>
      this.formValueMap[ContactEmailValueKey] as String?;
  String? get contactPhoneValue =>
      this.formValueMap[ContactPhoneValueKey] as String?;
  String? get contactMobileValue =>
      this.formValueMap[ContactMobileValueKey] as String?;

  bool get hasCompanyName => this.formValueMap.containsKey(CompanyNameValueKey);
  bool get hasCompanyNumber =>
      this.formValueMap.containsKey(CompanyNumberValueKey);
  bool get hasTradingAs => this.formValueMap.containsKey(TradingAsValueKey);
  bool get hasAddressLine1 =>
      this.formValueMap.containsKey(AddressLine1ValueKey);
  bool get hasAddressLine2 =>
      this.formValueMap.containsKey(AddressLine2ValueKey);
  bool get hasAddressLine3 =>
      this.formValueMap.containsKey(AddressLine3ValueKey);
  bool get hasAddressTown => this.formValueMap.containsKey(AddressTownValueKey);
  bool get hasAddressPostcode =>
      this.formValueMap.containsKey(AddressPostcodeValueKey);
  bool get hasContactName => this.formValueMap.containsKey(ContactNameValueKey);
  bool get hasContactEmail =>
      this.formValueMap.containsKey(ContactEmailValueKey);
  bool get hasContactPhone =>
      this.formValueMap.containsKey(ContactPhoneValueKey);
  bool get hasContactMobile =>
      this.formValueMap.containsKey(ContactMobileValueKey);

  bool get hasCompanyNameValidationMessage =>
      this.fieldsValidationMessages[CompanyNameValueKey]?.isNotEmpty ?? false;
  bool get hasCompanyNumberValidationMessage =>
      this.fieldsValidationMessages[CompanyNumberValueKey]?.isNotEmpty ?? false;
  bool get hasTradingAsValidationMessage =>
      this.fieldsValidationMessages[TradingAsValueKey]?.isNotEmpty ?? false;
  bool get hasAddressLine1ValidationMessage =>
      this.fieldsValidationMessages[AddressLine1ValueKey]?.isNotEmpty ?? false;
  bool get hasAddressLine2ValidationMessage =>
      this.fieldsValidationMessages[AddressLine2ValueKey]?.isNotEmpty ?? false;
  bool get hasAddressLine3ValidationMessage =>
      this.fieldsValidationMessages[AddressLine3ValueKey]?.isNotEmpty ?? false;
  bool get hasAddressTownValidationMessage =>
      this.fieldsValidationMessages[AddressTownValueKey]?.isNotEmpty ?? false;
  bool get hasAddressPostcodeValidationMessage =>
      this.fieldsValidationMessages[AddressPostcodeValueKey]?.isNotEmpty ??
      false;
  bool get hasContactNameValidationMessage =>
      this.fieldsValidationMessages[ContactNameValueKey]?.isNotEmpty ?? false;
  bool get hasContactEmailValidationMessage =>
      this.fieldsValidationMessages[ContactEmailValueKey]?.isNotEmpty ?? false;
  bool get hasContactPhoneValidationMessage =>
      this.fieldsValidationMessages[ContactPhoneValueKey]?.isNotEmpty ?? false;
  bool get hasContactMobileValidationMessage =>
      this.fieldsValidationMessages[ContactMobileValueKey]?.isNotEmpty ?? false;

  String? get companyNameValidationMessage =>
      this.fieldsValidationMessages[CompanyNameValueKey];
  String? get companyNumberValidationMessage =>
      this.fieldsValidationMessages[CompanyNumberValueKey];
  String? get tradingAsValidationMessage =>
      this.fieldsValidationMessages[TradingAsValueKey];
  String? get addressLine1ValidationMessage =>
      this.fieldsValidationMessages[AddressLine1ValueKey];
  String? get addressLine2ValidationMessage =>
      this.fieldsValidationMessages[AddressLine2ValueKey];
  String? get addressLine3ValidationMessage =>
      this.fieldsValidationMessages[AddressLine3ValueKey];
  String? get addressTownValidationMessage =>
      this.fieldsValidationMessages[AddressTownValueKey];
  String? get addressPostcodeValidationMessage =>
      this.fieldsValidationMessages[AddressPostcodeValueKey];
  String? get contactNameValidationMessage =>
      this.fieldsValidationMessages[ContactNameValueKey];
  String? get contactEmailValidationMessage =>
      this.fieldsValidationMessages[ContactEmailValueKey];
  String? get contactPhoneValidationMessage =>
      this.fieldsValidationMessages[ContactPhoneValueKey];
  String? get contactMobileValidationMessage =>
      this.fieldsValidationMessages[ContactMobileValueKey];
}

extension Methods on FormViewModel {
  setCompanyNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CompanyNameValueKey] = validationMessage;
  setCompanyNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CompanyNumberValueKey] = validationMessage;
  setTradingAsValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TradingAsValueKey] = validationMessage;
  setAddressLine1ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressLine1ValueKey] = validationMessage;
  setAddressLine2ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressLine2ValueKey] = validationMessage;
  setAddressLine3ValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressLine3ValueKey] = validationMessage;
  setAddressTownValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressTownValueKey] = validationMessage;
  setAddressPostcodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AddressPostcodeValueKey] =
          validationMessage;
  setContactNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ContactNameValueKey] = validationMessage;
  setContactEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ContactEmailValueKey] = validationMessage;
  setContactPhoneValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ContactPhoneValueKey] = validationMessage;
  setContactMobileValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ContactMobileValueKey] = validationMessage;
}
