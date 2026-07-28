import 'package:injectable/injectable.dart';

import 'auth_datasource.dart';
import '../../../domain/repositories/auth_rep.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  
}