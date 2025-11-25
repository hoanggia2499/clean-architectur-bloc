enum AppMode { UT_TEST, IT_TEST, RELEASE }

class AppProperties {
  ///
  static late final AppProperties instance;
  //
  final String apSrvURL;
  //
  final AppMode mode;

  const AppProperties({
    required this.apSrvURL,
    this.mode = AppMode.RELEASE,
  });
}
