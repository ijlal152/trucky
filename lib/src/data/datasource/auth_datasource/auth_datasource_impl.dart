import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_model.dart';
import 'auth_datasource.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  static const String _boxName = 'users';

  late Box<UserHiveModel> _box;
  final Uuid _uuid;

  AuthDataSourceImpl() : _uuid = const Uuid() {
    _box = Hive.box<UserHiveModel>(_boxName);
  }

  @override
  Future<UserHiveModel> createUser(UserHiveModel user) async {
    // Generate a fresh id if the caller did not supply one.
    final key = user.id.isEmpty ? _uuid.v4() : user.id;
    final toStore = user.id.isEmpty
        ? UserHiveModel(
            id: key,
            email: user.email,
            passwordHash: user.passwordHash,
            fullName: user.fullName,
            countryCode: user.countryCode,
            currency: user.currency,
            phoneNumber: user.phoneNumber,
            businessName: user.businessName,
            address: user.address,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt,
            isActive: user.isActive,
            role: user.role,
            lastLogin: user.lastLogin,
            profilePicture: user.profilePicture,
            subscriptionType: user.subscriptionType,
            subscriptionStartDate: user.subscriptionStartDate,
            subscriptionEndDate: user.subscriptionEndDate,
            featureLimit: user.featureLimit,
            isSubscriptionActive: user.isSubscriptionActive,
          )
        : user;

    await _box.put(key, toStore);
    return toStore;
  }

  @override
  Future<UserHiveModel> getUser(String userID) async {
    final user = _box.get(userID);
    if (user == null) {
      throw Exception('User not found');
    }
    return user;
  }

  @override
  Future<UserHiveModel> updateUser(UserHiveModel user) async {
    if (!_box.containsKey(user.id)) {
      throw Exception('User not found for update');
    }
    await _box.put(user.id, user);
    return user;
  }

  @override
  Future<int> deleteUser(String userId) async {
    if (_box.containsKey(userId)) {
      await _box.delete(userId);
      return 1;
    }
    return 0;
  }

  @override
  Future<UserHiveModel?> getUserByEmail(String email) async {
    for (final key in _box.keys) {
      final hive = _box.get(key);
      if (hive != null && hive.email == email) {
        return hive;
      }
    }
    return null;
  }

  @override
  Future<List<UserHiveModel>> getAllUsers() async {
    return _box.values.toList();
  }

  @override
  Future<bool> checkUserExists(String email) async {
    return _box.values.any((u) => u.email == email);
  }

  @override
  Future<void> updateLastLogin(String email) async {
    for (final key in _box.keys) {
      final hive = _box.get(key);
      if (hive != null && hive.email == email) {
        // Re-create with updated lastLogin (Hive models are immutable fields).
        final updated = UserHiveModel(
          id: hive.id,
          email: hive.email,
          passwordHash: hive.passwordHash,
          fullName: hive.fullName,
          countryCode: hive.countryCode,
          currency: hive.currency,
          phoneNumber: hive.phoneNumber,
          businessName: hive.businessName,
          address: hive.address,
          createdAt: hive.createdAt,
          updatedAt: hive.updatedAt,
          isActive: hive.isActive,
          role: hive.role,
          lastLogin: DateTime.now(),
          profilePicture: hive.profilePicture,
          subscriptionType: hive.subscriptionType,
          subscriptionStartDate: hive.subscriptionStartDate,
          subscriptionEndDate: hive.subscriptionEndDate,
          featureLimit: hive.featureLimit,
          isSubscriptionActive: hive.isSubscriptionActive,
        );
        await _box.put(key, updated);
        return;
      }
    }
  }
}
