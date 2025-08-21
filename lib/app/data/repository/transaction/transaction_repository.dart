import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';

import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/order/order_status_response.dart';

class TransactionRepository {
  Future<TransactionResponse> getTransactionData(int page) async {
    var response = await ApiClient().get(
      ApiEndPoints.transactionData(page: page.toString()),
      getTransactionData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return transactionResponseFromJson(response.toString());
  }

  Future<OrderStatusResponse> transferAmount(
    String orderId,
    String amount,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.transferToCompany(orderId: orderId),
      {
        'transfer_to_company': amount,
      },
      transferAmount,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return orderStatusResponseFromJson(response.toString());
  }
}
