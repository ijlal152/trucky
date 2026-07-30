import 'package:equatable/equatable.dart';

import '../../../core/constants/enums.dart';

/// Pure business entity for a contact (Client or Supplier).
/// Framework-agnostic — only business logic.
class ClientSuppEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? gpsLocation;
  final double balance;
  final EntityType entityType;
  final DateTime createdAt;

  const ClientSuppEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.gpsLocation,
    this.balance = 0.0,
    this.entityType = EntityType.client,
    required this.createdAt,
  });

  ClientSuppEntity copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? gpsLocation,
    double? balance,
    EntityType? entityType,
    DateTime? createdAt,
  }) {
    return ClientSuppEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gpsLocation: gpsLocation ?? this.gpsLocation,
      balance: balance ?? this.balance,
      entityType: entityType ?? this.entityType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    phoneNumber,
    gpsLocation,
    balance,
    entityType,
    createdAt,
  ];
}
