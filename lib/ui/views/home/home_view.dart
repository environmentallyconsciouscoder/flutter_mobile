import 'package:flutter/material.dart';

import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:stacked/stacked.dart';
import 'package:upgrader/upgrader.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_activity_card.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_dashboard_card.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => UpgradeAlert(
        upgrader: Upgrader(
          appcastConfig: model.appcastConfig,
          messages: model.customUpgraderMessages,
          debugLogging: model.isVerboseLogging,
          showIgnore: false,
        ),
        child: FGBGNotifier(
          onEvent: (value) => model.foregroundBackgroundEvent(value),
          child: Scaffold(
            appBar: LimeAppBar(actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: model.onShareWithUser,
              ),
            ]),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                children: [
                  LimeText.headingFour(model.userGreeting),
                  UI.verticalSpaceTiny,
                  LimeText.body('This month ${model.siteName} has'),
                  UI.verticalSpaceExtraSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LimeDashboardCard(header: 'SEPARATED', body: model.totalWeighed, footer: 'FOOD WASTE'),
                      LimeDashboardCard(header: 'AVOIDED', body: model.co2Equivalent, footer: 'CO\u2082 EQUIVALENT', onTap: model.cO2EquivalentInfo),
                    ],
                  ),
                  UI.verticalSpaceExtraSmall,
                  UI.verticalSpaceExtraSmall,
                  LimeText.headingFour('Your recent activity'),
                  UI.verticalSpaceExtraSmall,
                  Expanded(
                    child: ListView(
                      children: [
                        // recent activity - weighed
                        LimeActivityCard(
                          leadingIcon: Icons.scale_outlined,
                          title: model.lastWeighedWeight,
                          subtitle: model.lastWeighedDate,
                          onLongPress: model.navigateToTransferDetailView,
                        ),
                        UI.verticalSpaceTiny,
                        // recent activity - deposited
                        LimeActivityCard(
                          leadingIcon: Icons.delete_outline,
                          title: model.lastDepositedWeight,
                          subtitle: model.lastDepositedDate,
                          trailingIcon: (model.depositInferred) ? Icons.info_outline : null,
                          onTrailingIconTap: model.depositEstimateInfo,
                        ),
                        UI.verticalSpaceTiny,
                        // recent activity - collected
                        LimeActivityCard(
                          leadingIcon: Icons.local_shipping_outlined,
                          title: model.totalCollectedWeight,
                          subtitle: model.lastCollectedDate,
                        ),
                        // closest bin for food waste deposits
                        if (model.isNonHospitality) UI.verticalSpaceTiny,
                        if (model.isNonHospitality)
                          LimeActivityCard(
                            leadingIcon: Icons.location_on_outlined,
                            title: 'Your nearest bin share',
                            subtitle: model.nearestBinShareAddress,
                            trailingIcon: (model.depositInferred) ? Icons.info_outline : null,
                            onTrailingIconTap: model.nearestLocationInfo,
                          ),
                        UI.verticalSpaceExtraSmall,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: _bottomNavigationBar(model),
            floatingActionButton: _floatingActionButton(model),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  BottomAppBar _bottomNavigationBar(HomeViewModel model) {
    return BottomAppBar(
      color: kcSecondaryColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Reports
            Padding(
              //padding: const EdgeInsets.only(left: 20.0),
              padding: const EdgeInsets.only(top: 10, left: 20.0),
              child: IconButton(
                iconSize: 32,
                color: kcPrimaryLightestColor,
                hoverColor: kcPrimaryColor,
                icon: const Icon(Icons.bar_chart),
                onPressed: () => model.navigateToReportsView(),
              ),
            ),

            // Account
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20.0),
              child: IconButton(
                iconSize: 32,
                color: kcPrimaryLightestColor,
                hoverColor: kcPrimaryColor,
                icon: const Icon(Icons.person),
                onPressed: () => model.navigateToAccountView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _floatingActionButton(HomeViewModel model) {
    return SizedBox(
      height: 72,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.qr_code_scanner, size: 28),
              Text('SCAN', style: TextStyle(fontSize: 10)),
            ],
          ),
          onPressed: () => model.navigateToScanView(),
        ),
      ),
    );
  }
}
