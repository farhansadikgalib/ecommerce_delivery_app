import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';
import 'package:delivery_app/app/data/repository/transaction/transaction_repository.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController {
  final transactionList = <TransactionData>[].obs;
  final filteredTransactionList = <TransactionData>[].obs;
  final isLoading = false.obs;
  final selectedTransferStatus = Rxn<String>(); // null means "All"
  int page = 1;

  // Transfer status mapping for display
  final transferStatusOptions = <String, String>{
    'all': 'All Transactions',
    '0': 'Pending Transfer',
    '1': 'Transferred',
  };

  @override
  void onInit() {
    super.onInit();
    getTransactionList();

    // Listen to selectedTransferStatus changes and apply filter
    ever(selectedTransferStatus, (_) => _applyFilter());
  }

  Future<void> getTransactionList() async {
    try {
      isLoading.value = true;
      transactionList.clear();
      var response = await TransactionRepository().getTransactionData(page);
      transactionList.addAll(response.data ?? []);
      _applyFilter();
    } catch (e) {
      AppWidgets().getSnackBar(
        message: 'Error loading transactions: ${e.toString()}',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> transferAmount(String orderId, String amount) async {
    try {
      var response = await TransactionRepository().transferAmount(
        orderId,
        amount,
      );
      if (response.status == "success") {
        AppWidgets().getSnackBar(
          message: response.message ?? 'Amount transferred successfully',
        );
        getTransactionList();
      } else {
        AppWidgets().getSnackBar(
          message: response.message ?? 'Failed to transfer amount',
        );
      }
    } catch (e) {
      AppWidgets().getSnackBar(
        message: 'Error transferring amount: ${e.toString()}',
      );
    }
  }

  void _applyFilter() {
    if (selectedTransferStatus.value == null ||
        selectedTransferStatus.value == 'all') {
      filteredTransactionList.assignAll(transactionList);
    } else {
      filteredTransactionList.assignAll(
        transactionList
            .where(
              (transaction) =>
                  transaction.transferToCompany == selectedTransferStatus.value,
            )
            .toList(),
      );
    }
  }

  void filterByTransferStatus(String? status) {
    selectedTransferStatus.value = status;
  }

  void clearFilter() {
    selectedTransferStatus.value = null;
  }

  String get currentFilterText {
    if (selectedTransferStatus.value == null ||
        selectedTransferStatus.value == 'all') {
      return 'All Transactions';
    }
    return transferStatusOptions[selectedTransferStatus.value] ??
        'Unknown Status';
  }

  bool get hasActiveFilter =>
      selectedTransferStatus.value != null &&
      selectedTransferStatus.value != 'all';
}
