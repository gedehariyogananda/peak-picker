import 'package:flutter/material.dart';
import 'package:peak_packer/models/history.dart';
import 'package:peak_packer/service/checkout_service.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History Pemesanan"),
      ),
      body: FutureBuilder<List<PurchasedHistory>>(
        future: CheckoutService.getRiwayate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<PurchasedHistory> purchasedHistory = snapshot.data!;
            return ListView.builder(
              itemCount: purchasedHistory.length,
              itemBuilder: (context, index) {
                final history = purchasedHistory[index];
                return GestureDetector(
                  onTap: () {
                    // Tampilkan modal dengan detail history ketika di tap
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(history.nameProduct),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'Start Borrow: ${history.startBorrowPurchased}'),
                            Text('End Borrow: ${history.endBorrowPurchased}'),
                            Text(
                                'Result Harga /barang : ${history.resultPricePurchased}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(history.nameProduct),
                    subtitle:
                        Text('Status Acc Admin: ${history.attemptPurchased}'),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(history.imageProduct),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
