enum NavigationRoute {
  homeRoute("/home"),
  inventoryRoute("/inventory"),
  imagePreviewRoute("/image-preview"),
  inputDataRoute("/input-data");

  const NavigationRoute(this.name);
  final String name;
}
