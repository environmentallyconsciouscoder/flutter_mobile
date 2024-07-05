import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:upgrader/upgrader.dart';

import 'package:limetrack/ui/widgets/authentication_layout.dart';

import 'login_viewmodel.dart';
import 'login_view.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'email'),
    FormTextField(name: 'password'),
  ],
)
class LoginView extends StatelessWidget with $LoginView {
  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Scaffold(
        body: UpgradeAlert(
          upgrader: Upgrader(
            appcastConfig: model.appcastConfig,
            messages: model.customUpgraderMessages,
            debugLogging: model.isDeveloperEnvironment,
            showIgnore: false,
          ),
          child: AuthenticationLayout(
            busy: model.isBusy,
            title: 'Login',
            subtitle: 'Enter your email address to sign in',
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
            onForgotPasswordTapped: model.forgotPassword,
            validationMessage: model.validationMessage,
            mainButtonTitle: 'Continue',
            mainButtonEnabled: model.isContinueButtonEnabled,
            onMainButtonTapped: model.saveData,
            onSignupTapped: model.navigateToRegister,
            // TODO:
            //Implement single sign-on (SSO) for Apple, Google, Facebook and Microsoft
            //onSignInWithApple: model.useAppleAuthentication,
            //onSignInWithGoogle: model.useGoogleAuthentication,
            //onSignInWithFacebook: model.useFacebookAuthentication,
            //onSignInWithMicrosoft: model.useMicrosoftAuthentication,
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
