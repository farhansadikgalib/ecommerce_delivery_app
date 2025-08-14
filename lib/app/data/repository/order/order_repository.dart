import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/order/order_data_response.dart';

class OrderRepository {
  Future<DelieveryOrderResponse> getOrderData() async {
    var response = await ApiClient().get(
      ApiEndPoints.orderData,
      getOrderData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return delieveryOrderResponseFromJson(response.toString());
  }
}
