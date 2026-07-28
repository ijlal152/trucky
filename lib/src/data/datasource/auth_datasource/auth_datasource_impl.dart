import 'package:injectable/injectable.dart';

import 'auth_datasource.dart';

@LazySingleton(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {}
