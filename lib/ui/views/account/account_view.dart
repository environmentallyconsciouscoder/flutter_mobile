import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter/scheduler.dart';
import 'package:limetrack/ui/widgets/lime_list_tile.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'account_viewmodel.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      viewModelBuilder: () => AccountViewModel(),
      builder: (context, model, child) => FGBGNotifier(
        onEvent: (value) => model.foregroundBackgroundEvent(value),
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: model.navigateBack),
                actions: [
                  IconButton(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    iconSize: 30,
                    icon: const Icon(Icons.power_settings_new),
                    onPressed: () => model.logoutUser(),
                  ),
                ],
                centerTitle: true,
                pinned: true,
                expandedHeight: 195,
                flexibleSpace: FlexibleSpaceBar(
                  title: Image.asset('assets/images/limetrack_logo_white_horizontal.webp', height: 30),
                  background: Container(
                    padding: const EdgeInsets.only(top: 50, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LimeText.headingFive(model.userName, color: kcPrimaryUltraLightColor),
                        LimeText.small(model.userEmail, color: kcPrimaryLightestColor),
                        UI.verticalSpaceExtraSmall,
                        LimeText.headingSix(model.siteName, color: kcPrimaryUltraLightColor),
                        LimeText.small(model.addressLine1, color: kcPrimaryLightestColor),
                        if (model.hasAddressTown) LimeText.small(model.addressTown, color: kcPrimaryLightestColor),
                        LimeText.small(model.addressPostcode, color: kcPrimaryLightestColor),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  UI.verticalSpaceExtraSmall,

                  // manage notifications
                  LimeListTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notification settings',
                    subtitle: 'Manage which notifications you would like to receive and how often',
                    onPressed: () => model.navigateToNotificationSettings(),
                  ),

                  // manage account
                  LimeListTile(
                    icon: Icons.manage_accounts_outlined,
                    title: 'Manage account',
                    subtitle: 'Update your password, contact information and business details',
                    onPressed: () => model.navigateToManageAccount(),
                  ),

                  // manage team
                  LimeListTile(
                    icon: Icons.people_alt_outlined,
                    title: 'Manage team',
                    subtitle: 'Add and remove people on your team who can use Limetrack',
                    onPressed: () => model.navigateToManageTeam(),
                  ),

                  // manage bins and caddies
                  LimeListTile(
                    icon: Icons.delete_outline,
                    title: 'Manage bins & caddies',
                    subtitle: 'Add and remove bins and caddies registered to your business',
                    onPressed: () => model.navigateToManageBinsAndCaddies(),
                  ),

                  // manage liners
                  LimeListTile(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Manage liners',
                    subtitle: 'Order additional liners or delay an order that is due soon',
                    onPressed: () => model.navigateToManageLiners(),
                  ),

                  // add in some extra spacing at the bottom to allow
                  // the user to scroll the list upwards and hide the
                  // account information. We can remove this as we add
                  // more items to the management list
                  UI.verticalSpaceMassive,
                  UI.verticalSpaceMassive,
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
