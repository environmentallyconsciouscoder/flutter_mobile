// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String BinCodeValueKey = 'binCode';

final Map<String, TextEditingController>
    _RegisterBinViewTextEditingControllers = {};

final Map<String, FocusNode> _RegisterBinViewFocusNodes = {};

final Map<String, String? Function(String?)?> _RegisterBinViewTextValidations =
    {
  BinCodeValueKey: null,
};

mixin $RegisterBinView on StatelessWidget {
  TextEditingController get binCodeController =>
      _getFormTextEditingController(BinCodeValueKey);
  FocusNode get binCodeFocusNode => _getFormFocusNode(BinCodeValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_RegisterBinViewTextEditingControllers.containsKey(key)) {
      return _RegisterBinViewTextEditingControllers[key]!;
    }
    _RegisterBinViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _RegisterBinViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_RegisterBinViewFocusNodes.containsKey(key)) {
      return _RegisterBinViewFocusNodes[key]!;
    }
    _RegisterBinViewFocusNodes[key] = FocusNode();
    return _RegisterBinViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    binCodeController.addListener(() => _updateFormData(model));
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
          BinCodeValueKey: binCodeController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        BinCodeValueKey: _getValidationMessage(BinCodeValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _RegisterBinViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_RegisterBinViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _RegisterBinViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _RegisterBinViewFocusNodes.values) {
      focusNode.dispose();
    }

    _RegisterBinViewTextEditingControllers.clear();
    _RegisterBinViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get binCodeValue => this.formValueMap[BinCodeValueKey] as String?;

  bool get hasBinCode => this.formValueMap.containsKey(BinCodeValueKey);

  bool get hasBinCodeValidationMessage =>
      this.fieldsValidationMessages[BinCodeValueKey]?.isNotEmpty ?? false;

  String? get binCodeValidationMessage =>
      this.fieldsValidationMessages[BinCodeValueKey];
}

extension Methods on FormViewModel {
  setBinCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[BinCodeValueKey] = validationMessage;
}
