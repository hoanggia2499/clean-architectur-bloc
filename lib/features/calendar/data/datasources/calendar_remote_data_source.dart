import 'package:base_project/core/network/dio_client.dart';
import 'package:base_project/core/network/path.dart';
import 'package:base_project/features/calendar/data/models/product_list_model.dart';

abstract class CalendarRemoteDataSource {
  Future<ProductListModel> getProducts();
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  final DioClient _dioClient;

  CalendarRemoteDataSourceImpl(this._dioClient);

  @override
  Future<ProductListModel> getProducts() async {
    final response = await _dioClient.request(
      PathURL.products,
      method: MethodType.GET,
    );
    return ProductListModel.fromJson(response.data);
  }
}
