import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/features/product_detail/data/models/product_detail_model.dart';

abstract class ProductDetailRemoteDataSource {
  Future<ProductDetailModel> getProductDetail(int productId);
}

class ProductDetailRemoteDataSourceImpl implements ProductDetailRemoteDataSource {
  final DioClient _dioClient;

  ProductDetailRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProductDetailModel> getProductDetail(int productId) async {
    final response = await _dioClient.request(
      'products/$productId', // Construct the endpoint with the product ID
      method: MethodType.GET,
    );
    // The JSON response for a single product is not wrapped in a "data" key,
    // so DioClient will pass the whole response.data to fromJson.
    return ProductDetailModel.fromJson(response.data);
  }
}
