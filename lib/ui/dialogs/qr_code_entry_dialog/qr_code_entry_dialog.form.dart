// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CodeValueKey = 'code';

final Map<String, TextEditingController>
    _QrCodeEntryDialogTextEditingControllers = {};

final Map<String, FocusNode> _QrCodeEntryDialogFocusNodes = {};

final Map<String, String? Function(String?)?>
    _QrCodeEntryDialogTextValidations = {
  CodeValueKey: null,
};

mixin $QrCodeEntryDialog on StatelessWidget {
  TextEditingController get codeController =>
      _getFormTextEditingController(CodeValueKey);
  FocusNode get codeFocusNode => _getFormFocusNode(CodeValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_QrCodeEntryDialogTextEditingControllers.containsKey(key)) {
      return _QrCodeEntryDialogTextEditingControllers[key]!;
    }
    _QrCodeEntryDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _QrCodeEntryDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_QrCodeEntryDialogFocusNodes.containsKey(key)) {
      return _QrCodeEntryDialogFocusNodes[key]!;
    }
    _QrCodeEntryDialogFocusNodes[key] = FocusNode();
    return _QrCodeEntryDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    codeController.addListener(() => _updateFormData(model));
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
          CodeValueKey: codeController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        CodeValueKey: _getValidationMessage(CodeValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _QrCodeEntryDialogTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_QrCodeEntryDialogTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _QrCodeEntryDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _QrCodeEntryDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _QrCodeEntryDialogTextEditingControllers.clear();
    _QrCodeEntryDialogFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get codeValue => this.formValueMap[CodeValueKey] as String?;

  bool get hasCode => this.formValueMap.containsKey(CodeValueKey);

  bool get hasCodeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey]?.isNotEmpty ?? false;

  String? get codeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey];
}

extension Methods on FormViewModel {
  setCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CodeValueKey] = validationMessage;
}
