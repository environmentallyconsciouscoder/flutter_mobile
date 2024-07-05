enum AnalyticsType {
  collected,
  weighed;

  List<bool> toList() {
    switch (this) {
      case AnalyticsType.collected:
        return <bool>[true, false];

      case AnalyticsType.weighed:
        return <bool>[false, true];
    }
  }
}
