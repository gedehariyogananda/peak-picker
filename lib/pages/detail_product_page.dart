import 'package:flutter/material.dart';
import 'package:peak_packer/models/favorit.dart';
import 'package:peak_packer/models/product.dart';
import 'package:peak_packer/service/favorit_service.dart';
import 'package:peak_packer/widgets/button_checkout_widget.dart';
import 'package:peak_packer/widgets/description_product_widget.dart';
import 'package:peak_packer/widgets/devider_widget.dart';
import 'package:peak_packer/widgets/pin_content_widget.dart';
import 'package:peak_packer/widgets/pin_title_widget.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 233, 233),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.product.image_product),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30.0,
                  left: 20.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 56, 153, 4),
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name_product,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      int productInt = int.parse(widget.product.id);
                      try {
                        Favorit favorit = Favorit(product_id: productInt);
                        await FavoritService.addFavoriteProduct(favorit);
                        setState(() {
                          isFavorite = true;
                        });
                        // Tampilkan AlertDialog ketika produk berhasil ditambahkan ke favorit
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Center(
                              child: Text(
                                "Berhasil Ditambahkan ke Favorit",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } catch (e) {
                        await FavoritService.deleteFavoriteProduct(
                            widget.product.id);
                        setState(() {
                          isFavorite = false;
                        });
                        print("succes delete");
                      }
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : null,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Text(
                    "${widget.product.priceday_product}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  const Text(
                    "/day",
                    style: TextStyle(
                        color: Color.fromARGB(255, 56, 153, 4),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            DescriptionProduct(
              nameDescription: "Category",
              description: widget.product.category_product,
            ),
            const SizedBox(height: 8),
            const DeviderWidget(),
            const SizedBox(height: 10),
            const DescriptionProduct(
              nameDescription: "Rating",
              description: "⭐⭐⭐⭐ (4.5)",
            ),
            const SizedBox(height: 8),
            const DeviderWidget(),
            const SizedBox(height: 10),
            const DescriptionProduct(
              nameDescription: "Views",
              description: "👁 1000 views",
            ),
            const SizedBox(height: 8),
            const DeviderWidget(),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Deskripsi"),
            const SizedBox(height: 10),
            PinContentWidget(
              description: widget.product.description_product,
            ),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Syarat Sewa"),
            const SizedBox(height: 10),
            const PinContentWidget(
              description:
                  "Harus menyertakan KTP / SIM yang masih berlaku (dibawa saat pengambilan barang)",
            ),
            const SizedBox(height: 20),
            const PinTitleWidget(nameDescription: "📍 Kondisi Produk"),
            const SizedBox(height: 10),
            PinContentWidget(description: widget.product.condition_product),
            const SizedBox(
              height: 25.0,
            ),
            CheckoutButton(
              id: widget.product.id,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
