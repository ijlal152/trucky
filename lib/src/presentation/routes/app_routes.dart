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
  static const RouteSpec products = RouteSpec._(name: 'products', path: '/products');
  static const RouteSpec sales = RouteSpec._(name: 'sales', path: '/sales');
  static const RouteSpec purchases = RouteSpec._(name: 'purchases', path: '/purchases');
  static const RouteSpec suppliers = RouteSpec._(name: 'suppliers', path: '/suppliers');
  static const RouteSpec clients = RouteSpec._(name: 'clients', path: '/clients');
  static const RouteSpec treasury = RouteSpec._(name: 'treasury', path: '/treasury');
  static const RouteSpec analysis = RouteSpec._(name: 'analysis', path: '/analysis');

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
