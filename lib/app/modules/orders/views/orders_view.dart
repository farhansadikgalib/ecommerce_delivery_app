import 'package:delivery_app/app/core/style/app_colors.dart';
import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/helper/dialog_helper.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Your Pending Orders'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: Obx(() {
          final orders = controller.orderList;
          final isLoading = controller.isLoading.value;

          if (isLoading && orders.isEmpty) {
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

          if (orders.isEmpty && !isLoading) {
            return RefreshIndicator(
              onRefresh: controller.getOrderList,
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
                                color: AppColors.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.shopping_bag_outlined,
                                size: 64,
                                color: AppColors.primaryColor.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'No orders yet!',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'New orders will appear here when available',
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
            enabled: isLoading && orders.isNotEmpty,
            child: RefreshIndicator(
              onRefresh: controller.getOrderList,
              child: ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                itemCount:
                    orders.length + (controller.hasMoreData.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < orders.length) {
                    final order = orders[index];
                    return Skeletonizer(
                      enabled: isLoading && orders.isNotEmpty,
                      child: _buildOrderCard(context, order),
                    );
                  } else {
                    // Loading indicator for pagination
                    return Obx(() {
                      if (controller.isLoadingMore.value) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                      } else if (controller.hasMoreData.value) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: controller.loadMoreOrders,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                'Load More',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              'All orders loaded',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
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
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const Spacer(),
                Container(
                  height: 20,
                  width: 60,
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
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 14,
              width: 150,
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
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
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
  }

  Widget _buildOrderCard(BuildContext context, order) {
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
            // Header with Order ID and Status
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
                    'Order #${order.id}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                _buildStatusBadge(order.deliveryStatus),
              ],
            ),

            const SizedBox(height: 16),

            // Customer Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.person_outline,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.billingAddress?.fullName ??
                                  "Unknown Customer",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            InkWell(
                              onTap: () async {
                                final mobile = order.billingAddress?.mobile;
                                final uri = Uri.parse('tel:$mobile');
                                if (await canLaunchUrl(uri)) {
                                  await launchUrl(uri);
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_outlined,
                                    size: 16,
                                    color: AppColors.primaryColor,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    order.billingAddress?.mobile ?? "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // Address
                  InkWell(
                    onTap: () {
                      controller.openGoogleMap(
                        order.billingAddress?.address +
                            order.billingAddress?.country.name,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '${order.billingAddress?.address ?? ''}, ${order.billingAddress?.area.name ?? ''}, ${order.billingAddress?.city.name ?? ''}, ${order.billingAddress?.country.name ?? ''}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.open_in_new,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Products Section
            if (order.saleProducts?.isNotEmpty == true) ...[
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Order Items',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...?order.saleProducts?.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.inventory_2_outlined,
                          size: 24,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName.toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Qty: ${item.quantity}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '৳${item.price}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],

            // Total and Actions
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
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '৳${order.total}',
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      if (order.deliveryStatus == '2')
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showUndeliveryDialog(context, order);
                            },
                            icon: const Icon(Icons.cancel_outlined, size: 18),
                            label: const Text('Undelivered'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[600],
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 2,
                            ),
                          ),
                        ),

                      if (order.deliveryStatus == '2')
                        const SizedBox(width: 12),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (order.deliveryStatus == '0' ||
                                order.deliveryStatus == null) {
                              controller.setStatus(
                                order.id.toString(),
                                '1',
                                '',
                                '',
                              );
                            }
                            if (order.deliveryStatus == '1') {
                              controller.setStatus(
                                order.id.toString(),
                                '2',
                                '',
                                '',
                              );
                            }
                            if (order.deliveryStatus == '2') {
                              DialogHelper().customDialogBox(
                                context,
                                "Are you sure you want to deliver?",
                                leftButtonOnTap: () {
                                  Get.back();
                                },
                                rightButtonOnTap: () {
                                  controller.setStatus(
                                    order.id.toString(),
                                    '3',
                                    '',
                                    order.total.toString(),
                                  );
                                  Get.back();
                                },
                              );
                            }
                          },
                          icon: _getStatusIcon(order.deliveryStatus),
                          label: Text(_getStatusText(order.deliveryStatus)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String? status) {
    Color backgroundColor;
    Color textColor;
    String text;
    IconData icon;

    switch (status) {
      case '0':
      case null:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue[700]!;
        text = 'Ready';
        icon = Icons.inventory_2_outlined;
        break;
      case '1':
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange[700]!;
        text = 'Picked';
        icon = Icons.local_shipping_outlined;
        break;
      case '2':
        backgroundColor = Colors.purple.withOpacity(0.1);
        textColor = Colors.purple[700]!;
        text = 'On Route';
        icon = Icons.navigation_outlined;
        break;
      case '3':
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green[700]!;
        text = 'Delivered';
        icon = Icons.check_circle_outline;
        break;
      case '4':
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red[700]!;
        text = 'Undelivered';
        icon = Icons.cancel_outlined;
        break;
      default:
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey[700]!;
        text = 'Unknown';
        icon = Icons.help_outline;
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

  Icon _getStatusIcon(String? status) {
    switch (status) {
      case '0':
      case null:
        return const Icon(Icons.inventory_2_outlined, size: 18);
      case '1':
        return const Icon(Icons.local_shipping_outlined, size: 18);
      case '2':
        return const Icon(Icons.done_all, size: 18);
      default:
        return const Icon(Icons.arrow_forward, size: 18);
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case '0':
      case null:
        return 'Get Products';
      case '1':
        return 'Pick Up';
      case '2':
        return 'Deliver';
      default:
        return 'Next';
    }
  }

  void _showUndeliveryDialog(BuildContext context, order) {
    controller.resetDialogState();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Obx(() {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange[700],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Mark as Undelivered',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please select a reason for not delivering this order:',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[50],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedReason.value,
                      decoration: const InputDecoration(
                        hintText: 'Select a reason',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      isExpanded: true,
                      items: controller.undeliveryReasons.map((reason) {
                        return DropdownMenuItem(
                          value: reason,
                          child: Text(
                            reason,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedReason.value = value;
                        if (value != 'Other') {
                          controller.customReasonController.clear();
                        }
                      },
                    ),
                  ),
                  if (controller.selectedReason.value == 'Other') ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: controller.customReasonController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Please specify the reason',
                        hintText: 'Enter your custom reason here...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: AppColors.primaryColor),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.resetDialogState();
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: controller.selectedReason.value == null
                    ? null
                    : () {
                        String reason =
                            controller.selectedReason.value == 'Other'
                            ? controller.customReasonController.text.trim()
                            : controller.selectedReason.value!;

                        if (controller.selectedReason.value == 'Other' &&
                            reason.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Please specify a reason',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        controller.setStatus(
                          order.id.toString(),
                          '4',
                          reason,
                          '',
                        );
                        controller.resetDialogState();
                        Navigator.of(context).pop();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Mark Undelivered',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
