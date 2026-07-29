import '../../models/user_model.dart';

abstract class AuthDataSource {
  Future<UserHiveModel> createUser(UserHiveModel user);
  Future<UserHiveModel> updateUser(UserHiveModel user);
  Future<UserHiveModel> getUser(String userID);
  Future<int> deleteUser(String userId);
  Future<UserHiveModel?> getUserByEmail(String email);
  Future<List<UserHiveModel>> getAllUsers();
  Future<bool> checkUserExists(String email);
  Future<void> updateLastLogin(String email);
}
