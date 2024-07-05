import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'account_management_bins_and_caddies_viewmodel.dart';

class AccountManagementBinsAndCaddiesView extends StatelessWidget {
  const AccountManagementBinsAndCaddiesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountManagementBinsAndCaddiesViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      viewModelBuilder: () => AccountManagementBinsAndCaddiesViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              UI.verticalSpaceExtraSmall,
              LimeText.headingThree('Manage Bins & Caddies'),
              UI.verticalSpaceExtraSmall,
              LimeText.body('Register a new bin or caddy', align: TextAlign.center),
              UI.verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: model.canHostBinShare ? model.registerNewBin : null,
                    child: Container(
                      alignment: Alignment.center,
                      width: UI.screenWidthPercentage(context, percentage: 0.24),
                      height: 40,
                      child: const Text('New Bin'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: model.registerNewCaddy,
                    child: Container(
                      alignment: Alignment.center,
                      width: UI.screenWidthPercentage(context, percentage: 0.24),
                      height: 40,
                      child: const Text('New Caddy'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
