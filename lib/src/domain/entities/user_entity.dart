import 'package:equatable/equatable.dart';

/// Pure business entity representing a User.
/// Framework-agnostic — only business logic.
class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? fullName;
  final String? countryCode;
  final String? currency;
  final String? phoneNumber;
  final String? businessName;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final String role;
  final DateTime? lastLogin;
  final String? profilePicture;
  final String subscriptionType;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final int featureLimit;
  final bool isSubscriptionActive;

  const UserEntity({
    this.id,
    this.email,
    this.fullName,
    this.countryCode,
    this.currency,
    this.phoneNumber,
    this.businessName,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.role = 'user',
    this.lastLogin,
    this.profilePicture,
    this.subscriptionType = 'Free',
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.featureLimit = 0,
    this.isSubscriptionActive = false,
  });

  bool get hasActiveSubscription => isSubscriptionActive;

  bool get isSubscriptionExpired {
    if (subscriptionEndDate == null) return true;
    return DateTime.now().isAfter(subscriptionEndDate!);
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? countryCode,
    String? currency,
    String? phoneNumber,
    String? businessName,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? role,
    DateTime? lastLogin,
    String? profilePicture,
    String? subscriptionType,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
    int? featureLimit,
    bool? isSubscriptionActive,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      countryCode: countryCode ?? this.countryCode,
      currency: currency ?? this.currency,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      businessName: businessName ?? this.businessName,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      role: role ?? this.role,
      lastLogin: lastLogin ?? this.lastLogin,
      profilePicture: profilePicture ?? this.profilePicture,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      subscriptionStartDate:
          subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      featureLimit: featureLimit ?? this.featureLimit,
      isSubscriptionActive: isSubscriptionActive ?? this.isSubscriptionActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    countryCode,
    currency,
    phoneNumber,
    businessName,
    address,
    isActive,
    role,
    subscriptionType,
    featureLimit,
    isSubscriptionActive,
  ];
}
