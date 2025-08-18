import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';
import 'package:delivery_app/app/data/repository/transaction/transaction_repository.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final transactionList = <TransactionData>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransactionList();
  }

  Future<void> getTransactionList() async {
    transactionList.clear();
    var response = await TransactionRepository().getTransactionData();
    transactionList.addAll(response.data ?? []);
  }


}
