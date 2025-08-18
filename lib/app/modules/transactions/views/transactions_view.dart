import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Transaction History'),
      body: Obx(() {
        final transactions = controller.transactionList;
        if (transactions.isEmpty) {
          return const Center(
            child: Text(
              'No transactions yet!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction #${transaction.transactionId ?? transaction.id}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(transaction.status),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            transaction.status?.toUpperCase() ?? 'UNKNOWN',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (transaction.customer != null) ...[
                      InkWell(
                        onTap: () async {
                          final mobile = transaction.customer?.mobile;
                          if (mobile != null) {
                            final uri = Uri.parse('tel:$mobile');
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            }
                          }
                        },
                        child: Text(
                          '${transaction.customer?.fullName ?? ""} • ${transaction.customer?.mobile ?? ""}',
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (transaction.order != null)
                      Text(
                        'Order: ${transaction.order?.saleCode ?? ""}',
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      'Date: ${_formatDate(transaction.transactionDate)}',
                      style: const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    if (transaction.description?.isNotEmpty == true) ...[
                      const SizedBox(height: 4),
                      Text(
                        transaction.description!,
                        style: const TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '৳${transaction.amount}',
                              style: TextStyle(
                                color: transaction.type == 'credit' ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${transaction.type?.toUpperCase() ?? ''} • ${transaction.paymentMethod ?? 'N/A'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (transaction.status == 'pending')
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {

                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(70, 32),
                                ),
                                child: const Text(
                                  'Approve',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {

                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(70, 32),
                                ),
                                child: const Text(
                                  'Reject',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      backgroundColor: Colors.grey[50],
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
