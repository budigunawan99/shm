enum NavigationRoute {
  homeRoute("/home"),
  inventoryRoute("/inventory"),
  inputDataRoute("/input-data");

  const NavigationRoute(this.name);
  final String name;
}
