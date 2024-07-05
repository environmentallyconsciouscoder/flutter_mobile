import 'analytics_type.dart';

enum AnalyticsPeriod {
  daily,
  weekly,
  monthly,
  yearly;

  List<bool> toList(AnalyticsType analyticsType) {
    switch (analyticsType) {
      case AnalyticsType.collected:
        switch (this) {
          case AnalyticsPeriod.daily:
            return <bool>[false, false, false];
          case AnalyticsPeriod.weekly:
            return <bool>[true, false, false];
          case AnalyticsPeriod.monthly:
            return <bool>[false, true, false];
          case AnalyticsPeriod.yearly:
            return <bool>[false, false, true];
        }

      case AnalyticsType.weighed:
        switch (this) {
          case AnalyticsPeriod.daily:
            return <bool>[true, false, false, false];
          case AnalyticsPeriod.weekly:
            return <bool>[false, true, false, false];
          case AnalyticsPeriod.monthly:
            return <bool>[false, false, true, false];
          case AnalyticsPeriod.yearly:
            return <bool>[false, false, false, true];
        }
    }
  }
}
