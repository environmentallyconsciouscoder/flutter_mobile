// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String CaddyCodeValueKey = 'caddyCode';

final Map<String, TextEditingController>
    _RegisterCaddyViewTextEditingControllers = {};

final Map<String, FocusNode> _RegisterCaddyViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _RegisterCaddyViewTextValidations = {
  CaddyCodeValueKey: null,
};

mixin $RegisterCaddyView on StatelessWidget {
  TextEditingController get caddyCodeController =>
      _getFormTextEditingController(CaddyCodeValueKey);
  FocusNode get caddyCodeFocusNode => _getFormFocusNode(CaddyCodeValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_RegisterCaddyViewTextEditingControllers.containsKey(key)) {
      return _RegisterCaddyViewTextEditingControllers[key]!;
    }
    _RegisterCaddyViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _RegisterCaddyViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_RegisterCaddyViewFocusNodes.containsKey(key)) {
      return _RegisterCaddyViewFocusNodes[key]!;
    }
    _RegisterCaddyViewFocusNodes[key] = FocusNode();
    return _RegisterCaddyViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    caddyCodeController.addListener(() => _updateFormData(model));
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
          CaddyCodeValueKey: caddyCodeController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the dynamic
  void _updateValidationData(dynamic model) => model.setValidationMessages({
        CaddyCodeValueKey: _getValidationMessage(CaddyCodeValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _RegisterCaddyViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_RegisterCaddyViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _RegisterCaddyViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _RegisterCaddyViewFocusNodes.values) {
      focusNode.dispose();
    }

    _RegisterCaddyViewTextEditingControllers.clear();
    _RegisterCaddyViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get caddyCodeValue => this.formValueMap[CaddyCodeValueKey] as String?;

  bool get hasCaddyCode => this.formValueMap.containsKey(CaddyCodeValueKey);

  bool get hasCaddyCodeValidationMessage =>
      this.fieldsValidationMessages[CaddyCodeValueKey]?.isNotEmpty ?? false;

  String? get caddyCodeValidationMessage =>
      this.fieldsValidationMessages[CaddyCodeValueKey];
}

extension Methods on FormViewModel {
  setCaddyCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[CaddyCodeValueKey] = validationMessage;
}
