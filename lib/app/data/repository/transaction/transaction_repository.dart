import '../../../network_service/api_client.dart';
import '../../../network_service/api_end_points.dart';
import '../../model/transaction/transaction_data_response.dart';

class TransactionRepository {
  Future<TransactionResponse> getTransactionData() async {
    var response = await ApiClient().get(
      ApiEndPoints.transactionData,
      getTransactionData,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return transactionResponseFromJson(response.toString());
  }

}
