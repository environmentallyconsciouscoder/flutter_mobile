import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:limetrack/app/app.locator.dart';
import 'package:limetrack/app/app.logger.dart';
import 'package:limetrack/enums/analytics_navigation.dart';
import 'package:limetrack/enums/analytics_period.dart';
import 'package:limetrack/enums/analytics_type.dart';
import 'package:limetrack/enums/waste_type.dart';
import 'package:limetrack/models/caddy.dart';
import 'package:limetrack/models/transfer.dart';
import 'package:limetrack/services/collection_service.dart';
import 'package:limetrack/services/database_service.dart';
import 'package:limetrack/services/environment_service.dart';
import 'package:limetrack/ui/common/app_colors.dart';

class ReportsViewModel extends BaseViewModel {
  final log = getLogger('ReportsViewModel');
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final environmentService = locator<EnvironmentService>();
  final databaseService = locator<DatabaseService>();
  final collectionService = locator<CollectionService>();

  // default to show the Weighed analytics type
  AnalyticsType _selectedAnalyticsType = AnalyticsType.weighed;
  AnalyticsType get selectedAnalyticsType => _selectedAnalyticsType;

  // default to Weekly analytics period
  AnalyticsPeriod _selectedAnalyticsPeriod = AnalyticsPeriod.weekly;
  AnalyticsPeriod get selectedAnalyticsPeriod => _selectedAnalyticsPeriod;

  // default to show all waste types (Spoilage, Preparation, Plate and General)
  final List<bool> _selectedAnalyticsWasteTypes = <bool>[true, true, true, true];
  List<bool> get selectedAnalyticsWasteTypes => _selectedAnalyticsWasteTypes;

  final DateRangePickerController _dateRangePickerController = DateRangePickerController();

  double maxValueForYAxis = 0.0;

  String spoilageWasteOverView = '0';
  String prepWasteOverView = '0';
  String plateWasteOverView = '0';
  String generalWasteOverView = '0';
  String _selectedDay = '';
  String _selectedWeek = '';
  String _selectedMonth = '';
  String _selectedYear = '';

  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  int _touchedGroupIndex = -1;

  final DateTime _currentDate = DateTime.now().toUtc();

  DateTime _selectedDate = DateTime.now().toUtc();
  DateTime get selectedDate => _selectedDate;

  List wasteData = [];

  bool _showSummaryAsKgs = true;
  bool get showSummaryAsKgs => _showSummaryAsKgs;

  List<String> _timeAxis = <String>[];
  List<String> get timeAxis => _timeAxis;

  List<String> _analyticsPeriodNames = ['daily', 'weekly', 'monthly', 'yearly'];
  List<String> get analyticsPeriodNames => _analyticsPeriodNames;

  Map<int, List<double>> _foodWasteValue = {};
  Map<int, List<double>> get foodWasteValue => _foodWasteValue;

  Map<int, List<double>> _wasteTypeOverviewValue = {};
  Map<int, List<double>> get wasteTypeOverviewValue => _wasteTypeOverviewValue;

  bool _showRightArrow = true;
  bool get showRightArrow {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        _showRightArrow = _selectedDate.isBefore(_currentDate.subtract(const Duration(days: 1)));
        break;

      case AnalyticsPeriod.weekly:
        _showRightArrow = _selectedDate.isBefore(_currentDate.subtract(const Duration(days: 7)));
        break;

      case AnalyticsPeriod.monthly:
        _showRightArrow = _selectedDate.isBefore(DateTime(_currentDate.year, _currentDate.month, _currentDate.day));
        break;

      case AnalyticsPeriod.yearly:
        _showRightArrow = _selectedDate.isBefore(DateTime(_currentDate.year, _currentDate.month, _currentDate.day));
        break;
    }

    return _showRightArrow;
  }

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  bool _showCalender = false;
  bool get showCalender => _showCalender;

  bool _showToolTip = true;

  Future<void> runStartupLogic() async {
    updateAllWasteReports(_selectedAnalyticsPeriod, _selectedDate);
    notifyListeners();
  }

  void navigateBack() {
    navigationService.back();
  }

  Future<WasteType?> getWasteTypeFromId(String id) async {
    log.v('Get caddy type');

    try {
      Caddy caddy = await collectionService.getCaddy(id);
      return caddy.wasteType;
    } catch (error) {
      log.e(error);
      return null;
    }
  }

  Future<void> getWasteData(AnalyticsPeriod analyticsPeriod) async {
    switch (analyticsPeriod) {
      case AnalyticsPeriod.daily:
        await getDailyWasteData();
        break;

      case AnalyticsPeriod.weekly:
        await getWeeklyWasteData();
        break;

      case AnalyticsPeriod.monthly:
        await getMonthlyWasteData();
        break;

      case AnalyticsPeriod.yearly:
        await getYearlyWasteData();
        break;
    }
  }

  Future<void> getCollectedOrWeighedWasteData(DateTime startDate, DateTime endDate) async {
    switch (_selectedAnalyticsType) {
      case AnalyticsType.collected:
        wasteData = [];

        List<Transfer> collections = await collectionService.listTransfers(
          queries: [
            Query.greaterThanEqual('timestamp', startDate.millisecondsSinceEpoch),
            Query.lessThan('timestamp', endDate.millisecondsSinceEpoch),
            Query.equal("fromType", "bin"),
            Query.equal("toType", "carrier"),
            Query.orderDesc('timestamp'),
            //Query.limit(1)
          ],
        );

        if (collections.isNotEmpty) {
          for (Transfer collection in collections) {
            List<Transfer> deposits = await collectionService.listTransfers(
              queries: [
                Query.equal("fromType", "caddy"),
                Query.equal("toType", "bin"),
                //Query.equal("nextTransferId", collections.first.$id),
                Query.equal("nextTransferId", collection.$id),
              ],
            );

            if (deposits.isNotEmpty) {
              // we want to set the deposit dates to the same as the collection date
              for (Transfer deposit in deposits) {
                deposit.timestamp = collection.timestamp;
                deposit.dateTimeUtc = collection.dateTimeUtc;
              }

              // add the deposits to the list of waste data
              wasteData.addAll(deposits);
            }
          }
        }
        break;

      case AnalyticsType.weighed:
        List weighedWaste = await collectionService.listTransfers(
          queries: [
            Query.greaterThanEqual('timestamp', startDate.millisecondsSinceEpoch),
            Query.lessThan('timestamp', endDate.millisecondsSinceEpoch),
            Query.orderDesc('timestamp'),
            Query.equal("toType", "bin"),
          ],
        );

        wasteData = weighedWaste;
        break;
    }
  }

  Future<void> getDailyWasteData() async {
    var dailyFoodWaste = <int, List<double>>{
      // [ spoilage, prep, plate, general, all waste]
      0: [0, 0, 0, 0, 0],
    };

    var timeAxis = [""];
    DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
    DateTime endDate = startDate.add(const Duration(days: 1));

    //TODO: remove this when we're happy with the date calculations
    log.wtf('selectedDate: $_selectedDate');
    log.wtf('startDate: $startDate');
    log.wtf('endDate: $endDate');

    try {
      log.v('Get weight for daily waste report');

      await getCollectedOrWeighedWasteData(startDate, endDate);

      if (wasteData.isNotEmpty) {
        List latestWeightRecords = [];

        for (var recording in wasteData) {
          latestWeightRecords.add(recording.weight);
        }

        String weightInKg = (latestWeightRecords.cast<num>().reduce((a, b) => a + b) / 1000).toStringAsFixed(2);

        String caddyId = wasteData[0].fromId;
        WasteType? wasteType = await getWasteTypeFromId(caddyId);

        switch (_selectedAnalyticsType) {
          case AnalyticsType.collected:
            dailyFoodWaste[0]![4] = double.parse(weightInKg);
            break;

          case AnalyticsType.weighed:
            switch (wasteType) {
              case WasteType.general:
                dailyFoodWaste[0]![3] = double.parse(weightInKg);
                break;

              case WasteType.plate:
                dailyFoodWaste[0]![2] = double.parse(weightInKg);
                break;

              case WasteType.preparation:
                dailyFoodWaste[0]![1] = double.parse(weightInKg);
                break;

              case WasteType.spoilage:
                dailyFoodWaste[0]![0] = double.parse(weightInKg);
                break;

              default:
            }
            break;
        }

        selectedAnalyticsWasteTypes.asMap().forEach((index, wasteType) => {
              if (wasteType == false)
                {
                  if (index == 3)
                    {dailyFoodWaste[0]![3] = 0}
                  else if (index == 2)
                    {dailyFoodWaste[0]![2] = 0}
                  else if (index == 1)
                    {dailyFoodWaste[0]![1] = 0}
                  else if (index == 0)
                    {dailyFoodWaste[0]![0] = 0}
                }
            });

        timeAxis = [DateFormat('yyyy-MM-dd').format(wasteData[0].timestamp)];
      }
    } catch (error) {
      log.e(error);
    }

    _foodWasteValue = dailyFoodWaste;
    _timeAxis = timeAxis;
    _showToolTip = true;
  }

  Future<void> getWeeklyWasteData() async {
    var timeAxis = ['MON', 'TUES', 'WED', 'THUR', 'FRI', 'SAT', 'SUN'];

    Map<int, List<double>> weeklyFoodWasteValue = {
      // [ spoilage, prep, plate, general, all waste]
      0: [0, 0, 0, 0, 0],
      1: [0, 0, 0, 0, 0],
      2: [0, 0, 0, 0, 0],
      3: [0, 0, 0, 0, 0],
      4: [0, 0, 0, 0, 0],
      5: [0, 0, 0, 0, 0],
      6: [0, 0, 0, 0, 0],
    };

    try {
      log.v('Get weight for weekly waste report');

      DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day - (_selectedDate.weekday - 1));
      DateTime endDate = startDate.add(const Duration(days: 7));

      await getCollectedOrWeighedWasteData(startDate, endDate);

      if (wasteData.isNotEmpty) {
        for (var entry in weeklyFoodWasteValue.entries) {
          for (var records in wasteData) {
            if (records.timestamp.weekday - 1 == entry.key) {
              String caddyId = records.fromId;
              WasteType? wasteType = await getWasteTypeFromId(caddyId);

              switch (_selectedAnalyticsType) {
                case AnalyticsType.collected:
                  entry.value[4] = entry.value[4] + (records.weight / 1000);
                  break;

                case AnalyticsType.weighed:
                  switch (wasteType) {
                    case WasteType.general:
                      entry.value[3] = entry.value[3] + (records.weight / 1000);
                      break;

                    case WasteType.plate:
                      entry.value[2] = entry.value[2] + (records.weight / 1000);
                      break;

                    case WasteType.preparation:
                      entry.value[1] = entry.value[1] + (records.weight / 1000);
                      break;

                    case WasteType.spoilage:
                      entry.value[0] = entry.value[0] + (records.weight / 1000);
                      break;

                    default:
                  }
                  break;
              }
            }
          }
        }
      }

      for (var entry in weeklyFoodWasteValue.entries) {
        selectedAnalyticsWasteTypes.asMap().forEach((index, wasteType) => {
              if (wasteType == false)
                {
                  if (index == 3)
                    entry.value[3] = 0
                  else if (index == 2)
                    {entry.value[2] = 0}
                  else if (index == 1)
                    {entry.value[1] = 0}
                  else if (index == 0)
                    {entry.value[0] = 0}
                }
            });
      }
    } catch (error) {
      log.e(error);
    }

    _timeAxis = timeAxis;
    _foodWasteValue = weeklyFoodWasteValue;
    _showToolTip = true;
  }

  Future<void> getMonthlyWasteData() async {
    // [2 is jan - 13 is dec]
    int numberOfDaysInTheMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;

    Map<int, List<double>> monthlyFoodWasteValue = {};
    List<String> timeAxis = [""];

    for (int i = 1; i <= numberOfDaysInTheMonth; i++) {
      //[ spoilage, prep, plate, general, all waste]
      monthlyFoodWasteValue.addAll({
        i: [0, 0, 0, 0, 0]
      });

      if (i.isEven) {
        timeAxis.add(i.toString());
      } else {
        timeAxis.add("");
      }
    }

    try {
      log.v('Get weight for monthly waste report');

      DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, 1);
      DateTime endDate = DateTime(startDate.year, startDate.month + 1, startDate.day);

      //TODO: remove this when we're happy with the date calculations
      log.wtf('selectedDate: $_selectedDate');
      log.wtf('startDate: $startDate');
      log.wtf('endDate: $endDate');

      await getCollectedOrWeighedWasteData(startDate, endDate);

      if (wasteData.isNotEmpty) {
        for (var records in wasteData) {
          int dayIndex = records.timestamp.day;
          String caddyId = records.fromId;
          WasteType? wasteType = await getWasteTypeFromId(caddyId);

          switch (_selectedAnalyticsType) {
            case AnalyticsType.collected:
              monthlyFoodWasteValue[dayIndex]![4] = monthlyFoodWasteValue[dayIndex]![4] + (records.weight / 1000);
              break;

            case AnalyticsType.weighed:
              switch (wasteType) {
                case WasteType.general:
                  monthlyFoodWasteValue[dayIndex]![3] = monthlyFoodWasteValue[dayIndex]![3] + (records.weight / 1000);
                  break;

                case WasteType.plate:
                  monthlyFoodWasteValue[dayIndex]![2] = monthlyFoodWasteValue[dayIndex]![2] + (records.weight / 1000);
                  break;

                case WasteType.preparation:
                  monthlyFoodWasteValue[dayIndex]![1] = monthlyFoodWasteValue[dayIndex]![1] + (records.weight / 1000);
                  break;

                case WasteType.spoilage:
                  monthlyFoodWasteValue[dayIndex]![0] = monthlyFoodWasteValue[dayIndex]![0] + (records.weight / 1000);
                  break;

                default:
              }
              break;
          }
        }
      }

      selectedAnalyticsWasteTypes.asMap().forEach((index, wasteType) => {
            if (wasteType == false)
              {
                for (var entry in monthlyFoodWasteValue.entries)
                  {
                    if (index == 3)
                      entry.value[3] = 0
                    else if (index == 2)
                      {entry.value[2] = 0}
                    else if (index == 1)
                      {entry.value[1] = 0}
                    else if (index == 0)
                      {entry.value[0] = 0}
                  }
              }
          });
    } catch (error) {
      log.e(error);
    }

    _foodWasteValue = monthlyFoodWasteValue;
    _timeAxis = timeAxis;
    _showToolTip = true;
  }

  Future<void> getYearlyWasteData() async {
    var timeAxis = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JULY', 'AUG', 'SEPT', 'OCT', 'NOV', 'DEC'];

    Map<int, List<double>> yearlyFoodWasteValue = {
      //   // [ spoilage, prep, plate, general, all waste]
      0: [0, 0, 0, 0, 0],
      1: [0, 0, 0, 0, 0],
      2: [0, 0, 0, 0, 0],
      3: [0, 0, 0, 0, 0],
      4: [0, 0, 0, 0, 0],
      5: [0, 0, 0, 0, 0],
      6: [0, 0, 0, 0, 0],
      7: [0, 0, 0, 0, 0],
      8: [0, 0, 0, 0, 0],
      9: [0, 0, 0, 0, 0],
      10: [0, 0, 0, 0, 0],
      11: [0, 0, 0, 0, 0],
    };

    try {
      log.v('Get weight for monthly waste report');

      DateTime startDate = DateTime(_selectedDate.year, 1, 1);
      DateTime endDate = DateTime(_selectedDate.year + 1, 1, 1);

      //TODO: remove this when we're happy with the date calculations
      log.wtf('selectedDate: $_selectedDate');
      log.wtf('New startDate: $startDate');
      log.wtf('New endDate: $endDate');

      await getCollectedOrWeighedWasteData(startDate, endDate);

      if (wasteData.isNotEmpty) {
        for (var entry in yearlyFoodWasteValue.entries) {
          for (var records in wasteData) {
            if (records.timestamp.month - 1 == entry.key) {
              String caddyId = records.fromId;
              WasteType? wasteType = await getWasteTypeFromId(caddyId);

              switch (_selectedAnalyticsType) {
                case AnalyticsType.collected:
                  entry.value[4] = entry.value[4] + (records.weight / 1000);
                  break;

                case AnalyticsType.weighed:
                  switch (wasteType) {
                    case WasteType.general:
                      entry.value[3] = entry.value[3] + (records.weight / 1000);
                      break;

                    case WasteType.plate:
                      entry.value[2] = entry.value[2] + (records.weight / 1000);
                      break;

                    case WasteType.preparation:
                      entry.value[1] = entry.value[1] + (records.weight / 1000);
                      break;

                    case WasteType.spoilage:
                      entry.value[0] = entry.value[0] + (records.weight / 1000);
                      break;

                    default:
                  }
                  break;
              }
            }
          }
        }
      }

      selectedAnalyticsWasteTypes.asMap().forEach((index, wasteType) => {
            if (wasteType == false)
              {
                for (var entry in yearlyFoodWasteValue.entries)
                  {
                    if (index == 3)
                      entry.value[3] = 0
                    else if (index == 2)
                      {entry.value[2] = 0}
                    else if (index == 1)
                      {entry.value[1] = 0}
                    else if (index == 0)
                      {entry.value[0] = 0}
                  }
              }
          });
    } catch (error) {
      log.e(error);
    }

    _foodWasteValue = yearlyFoodWasteValue;
    _timeAxis = timeAxis;
    _showToolTip = true;
  }

  void setHeightLimitForWasteChart() {
    List maxValues = [];
    for (var entry in foodWasteValue.entries) {
      maxValues.add(entry.value[0] + entry.value[1] + entry.value[2] + entry.value[3] + entry.value[4]);
    }

    maxValueForYAxis = maxValues.cast<double>().reduce(max) + 1;
  }

  void getWasteTypeOverviewData() {
    double totalSpoilageWaste = 0.0;
    double totalPrepWaste = 0.0;
    double totalPlateWaste = 0.0;
    double totalGeneralWaste = 0.0;

    num allSpoilageWaste = 0;
    num allPrepWaste = 0;
    num allPlateWaste = 0;
    num allGeneralWaste = 0;

    List spoilageWaste = [];
    List prepWaste = [];
    List plateWaste = [];
    List generalWaste = [];

    for (var entry in wasteTypeOverviewValue.entries) {
      spoilageWaste.add(entry.value[0]);
      prepWaste.add(entry.value[1]);
      plateWaste.add(entry.value[2]);
      generalWaste.add(entry.value[3]);
    }

    totalSpoilageWaste = spoilageWaste.cast<double>().reduce((a, b) => a + b);
    totalPrepWaste = prepWaste.cast<double>().reduce((a, b) => a + b);
    totalPlateWaste = plateWaste.cast<double>().reduce((a, b) => a + b);
    totalGeneralWaste = generalWaste.cast<double>().reduce((a, b) => a + b);

    if (!_showSummaryAsKgs) {
      num totalWaste = totalSpoilageWaste + totalPrepWaste + totalPlateWaste + totalGeneralWaste;

      if (totalWaste != 0) {
        allSpoilageWaste = (totalSpoilageWaste / totalWaste * 100).round();
        allPrepWaste = (totalPrepWaste / totalWaste * 100).round();
        allPlateWaste = (totalPlateWaste / totalWaste * 100).round();
        allGeneralWaste = (totalGeneralWaste / totalWaste * 100).round();
      } else {
        allSpoilageWaste = totalSpoilageWaste.round();
        allPrepWaste = totalPrepWaste.round();
        allPlateWaste = totalPlateWaste.round();
        allGeneralWaste = totalGeneralWaste.round();
      }
    }

    spoilageWasteOverView = !_showSummaryAsKgs
        ? allSpoilageWaste.toString()
        : totalSpoilageWaste != 0
            ? totalSpoilageWaste.toStringAsFixed(1)
            : '0';
    prepWasteOverView = !_showSummaryAsKgs
        ? allPrepWaste.toString()
        : totalPrepWaste != 0
            ? totalPrepWaste.toStringAsFixed(1)
            : '0';
    plateWasteOverView = !_showSummaryAsKgs
        ? allPlateWaste.toString()
        : totalPlateWaste != 0
            ? totalPlateWaste.toStringAsFixed(1)
            : '0';
    generalWasteOverView = !_showSummaryAsKgs
        ? allGeneralWaste.toString()
        : totalGeneralWaste != 0
            ? totalGeneralWaste.toStringAsFixed(1)
            : '0';
  }

  Future<void> updateDateRangeLabelsAndData(dynamic selectedDate) async {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        getDailyDate(selectedDate);
        await getDailyWasteData();
        break;

      case AnalyticsPeriod.weekly:
        getWeeklyDate(selectedDate);
        await getWeeklyWasteData();
        break;

      case AnalyticsPeriod.monthly:
        getMonthlyDate(selectedDate);
        await getMonthlyWasteData();
        break;

      case AnalyticsPeriod.yearly:
        getYearlyDate(selectedDate);
        await getYearlyWasteData();
        break;
    }

    _wasteTypeOverviewValue = foodWasteValue;

    setHeightLimitForWasteChart();
    getWasteTypeOverviewData();
    notifyListeners();
  }

  void getDailyDate(DateTime date) {
    _selectedDay = DateFormat('dd-MM-yyyy').format(date);
  }

  void getWeeklyDate(DateTime date) {
    // 1 - 7
    var weekDay = date.weekday;

    int amountToBeDeducted;
    if (weekDay == 1) {
      amountToBeDeducted = 0;
    } else {
      amountToBeDeducted = weekDay - 1;
    }

    DateTime mondayOfTheWeek = date.subtract(Duration(days: amountToBeDeducted));
    String sundayOfTheWeek = DateFormat('dd-MM-yyyy').format(mondayOfTheWeek.add(const Duration(days: 6)));
    String mondayOfTheWeekFormatted = DateFormat('dd-MM-yyyy').format(mondayOfTheWeek);

    _selectedWeek = "$mondayOfTheWeekFormatted - $sundayOfTheWeek";
  }

  void getMonthlyDate(DateTime date) {
    final year = int.parse(DateFormat('yyyy').format(date)).toString();
    final month = int.parse(DateFormat('MM').format(date)).toString();

    _selectedMonth = "${months[int.parse(month) - 1]} $year";
  }

  void getYearlyDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy');
    final year = int.parse(formatter.format(date)).toString();

    _selectedYear = year;
  }

  double addTwoDecimalPlaces(num wasteValue) {
    return double.parse(wasteValue.toStringAsFixed(2));
  }

  double getBarTooltipItemFontSize() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        return 12.0;

      case AnalyticsPeriod.weekly:
        return 10.0;

      case AnalyticsPeriod.monthly:
        return 7.0;

      case AnalyticsPeriod.yearly:
        return 8.0;
    }
  }

  updateAllWasteReports(AnalyticsPeriod analyticsPeriod, DateTime analyticsDate) async {
    updateDateRangeLabelsAndData(analyticsDate);

    await getWasteData(analyticsPeriod);

    setHeightLimitForWasteChart();

    _wasteTypeOverviewValue = foodWasteValue;
  }

  void onPressedToggleAnalyticsType(int index) async {
    _showCalender = false;
    _selectedAnalyticsType = AnalyticsType.values[index];

    switch (_selectedAnalyticsType) {
      case AnalyticsType.collected:
        if (_selectedAnalyticsPeriod == AnalyticsPeriod.daily) {
          _selectedAnalyticsPeriod = AnalyticsPeriod.weekly;
        }

        _analyticsPeriodNames = ['weekly', 'monthly', 'yearly'];

        await getWasteData(_selectedAnalyticsPeriod);
        break;

      case AnalyticsType.weighed:
        _analyticsPeriodNames = ['daily', 'weekly', 'monthly', 'yearly'];

        await getWasteData(_selectedAnalyticsPeriod);

        _wasteTypeOverviewValue = foodWasteValue;
        getWasteTypeOverviewData();
        break;
    }

    setHeightLimitForWasteChart();
    updateDateRangeLabelsAndData(_selectedDate);

    notifyListeners();
  }

  void onPressedToggleAnalyticsPeriod(int index) async {
    _showToolTip = false;
    _showCalender = false;

    // update the analytics period to the user selection
    switch (_selectedAnalyticsType) {
      case AnalyticsType.collected:
        switch (index) {
          case 0:
            _selectedAnalyticsPeriod = AnalyticsPeriod.weekly;
            break;

          case 1:
            _selectedAnalyticsPeriod = AnalyticsPeriod.monthly;
            break;

          case 2:
            _selectedAnalyticsPeriod = AnalyticsPeriod.yearly;
            break;
        }
        break;

      case AnalyticsType.weighed:
        switch (index) {
          case 0:
            _selectedAnalyticsPeriod = AnalyticsPeriod.daily;
            break;

          case 1:
            _selectedAnalyticsPeriod = AnalyticsPeriod.weekly;
            break;

          case 2:
            _selectedAnalyticsPeriod = AnalyticsPeriod.monthly;
            break;

          case 3:
            _selectedAnalyticsPeriod = AnalyticsPeriod.yearly;
            break;
        }
        break;
    }

    for (int i = 0; i < _selectedAnalyticsWasteTypes.length; i++) {
      _selectedAnalyticsWasteTypes[i] = true;
    }

    updateAllWasteReports(_selectedAnalyticsPeriod, _selectedDate);
  }

  Future<void> dateRangeSelector(AnalyticsNavigation direction) async {
    _showCalender = false;

    switch (direction) {
      case AnalyticsNavigation.left:
        switch (_selectedAnalyticsPeriod) {
          case AnalyticsPeriod.daily:
            _selectedDate = _selectedDate.subtract(const Duration(days: 1));
            break;

          case AnalyticsPeriod.weekly:
            _selectedDate = _selectedDate.subtract(const Duration(days: 7));

            // change the calendar to reflect the new range selection
            DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day - (_selectedDate.weekday - 1));
            DateTime endDate = startDate.add(const Duration(days: 6));

            _dateRangePickerController.selectedRange = PickerDateRange(startDate, endDate);
            _dateRangePickerController.displayDate = getInitialDisplayDate();
            break;

          case AnalyticsPeriod.monthly:
            _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, _selectedDate.day);
            break;

          case AnalyticsPeriod.yearly:
            _selectedDate = DateTime(_selectedDate.year - 1, _selectedDate.month, _selectedDate.day);
            break;
        }

        // enable the right arrow
        _showRightArrow = true;
        break;

      case AnalyticsNavigation.right:
        DateTime now = DateTime.now();

        switch (_selectedAnalyticsPeriod) {
          case AnalyticsPeriod.daily:
            _selectedDate = _selectedDate.add(const Duration(days: 1));
            _showRightArrow = _selectedDate.isBefore(now.subtract(const Duration(days: 1)));
            break;

          case AnalyticsPeriod.weekly:
            _selectedDate = _selectedDate.add(const Duration(days: 7));
            _showRightArrow = _selectedDate.isBefore(now.subtract(const Duration(days: 7)));

            // change the calendar to reflect the new range selection
            DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day - (_selectedDate.weekday - 1));
            DateTime endDate = startDate.add(const Duration(days: 6));

            _dateRangePickerController.selectedRange = PickerDateRange(startDate, endDate);
            _dateRangePickerController.displayDate = getInitialDisplayDate();
            break;

          case AnalyticsPeriod.monthly:
            _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, _selectedDate.day);
            _showRightArrow = _selectedDate.isBefore(DateTime(now.year, now.month, now.day));
            break;

          case AnalyticsPeriod.yearly:
            _selectedDate = DateTime(_selectedDate.year + 1, _selectedDate.month, _selectedDate.day);
            _showRightArrow = _selectedDate.isBefore(DateTime(now.year, now.month, now.day));
            break;
        }
        break;
    }

    await updateDateRangeLabelsAndData(_selectedDate);
    notifyListeners();
  }

  void toggleCalenderView() {
    _showCalender = !showCalender;

    notifyListeners();
  }

  Widget getDateLabel() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        return Text(_selectedDay);

      case AnalyticsPeriod.weekly:
        return Text(_selectedWeek);

      case AnalyticsPeriod.monthly:
        return Text(_selectedMonth);

      case AnalyticsPeriod.yearly:
        return Text(_selectedYear);
    }
  }

  bool _isSameDate(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) {
      return false;
    }

    if (date1 == date2) {
      return true;
    }

    return date1.month == date2.month && date1.year == date2.year && date1.day == date2.day;
  }

  DateRangePickerView getDateRangePickerView() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.yearly:
        return DateRangePickerView.decade;

      case AnalyticsPeriod.monthly:
        return DateRangePickerView.year;

      default:
        return DateRangePickerView.month;
    }
  }

  DateRangePickerSelectionMode getDateRangePickerSelectionMode() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.weekly:
        return DateRangePickerSelectionMode.range;

      default:
        return DateRangePickerSelectionMode.single;
    }
  }

  DateTime? getInitialSelectedDate() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
      case AnalyticsPeriod.monthly:
      case AnalyticsPeriod.yearly:
        return _selectedDate;

      default:
        return null;
    }
  }

  PickerDateRange? getInitialSelectedRange() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.weekly:
        DateTime startDate = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day - (_selectedDate.weekday - 1));
        DateTime endDate = startDate.add(const Duration(days: 6));
        return PickerDateRange(startDate, endDate);

      default:
        return null;
    }
  }

  DateRangePickerController? getDateRangePickerController() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.weekly:
        return _dateRangePickerController;

      default:
        return null;
    }
  }

  void dateRangePickerControllerSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (_selectedAnalyticsPeriod == AnalyticsPeriod.weekly) {
      // swap the start and end dates so they're chronological
      PickerDateRange range = args.value;
      DateTime? startDate = range.startDate;
      DateTime? endDate = range.endDate ?? range.startDate;

      if (startDate != null && endDate != null && startDate.isAfter(endDate)) {
        DateTime swapDate = startDate;
        startDate = endDate;
        endDate = swapDate;
      }

      // adjust the start and end dates so that they span a full week
      if (startDate != null) {
        startDate = DateTime(startDate.year, startDate.month, startDate.day - (startDate.weekday - 1));
        endDate = startDate.add(const Duration(days: 6));

        if (!_isSameDate(startDate, range.startDate!) || !_isSameDate(endDate, range.endDate!)) {
          _dateRangePickerController.selectedRange = PickerDateRange(startDate, endDate);
        }
      }
    }
  }

  void cancelCalenderSettings() {
    _showCalender = false;
    _dateRangePickerController.displayDate = getInitialDisplayDate();

    notifyListeners();
  }

  void submitCalenderSettings(dynamic value) {
    if (value != null) {
      _showCalender = !_showCalender;

      if (value is PickerDateRange) {
        _selectedDate = value.startDate!;
      } else {
        _selectedDate = value;
      }

      updateAllWasteReports(_selectedAnalyticsPeriod, _selectedDate);
    }

    notifyListeners();
  }

  DateRangePickerMonthViewSettings getMonthlyViewSettings() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.weekly:
        return const DateRangePickerMonthViewSettings(
          numberOfWeeksInView: 4,
          firstDayOfWeek: 1,
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            backgroundColor: kcPrimaryLightestColor,
            textStyle: TextStyle(fontSize: 12, color: kcSecondaryDarkColor),
          ),
        );

      default:
        return const DateRangePickerMonthViewSettings(
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            backgroundColor: kcPrimaryLightestColor,
            textStyle: TextStyle(fontSize: 12, color: kcSecondaryDarkColor),
          ),
        );
    }
  }

  DateTime getInitialDisplayDate() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.weekly:
        return DateTime(_selectedDate.year, _selectedDate.month, 1);

      default:
        return _selectedDate;
    }
  }

  void onPressedToggleWasteTypes(int index) async {
    _selectedAnalyticsWasteTypes[index] = !_selectedAnalyticsWasteTypes[index];

    await getWasteData(_selectedAnalyticsPeriod);

    setHeightLimitForWasteChart();
    notifyListeners();
  }

  BarTooltipItem? getToolTip(BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex) {
    if (_showToolTip) {
      if (groupIndex == _touchedGroupIndex) {
        double rodHeight = rod.toY - rod.fromY;

        return BarTooltipItem(
          rodHeight > 0
              ? rodHeight.toStringAsFixed(1)
              : _selectedAnalyticsType == AnalyticsType.weighed
                  ? '0'
                  : '',
          TextStyle(color: kcSecondaryUltraDarkColor, fontWeight: FontWeight.w400, fontSize: getBarTooltipItemFontSize()),
        );
      }

      return BarTooltipItem(
        rod.toY != 0
            ? rod.toY.toStringAsFixed(1)
            : _selectedAnalyticsType == AnalyticsType.weighed
                ? '0'
                : '',
        TextStyle(color: kcSecondaryUltraDarkColor, fontWeight: FontWeight.w400, fontSize: getBarTooltipItemFontSize()),
      );
    }

    return null;
  }

  void getBarTouchToolTipData(dynamic event, dynamic response) {
    if (event.isInterestedForInteractions && response != null && response.spot != null) {
      _touchedGroupIndex = response.spot!.touchedBarGroupIndex;
    } else {
      _touchedGroupIndex = -1;
    }
  }

  double getGroupsSpace() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        return 15.0;

      case AnalyticsPeriod.weekly:
        return 10.0;

      case AnalyticsPeriod.monthly:
        return 4.0;

      case AnalyticsPeriod.yearly:
        return 10.0;
    }
  }

  double getBarChartRodWidth() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        return 50.0;

      case AnalyticsPeriod.weekly:
        return 38.0;

      case AnalyticsPeriod.monthly:
        return 7.1;

      case AnalyticsPeriod.yearly:
        return 18.0;
    }
  }

  BorderRadius getBorderRadius(WasteType wasteType, MapEntry<int, List<double>> period) {
    Radius radius0;
    Radius radius4;

    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        radius0 = const Radius.circular(0);
        radius4 = const Radius.circular(4);
        break;

      case AnalyticsPeriod.weekly:
        radius0 = const Radius.circular(0);
        radius4 = const Radius.circular(3);
        break;

      case AnalyticsPeriod.monthly:
        radius0 = const Radius.circular(0);
        radius4 = const Radius.circular(1);
        break;

      case AnalyticsPeriod.yearly:
        radius0 = const Radius.circular(0);
        radius4 = const Radius.circular(3);
        break;
    }

    switch (wasteType) {
      case WasteType.spoilage:
        return BorderRadius.only(
          topLeft: ((period.value[1] + period.value[2] + period.value[3]) > 0) ? radius0 : radius4,
          topRight: ((period.value[1] + period.value[2] + period.value[3]) > 0) ? radius0 : radius4,
        );

      case WasteType.preparation:
        return BorderRadius.only(
          topLeft: ((period.value[2] + period.value[3]) > 0) ? radius0 : radius4,
          topRight: ((period.value[2] + period.value[3]) > 0) ? radius0 : radius4,
        );

      case WasteType.plate:
        return BorderRadius.only(
          topLeft: (period.value[3] > 0) ? radius0 : radius4,
          topRight: (period.value[3] > 0) ? radius0 : radius4,
        );

      case WasteType.general:
        return BorderRadius.only(topLeft: radius4, topRight: radius4);

      default:
        return BorderRadius.only(topLeft: radius4, topRight: radius4);
    }
  }

  List<int> getTooltipIndicators(int x) {
    switch (_selectedAnalyticsType) {
      case AnalyticsType.collected:
        //switch (_selectedAnalyticsPeriod) {
        //  case AnalyticsPeriod.monthly:
        //    return _touchedGroupIndex == x ? [x] : [];

        //  default:
        return [4];
      //}

      case AnalyticsType.weighed:
        switch (_selectedAnalyticsPeriod) {
          case AnalyticsPeriod.monthly:
            return _touchedGroupIndex == x ? [x] : [];

          default:
            return [4];
        }
    }
  }

  void onPressedToggleAnalyticsUnits() {
    // toggle the analytics units
    _showSummaryAsKgs = !_showSummaryAsKgs;

    getWasteTypeOverviewData();
    notifyListeners();
  }

  String getPeriodSummaryText() {
    switch (_selectedAnalyticsPeriod) {
      case AnalyticsPeriod.daily:
        return 'Daily Summary';

      case AnalyticsPeriod.weekly:
        return 'Weekly Summary';

      case AnalyticsPeriod.monthly:
        return 'Monthly Summary';

      case AnalyticsPeriod.yearly:
        return 'Yearly Summary';

      default:
        return 'Summary';
    }
  }
}
