import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'add_user_to_team_dialog_viewmodel.dart';
import 'add_user_to_team_dialog.form.dart';

@FormView(
  fields: [
    FormTextField(name: 'name'),
    FormTextField(name: 'email'),
  ],
)
class AddUserToTeamDialog extends StatelessWidget with $AddUserToTeamDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  AddUserToTeamDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddUserToTeamDialogViewModel>.reactive(
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
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline_outlined),
                        border: const UnderlineInputBorder(),
                        labelText: 'Full name',
                        errorText: model.getNameErrorText,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                      autocorrect: false,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.alternate_email_outlined),
                        border: const UnderlineInputBorder(),
                        labelText: 'Email',
                        errorText: model.getEmailErrorText,
                        isDense: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autofocus: false,
                      autocorrect: false,
                      onSubmitted: (value) => model.isButtonEnabled
                          ? completer(DialogResponse(
                              confirmed: true,
                              data: {
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                              },
                            ))
                          : null,
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
                              child: LimeText.dialogButton(request.secondaryButtonTitle!, color: Colors.black),
                            ),
                          ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: model.isButtonEnabled
                                ? () => completer(DialogResponse(
                                      confirmed: true,
                                      data: {
                                        'name': nameController.text.trim(),
                                        'email': emailController.text.trim(),
                                      },
                                    ))
                                : null,
                            child: LimeText.dialogButton(request.mainButtonTitle ?? '', color: Colors.white),
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
                  Icons.group_add_outlined,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AddUserToTeamDialogViewModel(),
    );
  }
}
