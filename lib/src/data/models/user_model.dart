import 'package:hive/hive.dart';

import '../../domain/entities/user_entity.dart';

/// Hive-stored user record. Includes the password hash so we can
/// verify credentials locally without a backend.
@HiveType(typeId: 2)
class UserHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? fullName;

  @HiveField(3)
  final String? countryCode;

  @HiveField(4)
  final String? currency;

  @HiveField(5)
  final String? phoneNumber;

  @HiveField(6)
  final String? businessName;

  @HiveField(7)
  final String? address;

  @HiveField(8)
  final String passwordHash;

  @HiveField(9)
  final DateTime createdAt;

  @HiveField(10)
  final DateTime updatedAt;

  @HiveField(11)
  final bool isActive;

  @HiveField(12)
  final String role;

  @HiveField(13)
  final DateTime? lastLogin;

  @HiveField(14)
  final String? profilePicture;

  @HiveField(15)
  final String subscriptionType;

  @HiveField(16)
  final DateTime? subscriptionStartDate;

  @HiveField(17)
  final DateTime? subscriptionEndDate;

  @HiveField(18)
  final int featureLimit;

  @HiveField(19)
  final bool isSubscriptionActive;

  UserHiveModel({
    required this.id,
    required this.email,
    required this.passwordHash,
    this.fullName,
    this.countryCode,
    this.currency,
    this.phoneNumber,
    this.businessName,
    this.address,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isActive = true,
    this.role = 'user',
    this.lastLogin,
    this.profilePicture,
    this.subscriptionType = 'Free',
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.featureLimit = 0,
    this.isSubscriptionActive = false,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // ── Mapping ─────────────────────────────────────────────────────────────

  /// Build a [UserHiveModel] from a domain entity.
  factory UserHiveModel.fromEntity(UserEntity entity, {String? passwordHash}) {
    return UserHiveModel(
      id: entity.id ?? '',
      email: entity.email ?? '',
      passwordHash: passwordHash ?? '',
      fullName: entity.fullName,
      countryCode: entity.countryCode,
      currency: entity.currency,
      phoneNumber: entity.phoneNumber,
      businessName: entity.businessName,
      address: entity.address,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isActive: entity.isActive,
      role: entity.role,
      lastLogin: entity.lastLogin,
      profilePicture: entity.profilePicture,
      subscriptionType: entity.subscriptionType,
      subscriptionStartDate: entity.subscriptionStartDate,
      subscriptionEndDate: entity.subscriptionEndDate,
      featureLimit: entity.featureLimit,
      isSubscriptionActive: entity.isSubscriptionActive,
    );
  }

  /// Convert to a domain entity (drops the password hash).
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      fullName: fullName,
      countryCode: countryCode,
      currency: currency,
      phoneNumber: phoneNumber,
      businessName: businessName,
      address: address,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
      role: role,
      lastLogin: lastLogin,
      profilePicture: profilePicture,
      subscriptionType: subscriptionType,
      subscriptionStartDate: subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate,
      featureLimit: featureLimit,
      isSubscriptionActive: isSubscriptionActive,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TypeAdapter (manual, mirrors hive_generator's binary format)
// ─────────────────────────────────────────────────────────────────────────────
class UserHiveModelAdapter extends TypeAdapter<UserHiveModel> {
  @override
  final int typeId = 2;

  @override
  UserHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserHiveModel(
      id: fields[0] as String,
      email: fields[1] as String,
      fullName: fields[2] as String?,
      countryCode: fields[3] as String?,
      currency: fields[4] as String?,
      phoneNumber: fields[5] as String?,
      businessName: fields[6] as String?,
      address: fields[7] as String?,
      passwordHash: fields[8] as String,
      createdAt: fields[9] as DateTime,
      updatedAt: fields[10] as DateTime,
      isActive: fields[11] as bool,
      role: fields[12] as String,
      lastLogin: fields[13] as DateTime?,
      profilePicture: fields[14] as String?,
      subscriptionType: fields[15] as String,
      subscriptionStartDate: fields[16] as DateTime?,
      subscriptionEndDate: fields[17] as DateTime?,
      featureLimit: fields[18] as int,
      isSubscriptionActive: fields[19] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserHiveModel obj) {
    writer.writeByte(20);
    writer.writeByte(0);
    writer.write(obj.id);
    writer.writeByte(1);
    writer.write(obj.email);
    writer.writeByte(2);
    writer.write(obj.fullName);
    writer.writeByte(3);
    writer.write(obj.countryCode);
    writer.writeByte(4);
    writer.write(obj.currency);
    writer.writeByte(5);
    writer.write(obj.phoneNumber);
    writer.writeByte(6);
    writer.write(obj.businessName);
    writer.writeByte(7);
    writer.write(obj.address);
    writer.writeByte(8);
    writer.write(obj.passwordHash);
    writer.writeByte(9);
    writer.write(obj.createdAt);
    writer.writeByte(10);
    writer.write(obj.updatedAt);
    writer.writeByte(11);
    writer.write(obj.isActive);
    writer.writeByte(12);
    writer.write(obj.role);
    writer.writeByte(13);
    writer.write(obj.lastLogin);
    writer.writeByte(14);
    writer.write(obj.profilePicture);
    writer.writeByte(15);
    writer.write(obj.subscriptionType);
    writer.writeByte(16);
    writer.write(obj.subscriptionStartDate);
    writer.writeByte(17);
    writer.write(obj.subscriptionEndDate);
    writer.writeByte(18);
    writer.write(obj.featureLimit);
    writer.writeByte(19);
    writer.write(obj.isSubscriptionActive);
  }
}
