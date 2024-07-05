import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_user_list_tile.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'account_management_team_viewmodel.dart';

class AccountManagementTeamView extends StatelessWidget {
  const AccountManagementTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountManagementTeamViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.initialise();
      }),
      viewModelBuilder: () => AccountManagementTeamViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.arrow_back_ios_new, onLeadingIconTap: model.navigateBack),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            children: [
              UI.verticalSpaceExtraSmall,
              LimeText.headingThree('Manage Team'),
              LimeText.body('If you are the team owner, you can add or remove someone from your team and manage who can use Limetrack',
                  align: TextAlign.center),
              UI.verticalSpaceMedium,
              if (model.membershipList.isEmpty) ...[
                UI.verticalSpaceMedium,
                Card(
                  color: kcPrimaryLightestColor,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 8.0, 0.0, 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LimeText.bodyBold(
                                'You are currently the only member of your team',
                                color: kcPrimaryDarkestColor,
                                align: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (model.membershipList.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.membershipList.length,
                    itemBuilder: (context, index) {
                      return LimeUserListTile(
                        name: model.membershipList[index].userName + (model.membershipList[index].roles.contains('owner') ? ' (owner)' : ''),
                        email: model.membershipList[index].userEmail,
                        joinedDate: DateTime.parse(model.membershipList[index].joined),
                        enabled: model.isTeamOwner,
                        onDelete: (context) => model.removeFromTeam(membership: model.membershipList[index]),
                      );
                    }),
            ],
          ),
        ),
        floatingActionButton: Ink(
          decoration: const ShapeDecoration(
            color: kcPrimaryColor,
            shape: CircleBorder(),
          ),
          child: IconButton(
            iconSize: 35,
            padding: const EdgeInsets.all(15.0),
            color: Colors.white,
            onPressed: model.isTeamOwner ? model.addToTeam : null,
            icon: model.isBusy ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white)) : const Icon(Icons.person_add),
          ),
        ),
      ),
    );
  }
}
