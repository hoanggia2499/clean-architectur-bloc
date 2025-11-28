import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/features/calendar/data/models/product_list_model.dart';

abstract class CalendarRemoteDataSource {
  Future<ProductListModel> getProducts({required int limit, required int skip});
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  final DioClient _dioClient;

  CalendarRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProductListModel> getProducts({required int limit, required int skip}) async {
    final response = await _dioClient.request(
      'products',
      method: MethodType.GET,
      data: {
        'limit': limit,
        'skip': skip,
        // 'select': 'title,price,thumbnail,category,description',
      },
    );
    return ProductListModel.fromJson(response.data);
  }
}
