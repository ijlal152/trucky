import '../entities/user_entity.dart';

/// Domain contract for authentication operations.
abstract class AuthRepo {
  Future<UserEntity> signIn({required String email, required String password});

  Future<String> signUp({required UserEntity user, required String password});

  Future<UserEntity?> getUserByEmail({required String email});

  Future<bool> checkUserExists({required String email});

  Future<void> updateLastLogin({required String email});

  Future<UserEntity> updateUser({required UserEntity user});

  /// Persist the active user session (stored in SharedPreferences).
  Future<void> saveUserSession({UserEntity? user});

  /// Load the currently persisted session, if any.
  Future<UserEntity?> loadUserSession();

  /// Clear the persisted session (used for logout).
  Future<void> clearUserSession();
}
