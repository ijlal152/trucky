import 'package:injectable/injectable.dart';

import '../../domain/repositories/auth_rep.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {}
