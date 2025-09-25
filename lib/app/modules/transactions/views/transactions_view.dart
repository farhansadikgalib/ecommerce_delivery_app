import 'package:delivery_app/app/core/style/app_colors.dart';
import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:delivery_app/app/data/model/transaction/transaction_data_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:intl/intl.dart';
import '../../../core/helper/dialog_helper.dart';
import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Transaction History'),
      floatingActionButton: _buildFilterFAB(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Filter indicator bar
            Obx(() {
              if (controller.hasActiveFilter) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: AppColors.primaryColor,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Filtered by: ${controller.currentFilterText}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: controller.clearFilter,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
            // Main content
            Expanded(
              child: Obx(() {
                final transactions = controller.filteredTransactionList;
                final isLoading = controller.isLoading.value;

                if (isLoading && transactions.isEmpty) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor.withOpacity(
                                        0.1,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.account_balance_wallet_outlined,
                                      size: 64,
                                      color: AppColors.primaryColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'No transactions yet!',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Your transaction history will appear here',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                return Skeletonizer(
                  enabled: isLoading && transactions.isNotEmpty,
                  child: RefreshIndicator(
                    onRefresh: controller.getTransactionList,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Skeletonizer(
                          enabled: isLoading && transactions.isNotEmpty,
                          child: _buildTransactionCard(context, transaction),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterFAB(BuildContext context) {
    return Obx(() {
      return FloatingActionButton.extended(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: controller.hasActiveFilter
            ? AppColors.primaryColor
            : Colors.grey[700],
        foregroundColor: Colors.white,
        icon: Icon(
          controller.hasActiveFilter
              ? Icons.filter_alt
              : Icons.filter_alt_outlined,
        ),
        label: Text(
          controller.hasActiveFilter ? 'Filtered' : 'Filter',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 4,
      );
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    color: AppColors.primaryColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Filter Transactions by Transfer Status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Filter options
            Flexible(
              child: Obx(
                () => ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: controller.transferStatusOptions.entries.map((
                    entry,
                  ) {
                    final statusValue = entry.key == 'all' ? null : entry.key;
                    final statusText = entry.value;
                    final isSelected =
                        controller.selectedTransferStatus.value == statusValue;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: InkWell(
                        onTap: () {
                          controller.filterByTransferStatus(statusValue);
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.1)
                                : Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryColor
                                  : Colors.grey[200]!,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              if (statusValue != null) ...[
                                _buildTransferStatusIcon(statusValue),
                                const SizedBox(width: 12),
                              ] else ...[
                                Icon(
                                  Icons.list_alt_outlined,
                                  color: isSelected
                                      ? AppColors.primaryColor
                                      : Colors.grey[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                              ],
                              Expanded(
                                child: Text(
                                  statusText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferStatusIcon(String status) {
    IconData icon;
    Color color;

    switch (status) {
      case '0':
        icon = Icons.schedule_rounded;
        color = Colors.orange[700]!;
        break;
      case '1':
        icon = Icons.check_circle_outline;
        color = Colors.green[700]!;
        break;
      default:
        icon = Icons.help_outline;
        color = Colors.grey[700]!;
    }

    return Icon(icon, color: color, size: 20);
  }

  Widget _buildSkeletonCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 20,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 20,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 16,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            Container(height: 1, color: Colors.grey[200]),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  height: 14,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 32,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Transaction ID and Status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'TXN #${transaction.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                _buildTransferStatusBadge(transaction.transferToCompany),
              ],
            ),

            const SizedBox(height: 16),

            // Sale Code Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.receipt_long_outlined,
                      color: Colors.blue[700],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sale Code',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '#${transaction.saleId}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Date and Time Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.access_time_rounded,
                      color: Colors.purple[700],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction Date',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.purple[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatDateTime(transaction.sale?.saleDate ?? ''),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Amount and Transfer Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.1),
                    Colors.green.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.green[700],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Amount Received',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '৳${transaction.receiveAmount ?? "0"}',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Transfer Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: transaction.transferToCompany == '0'
                          ? () {
                              DialogHelper().customDialogBox(
                                context,
                                "Are you sure you want to transfer?",
                                leftButtonOnTap: () {
                                  Get.back();
                                },
                                rightButtonOnTap: () {
                                  Get.back();
                                  controller.transferAmount(
                                    transaction.id.toString(),
                                    transaction.receiveAmount ?? "0",
                                  );
                                },
                              );
                            }
                          : null,
                      icon: Icon(
                        transaction.transferToCompany == '0'
                            ? Icons.send_rounded
                            : Icons.check_circle_outline,
                        size: 18,
                      ),
                      label: Text(
                        transaction.transferToCompany == '0'
                            ? 'Transfer to Company'
                            : 'Transferred',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: transaction.transferToCompany == '0'
                            ? AppColors.primaryColor
                            : Colors.grey[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: transaction.transferToCompany == '0' ? 3 : 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferStatusBadge(String? transferStatus) {
    Color backgroundColor;
    Color textColor;
    String text;
    IconData icon;

    if (transferStatus == '0') {
      backgroundColor = Colors.orange.withOpacity(0.1);
      textColor = Colors.orange[700]!;
      text = 'Pending';
      icon = Icons.schedule_rounded;
    } else {
      backgroundColor = Colors.green.withOpacity(0.1);
      textColor = Colors.green[700]!;
      text = 'Transferred';
      icon = Icons.check_circle_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: textColor),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(String dateTimeString) {
    try {
      if (dateTimeString.isEmpty) {
        return 'Date not available';
      }

      // Parse the datetime string
      DateTime dateTime;

      // Handle different datetime formats
      if (dateTimeString.contains('T')) {
        // ISO format: 2024-01-15T14:30:00Z or 2024-01-15T14:30:00
        dateTime = DateTime.parse(dateTimeString);
      } else if (dateTimeString.contains('-') && dateTimeString.length >= 10) {
        // Format: 2024-01-15 14:30:00 or 2024-01-15
        if (dateTimeString.length > 10) {
          dateTime = DateTime.parse(dateTimeString.replaceFirst(' ', 'T'));
        } else {
          dateTime = DateTime.parse(dateTimeString);
        }
      } else {
        // Fallback for other formats
        dateTime = DateTime.parse(dateTimeString);
      }

      // Format to DD-MM-YYYY with AM/PM time
      final DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
      final DateFormat timeFormatter = DateFormat('hh:mm a');

      final formattedDate = dateFormatter.format(dateTime);
      final formattedTime = timeFormatter.format(dateTime);

      return '$formattedDate at $formattedTime';
    } catch (e) {
      // Return the original string if parsing fails
      return dateTimeString.isNotEmpty ? dateTimeString : 'Date not available';
    }
  }
}
