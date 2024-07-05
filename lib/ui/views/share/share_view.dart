import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'share_viewmodel.dart';

class ShareView extends StatelessWidget {
  const ShareView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ShareViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.close_outlined, onLeadingIconTap: model.navigateBack),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              UI.verticalSpaceMedium,
              LimeText.headingThree('Share'),
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
      viewModelBuilder: () => ShareViewModel(),
    );
  }
}
