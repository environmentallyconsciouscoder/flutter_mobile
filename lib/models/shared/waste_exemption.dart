// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WasteExemption {
  String number;
  String exemptionType;
  String? registrationDate;
  String? expiryDate;

  WasteExemption({
    required this.number,
    required this.exemptionType,
    this.registrationDate,
    this.expiryDate,
  });

  WasteExemption copyWith({
    String? number,
    String? exemptionType,
    String? registrationDate,
    String? expiryDate,
  }) {
    return WasteExemption(
      number: number ?? this.number,
      exemptionType: exemptionType ?? this.exemptionType,
      registrationDate: registrationDate ?? this.registrationDate,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  factory WasteExemption.fromMap(Map<String, dynamic> map) {
    return WasteExemption(
      number: map['number'] as String,
      exemptionType: map['registrationType'],
      registrationDate: map['registrationDate'] != null ? map['registrationDate'] as String : null,
      expiryDate: map['expiryDate'] != null ? map['expiryDate'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'registrationType': exemptionType,
      'registrationDate': registrationDate,
      'expiryDate': expiryDate,
    };
  }

  factory WasteExemption.fromJson(String source) => WasteExemption.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'WasteExemption(number: $number, exemptionType: $exemptionType, registrationDate: $registrationDate, '
        'expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WasteExemption &&
        other.number == number &&
        other.exemptionType == exemptionType &&
        other.registrationDate == registrationDate &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return number.hashCode ^ exemptionType.hashCode ^ registrationDate.hashCode ^ expiryDate.hashCode;
  }
}
