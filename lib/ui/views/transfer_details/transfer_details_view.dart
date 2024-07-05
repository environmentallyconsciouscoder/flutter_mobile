import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'transfer_details_viewmodel.dart';

class TransferDetailsView extends StatelessWidget {
  const TransferDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TransferDetailsViewModel>.reactive(
      onModelReady: (model) => SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      viewModelBuilder: () => TransferDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.close_outlined, onLeadingIconTap: model.navigateBack),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: LimeText.headingFour('All Transfers'),
              ),
              UI.verticalSpaceSmall,
              if (model.transferDetailsList.isEmpty) ...[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(color: kcPrimaryColor, strokeWidth: 6),
                        ),
                        UI.verticalSpaceSmall,
                        LimeText.bodyBold('Fetching transfer details...'),
                        UI.verticalSpaceExtraLarge,
                      ],
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: ListView.builder(
                    itemCount: model.transferDetailsList.length,
                    prototypeItem: Card(
                      elevation: 2.0,
                      child: ListTile(
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LimeText.bodyBold(model.transferDetailsList.first.id),
                            LimeText.caption(model.transferDetailsList.first.id),
                            UI.verticalSpaceTiny,
                          ],
                        ),
                        subtitle: LimeText.caption('Blockchain hash: ${model.transferDetailsList.first.hash}', color: kcSecondaryLightColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        tileColor: kcPrimaryLightestColor,
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return Builder(builder: (context) {
                        return Card(
                          elevation: 2.0,
                          child: ListTile(
                            title: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimeText.bodyBold(model.transferDetailsList[index].id),
                                LimeText.caption(
                                    '${(model.transferDetailsList[index].weight / 1000).toStringAsFixed(1)}kg ${model.transferDetailsList[index].type} on ${DateFormat("y-MM-dd HH:mm").format(model.transferDetailsList[index].timestamp.toLocal())}'),
                                UI.verticalSpaceTiny,
                              ],
                            ),
                            subtitle: LimeText.caption('Blockchain hash: ${model.transferDetailsList[index].hash}', color: kcSecondaryLightColor),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            tileColor: kcPrimaryLightestColor,
                          ),
                        );
                      });
                    },
                  ),
                ),
                UI.verticalSpaceLarge,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
