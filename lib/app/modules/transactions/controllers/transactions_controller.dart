import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';
import 'package:delivery_app/app/data/repository/transaction/transaction_repository.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final transactionList = <TransactionData>[].obs;
  final isLoading = false.obs;
  int page = 1;

  @override
  void onInit() {
    super.onInit();
    getTransactionList();
  }

  Future<void> getTransactionList() async {
    try {
      isLoading.value = true;
      transactionList.clear();
      var response = await TransactionRepository().getTransactionData(page);
      transactionList.addAll(response.data ?? []);
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error loading transactions: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> transferAmount(String orderId, String amount) async {
    try {
      var response = await TransactionRepository().transferAmount(orderId, amount);
      if (response.status == "success") {
        AppWidgets().getSnackBar(message: response.message ?? 'Amount transferred successfully');
        getTransactionList();
      }else {
        AppWidgets().getSnackBar(message: response.message ?? 'Failed to transfer amount');
      }
    } catch (e) {
      AppWidgets().getSnackBar(message: 'Error transferring amount: ${e.toString()}');
    }
  }
}
