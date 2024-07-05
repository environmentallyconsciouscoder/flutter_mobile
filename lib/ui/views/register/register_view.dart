import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'package:limetrack/ui/widgets/authentication_layout.dart';

import 'register_viewmodel.dart';
import 'register_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'name'),
    FormTextField(name: 'email'),
    FormTextField(name: 'password'),
  ],
)
class RegisterView extends StatelessWidget with $RegisterView {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        body: AuthenticationLayout(
          busy: model.isBusy,
          onBackTapped: model.backTapped,
          title: 'Register',
          subtitle: 'Enter your name, email address and password to register with us',
          form: FocusTraversalGroup(
            policy: WidgetOrderTraversalPolicy(),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_outline_outlined),
                    border: const UnderlineInputBorder(),
                    labelText: 'Full name',
                    errorText: model.getNameErrorText,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  autocorrect: false,
                ),
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
                  textInputAction: TextInputAction.next,
                  autocorrect: false,
                ),
                TextField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.key_outlined),
                    suffixIcon: IconButton(
                      icon: model.passwordVisible ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                      onPressed: model.togglePasswordVisible,
                    ),
                    border: const UnderlineInputBorder(),
                    labelText: 'Password',
                    errorText: model.getPasswordErrorText,
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  obscureText: !model.passwordVisible,
                  onSubmitted: (value) => model.saveData(),
                ),
              ],
            ),
          ),
          validationMessage: model.validationMessage,
          mainButtonTitle: 'Continue',
          mainButtonEnabled: model.isContinueButtonEnabled,
          onMainButtonTapped: model.saveData,
          // TODO:
          //Implement single sign-on (SSO) for Apple, Google, Facebook and Microsoft
          //onSignInWithApple: model.useAppleAuthentication,
          //onSignInWithGoogle: model.useGoogleAuthentication,
          //onSignInWithFacebook: model.useFacebookAuthentication,
          //onSignInWithMicrosoft: model.useMicrosoftAuthentication,
          showTermsText: true,
        ),
      ),
      viewModelBuilder: () => RegisterViewModel(),
    );
  }
}
