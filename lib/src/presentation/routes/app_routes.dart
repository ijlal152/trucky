class AppRoutes {
  AppRoutes._();

  // Route names — used with goNamed / pushNamed
  static const RouteSpec splash = RouteSpec._(name: 'splash', path: '/splash');
  static const RouteSpec signIn = RouteSpec._(name: 'signIn', path: '/sign-in');
  static const RouteSpec signUp = RouteSpec._(name: 'signUp', path: '/sign-up');
  static const RouteSpec signUpStepTwo = RouteSpec._(
    name: 'signUpStepTwo',
    path: 'step-two',
  );
  static const RouteSpec home = RouteSpec._(name: 'home', path: '/home');

  /// Location loaded when the app starts.
  static const RouteSpec initialLocation = splash;
}

/// Lightweight value object bundling a route's `name` and `path` together.
class RouteSpec {
  final String name;
  final String path;

  const RouteSpec._({required this.name, required this.path});

  @override
  String toString() => 'RouteSpec(name: $name, path: $path)';
}
