import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/core/network/path.dart';
import 'package:base_project/features/products/data/models/product_list_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductListModel> getProducts(
      {required int limit, required int skip, String? sortBy, String? order});

  Future<ProductListModel> searchProducts({required String query});
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final DioClient _dioClient;

  ProductsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProductListModel> getProducts(
      {required int limit, required int skip, String? sortBy, String? order}) async {
    final Map<String, dynamic> queryParameters = {
      'limit': limit,
      'skip': skip,
      'select': 'title,price,thumbnail,category,description',
    };

    if (sortBy != null) {
      queryParameters['sortBy'] = sortBy;
    }
    if (order != null) {
      queryParameters['order'] = order;
    }

    final response = await _dioClient.request(
      PathURL.products,
      method: MethodType.GET,
      data: queryParameters, 
    );
    return ProductListModel.fromJson(response.data);
  }

  @override
  Future<ProductListModel> searchProducts({required String query}) async {
    final response = await _dioClient.request(
      PathURL.search,
      method: MethodType.GET,
      data: {'q': query},
    );
    return ProductListModel.fromJson(response.data);
  }
}
