import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'account_management_notifications_viewmodel.dart';

class AccountManagementNotificationsView extends StatelessWidget {
  const AccountManagementNotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountManagementNotificationsViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      viewModelBuilder: () => AccountManagementNotificationsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              UI.verticalSpaceMedium,
              LimeText.headingThree('Notification Settings'),
              UI.verticalSpaceTiny,
              LimeText.small('Under development'),
              UI.verticalSpaceMedium,
              LimeText.body(
                'We are working hard to build the best possible product for you.\n\nIf you have any ideas '
                'or suggestions of what you might like to see on this page, please reach out to us.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
