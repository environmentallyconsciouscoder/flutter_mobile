// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CodeValueKey = 'code';
const String WeightValueKey = 'weight';

final Map<String, TextEditingController>
    _EnterWeightViewTextEditingControllers = {};

final Map<String, FocusNode> _EnterWeightViewFocusNodes = {};

final Map<String, String? Function(String?)?> _EnterWeightViewTextValidations =
    {
  CodeValueKey: null,
  WeightValueKey: null,
};

mixin $EnterWeightView on StatelessWidget {
  TextEditingController get codeController =>
      _getFormTextEditingController(CodeValueKey);
  TextEditingController get weightController =>
      _getFormTextEditingController(WeightValueKey);
  FocusNode get codeFocusNode => _getFormFocusNode(CodeValueKey);
  FocusNode get weightFocusNode => _getFormFocusNode(WeightValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_EnterWeightViewTextEditingControllers.containsKey(key)) {
      return _EnterWeightViewTextEditingControllers[key]!;
    }
    _EnterWeightViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _EnterWeightViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_EnterWeightViewFocusNodes.containsKey(key)) {
      return _EnterWeightViewFocusNodes[key]!;
    }
    _EnterWeightViewFocusNodes[key] = FocusNode();
    return _EnterWeightViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    codeController.addListener(() => _updateFormData(model));
    weightController.addListener(() => _updateFormData(model));
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
          WeightValueKey: weightController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        CodeValueKey: _getValidationMessage(CodeValueKey),
        WeightValueKey: _getValidationMessage(WeightValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _EnterWeightViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_EnterWeightViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _EnterWeightViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _EnterWeightViewFocusNodes.values) {
      focusNode.dispose();
    }

    _EnterWeightViewTextEditingControllers.clear();
    _EnterWeightViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get codeValue => this.formValueMap[CodeValueKey] as String?;
  String? get weightValue => this.formValueMap[WeightValueKey] as String?;

  bool get hasCode => this.formValueMap.containsKey(CodeValueKey);
  bool get hasWeight => this.formValueMap.containsKey(WeightValueKey);

  bool get hasCodeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey]?.isNotEmpty ?? false;
  bool get hasWeightValidationMessage =>
      this.fieldsValidationMessages[WeightValueKey]?.isNotEmpty ?? false;

  String? get codeValidationMessage =>
      this.fieldsValidationMessages[CodeValueKey];
  String? get weightValidationMessage =>
      this.fieldsValidationMessages[WeightValueKey];
}

extension Methods on FormViewModel {
  setCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CodeValueKey] = validationMessage;
  setWeightValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[WeightValueKey] = validationMessage;
}
