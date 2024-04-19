import 'package:flutter/material.dart';
import 'package:peak_packer/models/checkout.dart';
import 'package:peak_packer/models/total_checkout.dart';
import 'package:peak_packer/page_init.dart';
import 'package:peak_packer/service/checkout_service.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  String totalPrice = '';
  bool isChecked = false;
  int itemCount = 1;
  bool isLoading = false;
  late Future<List<Checkout>> listProductUserCheckout =
      CheckoutService.getProductUserCheckout();

  void _getTotalCheckout() async {
    try {
      final totalCheckout = await CheckoutService.getPriceAllResultCheckout();
      setState(() {
        totalPrice = totalCheckout.totalPrice;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    listProductUserCheckout = CheckoutService.getProductUserCheckout();
    _getTotalCheckout();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: FutureBuilder<List<Checkout>>(
          future: listProductUserCheckout,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              if (snapshot.data != null) {
                List<Checkout> checkoutData = snapshot.data!;
                return ListView.builder(
                    itemCount: checkoutData.length,
                    itemBuilder: (context, index) {
                      final checkout = checkoutData[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Konfirmasi"),
                                          content: Text(
                                              "Apakah Anda yakin ingin menghapus item ini?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Tutup kotak dialog
                                              },
                                              child: Text("Tidak"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                // Tampilkan indikator loading
                                                setState(() {
                                                  isLoading = true;
                                                });

                                                // Hapus produk dari checkout
                                                await CheckoutService
                                                    .deleteProductAllCheckout(
                                                  checkout.productId.toString(),
                                                );

                                                // Muat ulang data checkout
                                                listProductUserCheckout =
                                                    CheckoutService
                                                        .getProductUserCheckout();
                                                _getTotalCheckout();

                                                // Tunggu hingga data dimuat ulang dan berhenti menampilkan loading
                                                await Future.delayed(
                                                    const Duration(seconds: 1));

                                                // Berhenti menampilkan loading dan perbarui tampilan widget
                                                setState(() {
                                                  isLoading = false;
                                                });

                                                // Tutup kotak dialog
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Ya"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Image.network(
                                    checkout.imageProduct,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(checkout.nameProduct),
                                        const SizedBox(height: 2),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      // Tampilkan indikator loading
                                                      setState(() {
                                                        isLoading = true;
                                                      });

                                                      // Tambahkan produk ke checkout
                                                      await CheckoutService
                                                          .deleteProductCheckout(
                                                        checkout.id.toString(),
                                                      );

                                                      listProductUserCheckout =
                                                          CheckoutService
                                                              .getProductUserCheckout();
                                                      _getTotalCheckout();

                                                      // Tunggu hingga data dimuat ulang dan berhenti menampilkan loading
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 1));

                                                      // Berhenti menampilkan loading dan perbarui tampilan widget
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.remove),
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: TextField(
                                                      textAlign:
                                                          TextAlign.center,
                                                      readOnly: true,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      controller:
                                                          TextEditingController(
                                                              text: checkout
                                                                  .totalBarangBeli
                                                                  .toString()),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      // Tampilkan indikator loading
                                                      setState(() {
                                                        isLoading = true;
                                                      });

                                                      // Tambahkan produk ke checkout
                                                      await CheckoutService
                                                          .addProductCheckout(
                                                        checkout.id.toString(),
                                                      );

                                                      // Muat ulang data checkout
                                                      listProductUserCheckout =
                                                          CheckoutService
                                                              .getProductUserCheckout();
                                                      _getTotalCheckout();

                                                      // Tunggu hingga data dimuat ulang dan berhenti menampilkan loading
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 1));

                                                      // Berhenti menampilkan loading dan perbarui tampilan widget
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    icon: const Icon(Icons.add),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            'Rp. ${checkout.resultPricePurchased}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Pojok bawah untuk tombol Checkout
                        ],
                      );
                    });
              } else {
                return const Center(
                  child: Text("Data tidak ditemukan"),
                );
              }
            }
          },
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          color: Colors.green,
          height: 50.0,
          child: TextButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                // Tambahkan produk ke checkout
                await CheckoutService.checkoutProduct();

                // Tunggu hingga data dimuat ulang dan berhenti menampilkan loading
                await Future.delayed(const Duration(seconds: 1));

                // Berhenti menampilkan loading
                setState(() {
                  isLoading = false;
                });

                // Tampilkan dialog berhasil
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Checkout Successful'),
                      content:
                          Text('Your order has been successfully checked out.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PageInit()));
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    totalPrice.isNotEmpty ? totalPrice : 'Data tidak ditemukan',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
