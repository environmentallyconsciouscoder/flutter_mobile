import 'dart:io';
import 'package:flutter/material.dart';

import 'package:auth_buttons/auth_buttons.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';

import 'lime_text.dart';

class AuthenticationLayout extends StatelessWidget {
  final bool busy;

  final void Function()? onBackTapped;
  final String? title;
  final String? subtitle;
  final Widget form;
  final void Function()? onForgotPasswordTapped;
  final String? validationMessage;
  final String? mainButtonTitle;
  final bool mainButtonEnabled;
  final void Function()? onMainButtonTapped;
  final void Function()? onSignupTapped;
  final void Function()? onSignInWithApple;
  final void Function()? onSignInWithGoogle;
  final void Function()? onSignInWithFacebook;
  final void Function()? onSignInWithMicrosoft;
  final bool showTermsText;

  const AuthenticationLayout({
    Key? key,
    this.busy = false,
    this.onBackTapped,
    this.title,
    this.subtitle,
    required this.form,
    this.onForgotPasswordTapped,
    this.validationMessage,
    this.mainButtonTitle,
    this.mainButtonEnabled = true,
    this.onMainButtonTapped,
    this.onSignupTapped,
    this.onSignInWithApple,
    this.onSignInWithGoogle,
    this.onSignInWithFacebook,
    this.onSignInWithMicrosoft,
    this.showTermsText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  kcPrimaryLightColor,
                  kcPrimaryColor,
                  kcPrimaryColor,
                  kcPrimaryDarkColor,
                  kcPrimaryDarkestColor,
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
                  height: UI.screenHeightPercentage(context, percentage: 0.30),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 1.0,
                        child: Image.asset(
                          'assets/images/limetrack_icon_grey-white.webp',
                          scale: 1.4,
                        ),
                      ),
                      if (onBackTapped != null)
                        Positioned(
                          top: 35,
                          left: 20,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            icon: const Icon(
                              Icons.arrow_back_ios,
                            ),
                            onPressed: onBackTapped,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              /// Form, Pre Footer, Footer
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
                                title!,
                              ),
                              UI.verticalSpaceExtraSmall,
                              LimeText.body(
                                subtitle!,
                                align: TextAlign.center,
                              ),
                              UI.verticalSpaceMedium,
                              form,
                              if (onForgotPasswordTapped != null) ...[
                                UI.verticalSpaceTiny,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: onForgotPasswordTapped,
                                    child: LimeText.captionBold('Forgot password?', color: kcPrimaryDarkerColor),
                                  ),
                                ),
                              ],
                              if (validationMessage != null) ...[
                                UI.verticalSpaceMedium,
                                LimeText.body(
                                  validationMessage!,
                                  color: kcRedColor,
                                ),
                              ],
                              UI.verticalSpaceLarge,
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: mainButtonEnabled ? onMainButtonTapped : null,
                                  child: busy
                                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))
                                      : Text(
                                          mainButtonTitle!,
                                          style: TextStyle(
                                            color: mainButtonEnabled ? Colors.white : kcSecondaryLightestColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              if (onSignupTapped != null) ...[
                                UI.verticalSpaceMedium,
                                GestureDetector(
                                  onTap: onSignupTapped,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      LimeText.smallBold("Don't have an account?"),
                                      UI.horizontalSpaceTiny,
                                      LimeText.headingSix('Register', color: kcPrimaryDarkColor),
                                    ],
                                  ),
                                ),
                              ],
                              if (onSignInWithApple != null ||
                                  onSignInWithGoogle != null ||
                                  onSignInWithFacebook != null ||
                                  onSignInWithMicrosoft != null) ...[
                                UI.verticalSpaceMedium,
                                Align(
                                  alignment: Alignment.center,
                                  child: LimeText.body('Or, continue with'),
                                ),
                                UI.verticalSpaceExtraSmall,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (Platform.isIOS && onSignInWithApple != null)
                                      AppleAuthButton(
                                        onPressed: onSignInWithApple ?? () {},
                                        text: 'Continue with Apple',
                                        style: const AuthButtonStyle(
                                          buttonType: AuthButtonType.icon,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    if (onSignInWithGoogle != null)
                                      GoogleAuthButton(
                                        onPressed: onSignInWithGoogle ?? () {},
                                        text: 'Continue with Google',
                                        style: const AuthButtonStyle(
                                          buttonType: AuthButtonType.icon,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    if (onSignInWithFacebook != null)
                                      FacebookAuthButton(
                                        onPressed: onSignInWithFacebook ?? () {},
                                        text: 'Continue with Facebook',
                                        style: const AuthButtonStyle(
                                          buttonType: AuthButtonType.icon,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    if (onSignInWithMicrosoft != null)
                                      MicrosoftAuthButton(
                                        onPressed: onSignInWithMicrosoft ?? () {},
                                        text: 'Continue with Microsoft',
                                        style: const AuthButtonStyle(
                                          buttonType: AuthButtonType.icon,
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                              if (showTermsText) ...[
                                UI.verticalSpaceMedium,
                                LimeText.small(
                                  'By registering you agree to our terms, conditions and privacy policy.',
                                  align: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
