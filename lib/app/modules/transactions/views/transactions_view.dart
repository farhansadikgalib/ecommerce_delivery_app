import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Transaction History'),
      body: Obx(() {
        final transactions = controller.transactionList;
        final isLoading = controller.isLoading.value;

        if (isLoading && transactions.isEmpty) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildSkeletonCard();
              },
            ),
          );
        }

        if (transactions.isEmpty && !isLoading) {
          return RefreshIndicator(
            onRefresh: controller.getTransactionList,
            child: ListView(
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'No transactions yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return Skeletonizer(
          enabled: isLoading && transactions.isNotEmpty,
          child: RefreshIndicator(
            onRefresh: controller.getTransactionList,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return _buildTransactionCard(context, transaction);
              },
            ),
          ),
        );
      }),
      backgroundColor: Colors.grey[50],
    );
  }

  Widget _buildSkeletonCard() {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 20,
              width: double.infinity,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 6),
            Container(height: 14, width: 120, color: Colors.grey[300]),
            const SizedBox(height: 4),
            Container(height: 14, width: 80, color: Colors.grey[300]),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(height: 14, width: 100, color: Colors.grey[300]),
                const Spacer(),
                Container(height: 14, width: 60, color: Colors.grey[300]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(
    BuildContext context,
    TransactionData transaction,
  ) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction #${transaction.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              'SaleCode #${transaction.saleId}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: [
                Text(
                  'Total: ৳${transaction.receiveAmount ?? "0"}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    if(transaction.transferToCompany=='0'){
                      controller.transferAmount(
                        transaction.id.toString(),
                        transaction.receiveAmount ?? "0",
                      );
                    }

                  },
                  style: TextButton.styleFrom(
                    backgroundColor: transaction.transferToCompany=='0'? Colors
                        .deepOrangeAccent: Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Transfer', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),

            Text(
              'Date ${transaction.sale!.saleDate}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
