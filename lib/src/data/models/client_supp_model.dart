import '../../../core/constants/enums.dart';
import '../../domain/entities/client_supp_entity.dart';

/// Data-layer model for [ClientSuppEntity].
/// Adds JSON serialization for API/database use.
class ClientSuppModel extends ClientSuppEntity {
  const ClientSuppModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    super.gpsLocation,
    super.balance,
    super.entityType,
    required super.createdAt,
  });

  factory ClientSuppModel.fromJson(Map<String, dynamic> json) {
    return ClientSuppModel(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gpsLocation: json['gpsLocation'] as String?,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      entityType: json['entityType'] == 'supplier'
          ? EntityType.supplier
          : EntityType.client,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'gpsLocation': gpsLocation,
    'balance': balance,
    'entityType': entityType.name,
    'createdAt': createdAt.toIso8601String(),
  };

  /// Convert from domain entity (e.g. when coming from a use case).
  factory ClientSuppModel.fromEntity(ClientSuppEntity entity) {
    return ClientSuppModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      gpsLocation: entity.gpsLocation,
      balance: entity.balance,
      entityType: entity.entityType,
      createdAt: entity.createdAt,
    );
  }
}
