import 'package:delivery_app/app/core/widget/global_appbar.dart';
                                                        import 'package:flutter/material.dart';
                                                        import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
                                                        import '../controllers/orders_controller.dart';

                                                        class OrdersView extends GetView<OrdersController> {
                                                          const OrdersView({super.key});

                                                          @override
                                                          Widget build(BuildContext context) {
                                                            return Scaffold(
                                                              appBar: globalAppBar(context, 'Your Orders'),
                                                              body: Obx(() {
                                                                final orders = controller.orderList;
                                                                if (orders.isEmpty) {
                                                                  return const Center(
                                                                    child: Text(
                                                                      'No orders yet!',
                                                                      style: TextStyle(fontSize: 18, color: Colors.grey),
                                                                    ),
                                                                  );
                                                                }
                                                                return ListView.builder(
                                                                  padding: const EdgeInsets.all(12),
                                                                  itemCount: orders.length,
                                                                  itemBuilder: (context, index) {
                                                                    final order = orders[index];
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
                                                                            Text(
                                                                              'Order #${order.id}',
                                                                              style: const TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 16,
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 6),
                                                                            InkWell(
                                                                              onTap: () async {
                                                                                final mobile = order.billingAddress?.mobile;
                                                                                  final uri = Uri.parse('tel:${int.parse(mobile!)}');
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
                                                                            ...?order.saleProducts?.map((item) => Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                                                              child: Row(
                                                                                children: [
                                                                                  ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    child: Container(
                                                                                            height: 40,
                                                                                            width: 40,
                                                                                            color: Colors.grey[200],
                                                                                            child: const Icon(Icons.image, size: 24, color: Colors.grey),
                                                                                          ),
                                                                                  ),
                                                                                  const SizedBox(width: 12),
                                                                                  Expanded(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          item.productName.toString(),
                                                                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                                                                          softWrap: true,
                                                                                        ),
                                                                                        Text(
                                                                                          'x${item.quantity} • ৳${item.price}',
                                                                                          style: const TextStyle(fontSize: 12, color: Colors.green),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                            const SizedBox(height: 10),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Text(
                                                                                  '৳${order.total}',
                                                                                  style: const TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize: 16,
                                                                                  ),
                                                                                ),
                                                                                TextButton(
                                                                                  onPressed: () {
                                                                                    // Show order details
                                                                                  },
                                                                                  style: TextButton.styleFrom(
                                                                                    backgroundColor: Colors.orangeAccent,
                                                                                    foregroundColor: Colors.white,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(8),
                                                                                    ),
                                                                                  ),
                                                                                  child: const Text('View Details'),
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
                                                        }