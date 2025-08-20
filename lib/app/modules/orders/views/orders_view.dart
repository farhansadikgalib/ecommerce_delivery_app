import 'package:delivery_app/app/core/helper/app_widgets.dart';
import 'package:delivery_app/app/core/style/app_colors.dart';
import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Your Orders'),
      body: Obx(() {
        final orders = controller.orderList;
        final isLoading = controller.isLoading.value;

        if (isLoading && orders.isEmpty) {
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

        if (orders.isEmpty && !isLoading) {
          return RefreshIndicator(
            onRefresh: controller.getOrderList,
            child: ListView(
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    'No orders yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
              ],
            ),
          );
        }

        return Skeletonizer(
          enabled: isLoading && orders.isNotEmpty,
          child: RefreshIndicator(
            onRefresh: controller.getOrderList,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order);
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

  Widget _buildOrderCard(BuildContext context, order) {
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
              'Order #${order.id}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            InkWell(
              onTap: () async {
                final mobile = order.billingAddress?.mobile;
                final uri = Uri.parse('tel:$mobile');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: Text(
                '${order.billingAddress?.fullName ?? ""} • ${order.billingAddress?.mobile ?? ""}',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
            Text(
              order.billingAddress?.address ?? "",
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Divider(height: 20),
            ...?order.saleProducts?.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 40,
                        width: 40,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.image,
                          size: 24,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            'x${item.quantity} • ৳${item.price}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Total: ৳${order.total}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                Spacer(),

                if (order.deliveryStatus == '2')
                  TextButton(
                    onPressed: () {
                      _showUndeliveryDialog(context, order);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: const Text('Mark Undelivered'),
                  ),

                AppWidgets().gapW16(),

                TextButton(
                  onPressed: () {
                    if (order.deliveryStatus == '0' ||
                        order.deliveryStatus == null) {
                      controller.setStatus(order.id.toString(), '1', '', '');
                    }
                    if (order.deliveryStatus == '1') {
                      controller.setStatus(order.id.toString(), '2', '', '');
                    }

                    if (order.deliveryStatus == '2') {
                      controller.setStatus(
                        order.id.toString(),
                        '3',
                        '',
                        order.total.toString(),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    order.deliveryStatus == '0' || order.deliveryStatus == null
                        ? 'Get Products'
                        : order.deliveryStatus == '1'
                        ? 'Pick Up'
                        : order.deliveryStatus == '2'
                        ? 'Deliver'
                        : '',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Mark as Undelivered',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedReason.value,
                      decoration: const InputDecoration(
                        hintText: 'Select a reason',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.all(12),
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
                    horizontal: 20,
                    vertical: 10,
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
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Mark Undelivered'),
              ),
            ],
          );
        });
      },
    );
  }
}
