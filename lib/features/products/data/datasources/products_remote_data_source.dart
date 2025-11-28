import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/core/network/path.dart';

import '../models/product_list_model.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductListModel> getProducts({required int limit, required int skip});
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final DioClient _dioClient;

  ProductsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProductListModel> getProducts({required int limit, required int skip}) async {
    final response = await _dioClient.request(
      PathURL.products,
      method: MethodType.GET,
      data: {
        'limit': limit,
        'skip': skip,
        // 'select': 'title,description,category,category,price,discountPercentage,rating,stock',
      },
    );
    return ProductListModel.fromJson(response.data);
  }
}
