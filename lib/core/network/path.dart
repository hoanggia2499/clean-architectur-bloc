import 'package:base_project/core/navigation/path.dart';

class PathURL {
  static const String auth = "/auth/${PathRoute.login}";
  static const String products = PathRoute.products;
  static const String search = "$products/${PathRoute.search}";
  static const String productDetail = "$products/${PathRoute.productDetail}";
}
