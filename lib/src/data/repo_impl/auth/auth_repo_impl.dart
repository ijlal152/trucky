import 'package:injectable/injectable.dart';

import '../../../domain/repositories/auth_rep.dart';
import '../../datasource/auth_datasource/auth_datasource.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDataSource _authDataSource;

  AuthRepoImpl(this._authDataSource);
}