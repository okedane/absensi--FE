enum NavigationRoute {
  login('/login'),
  home('/home');

  const NavigationRoute(this.path);
  final String path;
}

extension NavigationRouteExt on NavigationRoute {
  String get route => path;
}
