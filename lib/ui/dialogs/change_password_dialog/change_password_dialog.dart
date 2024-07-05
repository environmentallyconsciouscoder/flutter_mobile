import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'change_password_dialog_viewmodel.dart';
import 'change_password_dialog.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'oldPassword'),
    FormTextField(name: 'newPassword'),
    FormTextField(name: 'retypePassword'),
  ],
)
class ChangePasswordDialog extends StatelessWidget with $ChangePasswordDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  ChangePasswordDialog({
    super.key,
    required this.request,
    required this.completer,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordDialogViewModel>.reactive(
      onModelReady: (model) => listenToFormUpdated(model),
      onDispose: (_) => disposeForm(),
      builder: (context, model, child) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 32,
                left: 16,
                right: 16,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UI.verticalSpaceExtraSmall,
                    LimeText.subheading(request.title ?? '', align: TextAlign.center),
                    UI.verticalSpaceExtraSmall,
                    LimeText.small(request.description ?? '', align: TextAlign.center),
                    UI.verticalSpaceExtraSmall,
                    TextField(
                      controller: oldPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                          color: kcSecondaryColor,
                          onPressed: model.toggleOldPasswordVisible,
                          icon: model.oldPasswordVisible ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                        ),
                        border: const UnderlineInputBorder(),
                        labelText: 'Current Password',
                        errorText: model.getOldPasswordErrorText,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      autocorrect: false,
                      obscureText: !model.oldPasswordVisible,
                    ),
                    TextField(
                      controller: newPasswordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.key_outlined),
                        suffixIcon: IconButton(
                          color: kcSecondaryColor,
                          onPressed: model.toggleNewPasswordVisible,
                          icon: model.newPasswordVisible ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                        ),
                        border: const UnderlineInputBorder(),
                        labelText: 'New Password',
                        errorText: model.getNewPasswordErrorText,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                      autocorrect: false,
                      obscureText: !model.newPasswordVisible,
                    ),
                    if (!model.newPasswordVisible)
                      TextField(
                        controller: retypePasswordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key_outlined),
                          suffixIcon: IconButton(
                            color: kcSecondaryColor,
                            onPressed: model.toggleRetypePasswordVisible,
                            icon: model.retypePasswordVisible ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
                          ),
                          border: const UnderlineInputBorder(),
                          labelText: 'Retype Password',
                          errorText: model.getRetypePasswordErrorText,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        autofocus: true,
                        autocorrect: false,
                        obscureText: !model.retypePasswordVisible,
                      ),
                    UI.verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (request.secondaryButtonTitle != null)
                          SizedBox(
                            height: 40,
                            child: OutlinedButton(
                              onPressed: () => completer(DialogResponse(confirmed: false)),
                              child: Text(request.secondaryButtonTitle!),
                            ),
                          ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: model.isButtonEnabled
                                ? () => completer(DialogResponse(
                                      confirmed: true,
                                      data: {
                                        'newPassword': newPasswordController.text.trim(),
                                        'oldPassword': oldPasswordController.text.trim(),
                                      },
                                    ))
                                : null,
                            //child: LimeText.dialogButton(request.mainButtonTitle ?? '', color: Colors.white),
                            child: Text(request.mainButtonTitle ?? ''),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: -28,
              child: CircleAvatar(
                minRadius: 16,
                maxRadius: 28,
                backgroundColor: kcPrimaryColor,
                child: Icon(
                  Icons.lock_outlined,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => ChangePasswordDialogViewModel(),
    );
  }
}
