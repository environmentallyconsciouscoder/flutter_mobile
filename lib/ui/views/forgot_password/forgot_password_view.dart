import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/ui/widgets/authentication_layout.dart';

import 'forgot_password_viewmodel.dart';
import 'forgot_password_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'email'),
  ],
)
class ForgotPasswordView extends StatelessWidget with $ForgotPasswordView {
  ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackTapped: model.backTapped,
          title: 'Forgot Password',
          subtitle: 'We get it, stuff happens. Just enter your email address below '
              'and we\'ll send you a link to reset your password.',
          form: Column(
            children: [
              TextField(
                controller: emailController,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.alternate_email_outlined),
                  border: const UnderlineInputBorder(),
                  labelText: 'Email',
                  errorText: model.getEmailErrorText,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.send,
                autocorrect: false,
                onSubmitted: (value) => model.saveData(),
              ),
            ],
          ),
          validationMessage: model.validationMessage,
          mainButtonTitle: 'Reset',
          mainButtonEnabled: model.isResetButtonEnabled,
          onMainButtonTapped: model.saveData,
        ),
      ),
      viewModelBuilder: () => ForgotPasswordViewModel(),
    );
  }
}
