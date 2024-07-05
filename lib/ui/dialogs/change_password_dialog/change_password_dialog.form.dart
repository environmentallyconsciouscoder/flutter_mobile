// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String OldPasswordValueKey = 'oldPassword';
const String NewPasswordValueKey = 'newPassword';
const String RetypePasswordValueKey = 'retypePassword';

final Map<String, TextEditingController>
    _ChangePasswordDialogTextEditingControllers = {};

final Map<String, FocusNode> _ChangePasswordDialogFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ChangePasswordDialogTextValidations = {
  OldPasswordValueKey: null,
  NewPasswordValueKey: null,
  RetypePasswordValueKey: null,
};

mixin $ChangePasswordDialog on StatelessWidget {
  TextEditingController get oldPasswordController =>
      _getFormTextEditingController(OldPasswordValueKey);
  TextEditingController get newPasswordController =>
      _getFormTextEditingController(NewPasswordValueKey);
  TextEditingController get retypePasswordController =>
      _getFormTextEditingController(RetypePasswordValueKey);
  FocusNode get oldPasswordFocusNode => _getFormFocusNode(OldPasswordValueKey);
  FocusNode get newPasswordFocusNode => _getFormFocusNode(NewPasswordValueKey);
  FocusNode get retypePasswordFocusNode =>
      _getFormFocusNode(RetypePasswordValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ChangePasswordDialogTextEditingControllers.containsKey(key)) {
      return _ChangePasswordDialogTextEditingControllers[key]!;
    }
    _ChangePasswordDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ChangePasswordDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ChangePasswordDialogFocusNodes.containsKey(key)) {
      return _ChangePasswordDialogFocusNodes[key]!;
    }
    _ChangePasswordDialogFocusNodes[key] = FocusNode();
    return _ChangePasswordDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    oldPasswordController.addListener(() => _updateFormData(model));
    newPasswordController.addListener(() => _updateFormData(model));
    retypePasswordController.addListener(() => _updateFormData(model));
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
          OldPasswordValueKey: oldPasswordController.text,
          NewPasswordValueKey: newPasswordController.text,
          RetypePasswordValueKey: retypePasswordController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        OldPasswordValueKey: _getValidationMessage(OldPasswordValueKey),
        NewPasswordValueKey: _getValidationMessage(NewPasswordValueKey),
        RetypePasswordValueKey: _getValidationMessage(RetypePasswordValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ChangePasswordDialogTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_ChangePasswordDialogTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ChangePasswordDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ChangePasswordDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _ChangePasswordDialogTextEditingControllers.clear();
    _ChangePasswordDialogFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get oldPasswordValue =>
      this.formValueMap[OldPasswordValueKey] as String?;
  String? get newPasswordValue =>
      this.formValueMap[NewPasswordValueKey] as String?;
  String? get retypePasswordValue =>
      this.formValueMap[RetypePasswordValueKey] as String?;

  bool get hasOldPassword => this.formValueMap.containsKey(OldPasswordValueKey);
  bool get hasNewPassword => this.formValueMap.containsKey(NewPasswordValueKey);
  bool get hasRetypePassword =>
      this.formValueMap.containsKey(RetypePasswordValueKey);

  bool get hasOldPasswordValidationMessage =>
      this.fieldsValidationMessages[OldPasswordValueKey]?.isNotEmpty ?? false;
  bool get hasNewPasswordValidationMessage =>
      this.fieldsValidationMessages[NewPasswordValueKey]?.isNotEmpty ?? false;
  bool get hasRetypePasswordValidationMessage =>
      this.fieldsValidationMessages[RetypePasswordValueKey]?.isNotEmpty ??
      false;

  String? get oldPasswordValidationMessage =>
      this.fieldsValidationMessages[OldPasswordValueKey];
  String? get newPasswordValidationMessage =>
      this.fieldsValidationMessages[NewPasswordValueKey];
  String? get retypePasswordValidationMessage =>
      this.fieldsValidationMessages[RetypePasswordValueKey];
}

extension Methods on FormViewModel {
  setOldPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OldPasswordValueKey] = validationMessage;
  setNewPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[NewPasswordValueKey] = validationMessage;
  setRetypePasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RetypePasswordValueKey] = validationMessage;
}
