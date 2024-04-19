import 'package:flutter/material.dart';
import 'package:peak_packer/uttils/faq_content.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Nunito',
        ),
        leadingWidth: 100,
        title: Text("FAQ"),
      ),
      body: SafeArea(
        child: ListView(
          children: const [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24.0, 39.0, 24.0, 0),
                  child: Column(
                    children: [
                      FaqContent(
                        question: 'Apa itu PeakPicker?',
                        answer:
                            'Sebuah aplikasi dimana untuk pemesanan berbagai alat dan barang serta kebutuhan mendaki yang murah dan yang pasti lengkap dan tidak ribet.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question:
                            'Bagaimana cara memesan barang di aplikasi PeakPicker?',
                        answer:
                            'Untuk membeli barang, silahkan klik pada tampilan yang ingin dibeli, lalu checkout barang. jangan lupa untuk mengisikan tanggal peminjaman serta pengembalian barangnya ya.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question: 'Setelah memesan, apa yang harus dilakukan?',
                        answer:
                            'setelah kalian memesan, maka tunggu acc dari pihak admin. akan dilakukan pengecekan stok barang untuk memastikan barangmu apakah ada atau tidak.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question:
                            'Setelah di acc, apa yang harus saya lakukan?',
                        answer:
                            'setelah acc, kalian harus segera menuju toko untuk pengambilan barang serta pembayaran sesuai dengan tangal kalian pesan yaa.',
                      ),
                      SizedBox(height: 15),
                      FaqContent(
                        question: 'Keunggulan Aplikasi ini?',
                        answer:
                            'Tidak ribet, cepat dan mudah dimengerti. kami berfokuskan pada kenyamana kalian yang pasti, jayajayajaya',
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
