import 'package:flutter/material.dart';
import 'package:peak_packer/service/checkout_service.dart';

class CheckoutButton extends StatefulWidget {
  final String id;

  const CheckoutButton({Key? key, required this.id}) : super(key: key);

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  late TextEditingController _startDateController;
  late TextEditingController _endDateController;

  @override
  void initState() {
    super.initState();
    _startDateController = TextEditingController();
    _endDateController = TextEditingController();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            DateTime? startDate;
            DateTime? endDate;

            return AlertDialog(
              title: const Text(
                'Pilih Tanggal Peminjaman',
                style: TextStyle(fontSize: 20.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    readOnly: true,
                    controller: _startDateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Mulai',
                      suffixIcon: Icon(
                        Icons.date_range,
                        color: Color.fromARGB(255, 56, 153, 4),
                      ),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromARGB(255, 56, 153, 4),
                                onPrimary: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        setState(() {
                          startDate = selectedDate;
                          _startDateController.text =
                              "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    readOnly: true,
                    controller: _endDateController,
                    decoration: const InputDecoration(
                      labelText: 'Tanggal Selesai',
                      suffixIcon: Icon(
                        Icons.date_range,
                        color: Color.fromARGB(255, 56, 153, 4),
                      ),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromARGB(255, 56, 153, 4),
                                onPrimary: Colors.white,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (selectedDate != null) {
                        setState(() {
                          endDate = selectedDate;
                          _endDateController.text =
                              "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey,
                        ),
                        child: const Center(
                          child: Text(
                            "Batal",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        // Panggil fungsi untuk menambahkan produk ke keranjang
                        addProductToCart(widget.id, _startDateController.text,
                            _endDateController.text);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: const Color.fromARGB(255, 56, 153, 4),
                        ),
                        child: const Center(
                          child: Text(
                            "Okeyy",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 56, 153, 4),
          ),
          child: const Center(
            child: Text(
              "Masukkan Ke Keranjang",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void addProductToCart(String id, String startDate, String endDate) async {
    print(id);
    print(startDate);
    print(endDate);
    try {
      await CheckoutService.addCheckoutProductId(id, startDate, endDate);
      print("success");

      // Tampilkan pesan sukses menggunakan SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Produk berhasil ditambahkan ke keranjang'),
          duration: Duration(seconds: 2), // Durasi tampilan SnackBar
        ),
      );
    } catch (e) {
      print(Exception(e));
    }
  }
}
