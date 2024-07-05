// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Contact {
  String name;
  String? email;
  String? phone;
  String? mobile;

  Contact({
    required this.name,
    this.email,
    this.phone,
    this.mobile,
  });

  Contact copyWith({
    String? name,
    String? email,
    String? phone,
    String? mobile,
  }) {
    return Contact(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      mobile: mobile ?? this.mobile,
    );
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      mobile: map['mobile'] != null ? map['mobile'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'mobile': mobile,
    };
  }

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Contact(name: $name, email: $email, phone: $phone, mobile: $mobile)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact && other.name == name && other.email == email && other.phone == phone && other.mobile == mobile;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ phone.hashCode ^ mobile.hashCode;
  }
}
