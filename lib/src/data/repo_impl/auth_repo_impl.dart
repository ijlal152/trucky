import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_rep.dart';
import '../datasource/auth_datasource/auth_datasource.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _dataSource;
  static const String _sessionKey = 'auth_user_session';

  AuthRepoImpl(this._dataSource);

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final user = await _dataSource.getUserByEmail(email);
    if (user == null) {
      throw const UserNotFoundException();
    }
    if (user.passwordHash != password) {
      throw const InvalidCredentialsException();
    }
    await _dataSource.updateLastLogin(email);
    return user.toEntity();
  }

  @override
  Future<String> signUp({
    required UserEntity user,
    required String password,
  }) async {
    final exists = await _dataSource.checkUserExists(user.email ?? '');
    if (exists) {
      throw const UserAlreadyExistsException();
    }
    final model = UserHiveModel.fromEntity(
      user.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now()),
      passwordHash: password,
    );
    final created = await _dataSource.createUser(model);
    return created.id;
  }

  @override
  Future<UserEntity?> getUserByEmail({required String email}) {
    return _dataSource.getUserByEmail(email).then((model) => model?.toEntity());
  }

  @override
  Future<bool> checkUserExists({required String email}) {
    return _dataSource.checkUserExists(email);
  }

  @override
  Future<void> updateLastLogin({required String email}) {
    return _dataSource.updateLastLogin(email);
  }

  @override
  Future<UserEntity> updateUser({required UserEntity user}) async {
    // Preserve the existing password hash if the caller didn't supply one.
    final existing = await _dataSource.getUserByEmail(user.email ?? '');
    final model = UserHiveModel.fromEntity(
      user.copyWith(updatedAt: DateTime.now()),
      passwordHash: existing?.passwordHash ?? '',
    );
    final updated = await _dataSource.updateUser(model);
    return updated.toEntity();
  }

  @override
  Future<void> saveUserSession({UserEntity? user}) async {
    final prefs = await SharedPreferences.getInstance();
    if (user == null) {
      await prefs.remove(_sessionKey);
      return;
    }
    await prefs.setString(_sessionKey, jsonEncode(_toJson(user)));
  }

  @override
  Future<UserEntity?> loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_sessionKey);
    if (raw == null) return null;
    try {
      return _fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await prefs.remove(_sessionKey);
      return null;
    }
  }

  @override
  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }

  Map<String, dynamic> _toJson(UserEntity u) => {
    'id': u.id,
    'email': u.email,
    'fullName': u.fullName,
    'countryCode': u.countryCode,
    'currency': u.currency,
    'phoneNumber': u.phoneNumber,
    'businessName': u.businessName,
    'address': u.address,
    'createdAt': u.createdAt?.toIso8601String(),
    'updatedAt': u.updatedAt?.toIso8601String(),
    'isActive': u.isActive,
    'role': u.role,
    'lastLogin': u.lastLogin?.toIso8601String(),
    'profilePicture': u.profilePicture,
    'subscriptionType': u.subscriptionType,
    'subscriptionStartDate': u.subscriptionStartDate?.toIso8601String(),
    'subscriptionEndDate': u.subscriptionEndDate?.toIso8601String(),
    'featureLimit': u.featureLimit,
    'isSubscriptionActive': u.isSubscriptionActive,
  };

  UserEntity _fromJson(Map<String, dynamic> j) => UserEntity(
    id: j['id'] as String?,
    email: j['email'] as String?,
    fullName: j['fullName'] as String?,
    countryCode: j['countryCode'] as String?,
    currency: j['currency'] as String?,
    phoneNumber: j['phoneNumber'] as String?,
    businessName: j['businessName'] as String?,
    address: j['address'] as String?,
    createdAt: j['createdAt'] == null
        ? null
        : DateTime.tryParse(j['createdAt'] as String),
    updatedAt: j['updatedAt'] == null
        ? null
        : DateTime.tryParse(j['updatedAt'] as String),
    isActive: j['isActive'] as bool? ?? true,
    role: j['role'] as String? ?? 'user',
    lastLogin: j['lastLogin'] == null
        ? null
        : DateTime.tryParse(j['lastLogin'] as String),
    profilePicture: j['profilePicture'] as String?,
    subscriptionType: j['subscriptionType'] as String? ?? 'Free',
    subscriptionStartDate: j['subscriptionStartDate'] == null
        ? null
        : DateTime.tryParse(j['subscriptionStartDate'] as String),
    subscriptionEndDate: j['subscriptionEndDate'] == null
        ? null
        : DateTime.tryParse(j['subscriptionEndDate'] as String),
    featureLimit: (j['featureLimit'] as num?)?.toInt() ?? 0,
    isSubscriptionActive: j['isSubscriptionActive'] as bool? ?? false,
  );
}

class UserNotFoundException implements Exception {
  final String message;
  const UserNotFoundException([
    this.message = 'No account found for this email',
  ]);
  @override
  String toString() => message;
}

class InvalidCredentialsException implements Exception {
  final String message;
  const InvalidCredentialsException([this.message = 'Incorrect password']);
  @override
  String toString() => message;
}

class UserAlreadyExistsException implements Exception {
  final String message;
  const UserAlreadyExistsException([
    this.message = 'An account with this email already exists',
  ]);
  @override
  String toString() => message;
}
