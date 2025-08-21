import 'package:delivery_app/app/data/model/order/order_status_response.dart';

import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/order/order_data_response.dart';

class OrderRepository {
  Future<DeliveryOrderResponse> getPendingOrderData(int page) async {
    var response = await ApiClient().get(
      ApiEndPoints.pendingOrderData(page: page.toString()),
      getPendingOrderData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return deliveryOrderResponseFromJson(response.toString());
  }
  Future<DeliveryOrderResponse> getAllOrderData(int page) async {
    var response = await ApiClient().get(
      ApiEndPoints.allOrderData(page: page.toString()),
      getAllOrderData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return deliveryOrderResponseFromJson(response.toString());
  }

  Future<OrderStatusResponse> setOrderStatus(
    String orderId,
    String deliveryStatus,
    String reason,
    String amount,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.orderStatus(orderId: orderId),
      {
        'delivery_status': deliveryStatus,
        'paid_amount': amount,
        if (deliveryStatus == '4') 'delivery_reject_reason': reason,
      },
      setOrderStatus,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return orderStatusResponseFromJson(response.toString());
  }
}
