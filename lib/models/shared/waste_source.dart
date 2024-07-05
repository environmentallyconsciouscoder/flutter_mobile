// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:limetrack/enums/waste_source_type.dart';

class WasteSource {
  WasteSourceType wasteSourceType;
  int total;

  WasteSource({
    required this.wasteSourceType,
    required this.total,
  });

  WasteSource copyWith({
    WasteSourceType? wasteSourceType,
    int? total,
  }) {
    return WasteSource(
      wasteSourceType: wasteSourceType ?? this.wasteSourceType,
      total: total ?? this.total,
    );
  }

  factory WasteSource.fromMap(Map<String, dynamic> map) {
    return WasteSource(
      wasteSourceType: WasteSourceType.values.byName(map['wasteSourceType']),
      total: map['total'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wasteSourceType': wasteSourceType.name,
      'total': total,
    };
  }

  factory WasteSource.fromJson(String source) => WasteSource.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'WasteSource(wasteSourceType: $wasteSourceType, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WasteSource && other.wasteSourceType == wasteSourceType && other.total == total;
  }

  @override
  int get hashCode {
    return wasteSourceType.hashCode ^ total.hashCode;
  }
}
