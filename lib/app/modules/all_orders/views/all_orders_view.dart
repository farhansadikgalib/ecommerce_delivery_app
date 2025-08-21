import 'package:delivery_app/app/core/widget/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../controllers/all_orders_controller.dart';

class AllOrdersView extends GetView<AllOrdersController> {
  const AllOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'All Orders'),
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

        return RefreshIndicator(
          onRefresh: controller.getOrderList,
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.all(12),
            itemCount: orders.length + (controller.hasMoreData.value ? 1 : 0),
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
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (controller.hasMoreData.value) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: TextButton(
                          onPressed: controller.loadMoreOrders,
                          child: const Text('Load More'),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text(
                          'No more orders to load',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                });
              }
            },
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
                if (mobile != null && mobile.isNotEmpty) {
                  final uri = Uri.parse('tel:$mobile');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
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
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
