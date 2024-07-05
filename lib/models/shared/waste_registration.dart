// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WasteRegistration {
  String number;
  String registrationType;
  String? applicantType;
  String? registrationDate;
  String? expiryDate;

  WasteRegistration({
    required this.number,
    required this.registrationType,
    this.applicantType,
    this.registrationDate,
    this.expiryDate,
  });

  WasteRegistration copyWith({
    String? number,
    String? registrationType,
    String? applicantType,
    String? registrationDate,
    String? expiryDate,
  }) {
    return WasteRegistration(
      number: number ?? this.number,
      registrationType: registrationType ?? this.registrationType,
      applicantType: applicantType ?? this.applicantType,
      registrationDate: registrationDate ?? this.registrationDate,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }

  factory WasteRegistration.fromMap(Map<String, dynamic> map) {
    return WasteRegistration(
      number: map['number'] as String,
      registrationType: map['registrationType'],
      applicantType: map['applicantType'] != null ? map['applicantType'] as String : null,
      registrationDate: map['registrationDate'] != null ? map['registrationDate'] as String : null,
      expiryDate: map['expiryDate'] != null ? map['expiryDate'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'registrationType': registrationType,
      'applicantType': applicantType,
      'registrationDate': registrationDate,
      'expiryDate': expiryDate,
    };
  }

  factory WasteRegistration.fromJson(String source) => WasteRegistration.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'WasteRegistration(number: $number, registrationType: $registrationType, applicantType: $applicantType, '
        'registrationDate: $registrationDate, expiryDate: $expiryDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WasteRegistration &&
        other.number == number &&
        other.registrationType == registrationType &&
        other.applicantType == applicantType &&
        other.registrationDate == registrationDate &&
        other.expiryDate == expiryDate;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        registrationType.hashCode ^
        applicantType.hashCode ^
        applicantType.hashCode ^
        registrationDate.hashCode ^
        expiryDate.hashCode;
  }
}
