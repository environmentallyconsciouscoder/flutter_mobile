import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:expandable/expandable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:limetrack/enums/analytics_navigation.dart';
import 'package:limetrack/enums/analytics_type.dart';
import 'package:limetrack/enums/waste_type.dart';
import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/ui.dart';
import 'package:limetrack/ui/widgets/lime_app_bar.dart';
import 'package:limetrack/ui/widgets/lime_chart_label.dart';
import 'package:limetrack/ui/widgets/lime_text.dart';

import 'reports_viewmodel.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportsViewModel>.reactive(
      onModelReady: ((model) => SchedulerBinding.instance.scheduleFrameCallback((timeStamp) => model.runStartupLogic())),
      viewModelBuilder: () => ReportsViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: LimeAppBar(leadingIcon: Icons.close_outlined, onLeadingIconTap: model.navigateBack),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Column(
            children: [
              LimeText.headingFour('Waste Analytics'),
              UI.verticalSpaceExtraSmall,

              // collected vs weighed toggle
              ToggleButtons(
                constraints: const BoxConstraints(minHeight: 26.0, minWidth: 80.0),
                selectedColor: kcPrimaryDarkestColor,
                fillColor: kcPrimaryLightestColor,
                borderColor: kcSecondaryLightestColor,
                selectedBorderColor: kcSecondaryDarkColor,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                onPressed: ((index) => model.onPressedToggleAnalyticsType(index)),
                isSelected: model.selectedAnalyticsType.toList(),
                children: const [Text('Collected'), Text('Weighed')],
              ),
              UI.verticalSpaceExtraSmall,

              // analytics period unit (daily, weekly, monthly and yearly)
              ToggleButtons(
                constraints: const BoxConstraints(minHeight: 24.0, minWidth: 80.0),
                selectedColor: kcPrimaryDarkestColor,
                fillColor: kcPrimaryLightestColor,
                borderColor: kcSecondaryLightestColor,
                selectedBorderColor: kcSecondaryDarkColor,
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                onPressed: (index) => model.onPressedToggleAnalyticsPeriod(index),
                isSelected: model.selectedAnalyticsPeriod.toList(model.selectedAnalyticsType),
                children: model.analyticsPeriodNames.map((value) => Text(value)).toList(),
              ),
              UI.verticalSpaceMedium,

              // wrap the waste type analytics in a single background
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: EdgeInsets.zero,
                  color: kcPrimaryLightestColor,
                  child: Column(
                    children: [
                      // analytics period selection
                      if (!model.showCalender) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: () => model.dateRangeSelector(AnalyticsNavigation.left),
                              icon: const Icon(Icons.arrow_back_ios, size: 16, color: kcSecondaryLightColor),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(foregroundColor: kcSecondaryColor),
                              onPressed: () => model.toggleCalenderView(),
                              child: model.getDateLabel(),
                            ),
                            (model.showRightArrow)
                                ? IconButton(
                                    onPressed: () => model.dateRangeSelector(AnalyticsNavigation.right),
                                    icon: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: kcSecondaryLightColor,
                                    ),
                                  )
                                : Container(width: 40.00),
                          ],
                        ),
                        if (model.selectedAnalyticsType == AnalyticsType.collected) UI.verticalSpaceMedium,
                      ],

                      // calendar for period selection
                      if (model.showCalender) ...[
                        Card(
                          color: kcBackgroundColor,
                          elevation: 8.0,
                          margin: const EdgeInsets.all(15.0),
                          child: SfDateRangePicker(
                            view: model.getDateRangePickerView(),
                            selectionMode: model.getDateRangePickerSelectionMode(),
                            initialSelectedDate: model.getInitialSelectedDate(),
                            initialSelectedRange: model.getInitialSelectedRange(),
                            showNavigationArrow: true,
                            showActionButtons: true,
                            allowViewNavigation: false,
                            controller: model.getDateRangePickerController(),
                            onSelectionChanged: (args) => model.dateRangePickerControllerSelectionChanged(args),
                            onCancel: () => model.cancelCalenderSettings(),
                            onSubmit: (value) => model.submitCalenderSettings(value),
                            headerStyle: const DateRangePickerHeaderStyle(
                              backgroundColor: kcPrimaryLightestColor,
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: kcSecondaryDarkColor),
                            ),
                            yearCellStyle: const DateRangePickerYearCellStyle(
                              textStyle: TextStyle(color: kcSecondaryDarkColor, fontSize: 12, fontWeight: FontWeight.w500),
                              todayTextStyle: TextStyle(color: kcPrimaryDarkestColor, fontSize: 12, fontWeight: FontWeight.w800),
                              cellDecoration: BoxDecoration(color: kcPrimaryLightColor),
                            ),
                            monthViewSettings: model.getMonthlyViewSettings(),
                            monthCellStyle: const DateRangePickerMonthCellStyle(
                              textStyle: TextStyle(color: kcSecondaryDarkColor, fontSize: 12, fontWeight: FontWeight.w500),
                              todayTextStyle: TextStyle(color: kcPrimaryDarkestColor, fontSize: 12, fontWeight: FontWeight.w800),
                              cellDecoration: BoxDecoration(color: kcPrimaryLightColor),
                            ),
                            maxDate: DateTime.now(),
                            initialDisplayDate: model.getInitialDisplayDate(),
                            selectionColor: kcPrimaryDarkColor,
                            startRangeSelectionColor: kcPrimaryDarkColor,
                            endRangeSelectionColor: kcPrimaryDarkColor,
                            rangeSelectionColor: kcPrimaryDarkColor,
                            selectionTextStyle: const TextStyle(color: kcPrimaryUltraLightColor, fontSize: 12, fontWeight: FontWeight.w600),
                            rangeTextStyle: const TextStyle(color: kcPrimaryUltraLightColor, fontSize: 12, fontWeight: FontWeight.w600),
                            showTodayButton: true,
                          ),
                        ),
                        UI.verticalSpaceExtraSmall,
                      ],

                      //weighed tab selected
                      if (model.selectedAnalyticsType == AnalyticsType.weighed) ...[
                        ExpandableTheme(
                          data: const ExpandableThemeData(
                            iconColor: kcSecondaryLighterColor,
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                            bodyAlignment: ExpandablePanelBodyAlignment.center,
                            iconSize: 18,
                          ),
                          child: ExpandablePanel(
                            header: LimeText.analyticsFilter('Filter by Waste type'),
                            collapsed: Container(),
                            // analytics waste types
                            expanded: ToggleButtons(
                              constraints: const BoxConstraints(minHeight: 20.0, minWidth: 80.0),
                              focusColor: Colors.black12,
                              splashColor: kcPrimaryDarkColor,
                              borderColor: kcSecondaryLightestColor,
                              fillColor: kcPrimaryLightColor,
                              selectedBorderColor: kcSecondaryUltraDarkColor,
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              onPressed: (index) => model.onPressedToggleWasteTypes(index),
                              isSelected: model.selectedAnalyticsWasteTypes,
                              children: [
                                LimeText.analyticsFilterType('Spoilage'),
                                LimeText.analyticsFilterType('Prep'),
                                LimeText.analyticsFilterType('Plate'),
                                LimeText.analyticsFilterType('General'),
                              ],
                            ),
                          ),
                        ),
                        UI.verticalSpaceMedium,
                      ],

                      // waste analytics chart
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 2.5,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.center,
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(bottom: BorderSide(color: kcSecondaryLighterColor)),
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(),
                                    rightTitles: AxisTitles(),
                                    topTitles: AxisTitles(),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 16,
                                        getTitlesWidget: (double value, TitleMeta meta) {
                                          return SideTitleWidget(
                                            axisSide: meta.axisSide,
                                            child: LimeText.analyticsChartTitle(model.timeAxis[value.toInt()]),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  barTouchData: BarTouchData(
                                    // enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.transparent,
                                      tooltipPadding: EdgeInsets.zero,
                                      tooltipMargin: 0,
                                      getTooltipItem: (group, groupIndex, rod, rodIndex) => model.getToolTip(group, groupIndex, rod, rodIndex),
                                    ),
                                    touchCallback: (event, response) => model.getBarTouchToolTipData(event, response),
                                  ),
                                  // borderData: FlBorderData(show: false),
                                  groupsSpace: model.getGroupsSpace(),
                                  maxY: model.maxValueForYAxis,
                                  gridData: FlGridData(show: false),
                                  barGroups: model.foodWasteValue.entries
                                      .map(
                                        (period) => BarChartGroupData(
                                          x: period.key,
                                          groupVertically: true,
                                          barRods: [
                                            // spoilage food waste
                                            BarChartRodData(
                                              fromY: 0,
                                              toY: period.value[0],
                                              color: kcSpoilageWasteColor,
                                              width: model.getBarChartRodWidth(),
                                              borderRadius: model.getBorderRadius(WasteType.spoilage, period),
                                            ),
                                            // preparation food waste
                                            BarChartRodData(
                                              fromY: period.value[0],
                                              toY: period.value[0] + period.value[1],
                                              color: kcPreparationWasteColor,
                                              width: model.getBarChartRodWidth(),
                                              borderRadius: model.getBorderRadius(WasteType.preparation, period),
                                            ),
                                            // plate food waste
                                            BarChartRodData(
                                              fromY: period.value[0] + period.value[1],
                                              toY: period.value[0] + period.value[1] + period.value[2],
                                              color: kcPlateWasteColor,
                                              width: model.getBarChartRodWidth(),
                                              borderRadius: model.getBorderRadius(WasteType.plate, period),
                                            ),
                                            // general food waste
                                            BarChartRodData(
                                              fromY: period.value[0] + period.value[1] + period.value[2],
                                              toY: period.value[0] + period.value[1] + period.value[2] + period.value[3],
                                              color: kcGeneralWasteColor,
                                              width: model.getBarChartRodWidth(),
                                              borderRadius: model.getBorderRadius(WasteType.general, period),
                                            ),
                                            // all food waste
                                            BarChartRodData(
                                              fromY: period.value[0] + period.value[1] + period.value[2] + period.value[3],
                                              toY: period.value[0] + period.value[1] + period.value[2] + period.value[3] + period.value[4],
                                              color: kcAllWasteTypesColor,
                                              width: model.getBarChartRodWidth(),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(4),
                                                topRight: Radius.circular(4),
                                                bottomLeft: Radius.circular(0),
                                                bottomRight: Radius.circular(0),
                                              ),
                                            ),
                                          ],
                                          showingTooltipIndicators: model.getTooltipIndicators(period.key),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (model.selectedAnalyticsType == AnalyticsType.weighed) ...[
                                  const LimeChartLabel(iconColor: kcSpoilageWasteColor, label: 'Spoilage'),
                                  UI.horizontalSpaceExtraSmall,
                                  const LimeChartLabel(iconColor: kcPreparationWasteColor, label: 'Preparation'),
                                  UI.horizontalSpaceExtraSmall,
                                  const LimeChartLabel(iconColor: kcPlateWasteColor, label: 'Plate'),
                                  UI.horizontalSpaceExtraSmall,
                                  const LimeChartLabel(iconColor: kcGeneralWasteColor, label: 'General'),
                                ] else
                                  const LimeChartLabel(iconColor: kcAllWasteTypesColor, label: 'All Waste'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              UI.verticalSpaceSmall,

              // show a message if there are no weights recorded for a selected period
              if (model.wasteData.isEmpty && model.selectedAnalyticsType == AnalyticsType.weighed) ...[
                LimeText.analyticsWarning(
                  'No weights recorded for this period. If you want to see a breakdown of your waste '
                  'types and how they can be reduced, you must weigh your caddies when you empty '
                  'them. To find out more about waste reduction, give the Limetrack team a call.',
                  align: TextAlign.center,
                ),
              ],

              // weighed tab selected
              if (model.wasteData.isNotEmpty && model.selectedAnalyticsType == AnalyticsType.weighed) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    color: kcPrimaryLightestColor,
                    height: 245,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: PieChart(
                              PieChartData(
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: 25,
                                sections: List.generate(
                                  4,
                                  (i) {
                                    switch (i) {
                                      case 0:
                                        return PieChartSectionData(
                                          color: kcSpoilageWasteColor,
                                          radius: 70,
                                          title: model.spoilageWasteOverView,
                                          titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: kcSpoilageWasteLabelColor),
                                        );

                                      case 1:
                                        return PieChartSectionData(
                                          color: kcPreparationWasteColor,
                                          radius: 70,
                                          title: model.prepWasteOverView,
                                          titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: kcPreparationWasteLabelColor),
                                        );

                                      case 2:
                                        return PieChartSectionData(
                                          color: kcPlateWasteColor,
                                          radius: 70,
                                          title: model.plateWasteOverView,
                                          titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: kcPlateWasteLabelColor),
                                        );

                                      case 3:
                                        return PieChartSectionData(
                                          color: kcGeneralWasteColor,
                                          radius: 70,
                                          title: model.generalWasteOverView,
                                          titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: kcGeneralWasteLabelColor),
                                        );

                                      default:
                                        throw Error();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: OutlinedButton(
                            onPressed: model.onPressedToggleAnalyticsUnits,
                            child: LimeText.smallBold(model.showSummaryAsKgs ? 'kg' : '%'),
                          ),
                        ),
                        Positioned(top: 5, child: LimeText.headingSix(model.getPeriodSummaryText())),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
