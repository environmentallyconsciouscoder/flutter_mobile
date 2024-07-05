// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  String name;
  int amount;
  String unit;
  String? destination;

  Product({
    required this.name,
    required this.amount,
    required this.unit,
    this.destination,
  });

  Product copyWith({
    String? name,
    int? amount,
    String? unit,
    String? destination,
  }) {
    return Product(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      destination: destination ?? this.destination,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      amount: map['amount'] as int,
      unit: map['unit'] as String,
      destination: map['destination'] != null ? map['destination'] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amount,
      'unit': unit,
      'destination': destination,
    };
  }

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Product(number: $name, amount: $amount, unit: $unit, destination: $destination)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.name == name && other.amount == amount && other.unit == unit && other.destination == destination;
  }

  @override
  int get hashCode {
    return name.hashCode ^ amount.hashCode ^ unit.hashCode ^ destination.hashCode;
  }
}
