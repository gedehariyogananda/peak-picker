import 'package:flutter/material.dart';
import 'package:peak_packer/models/product.dart';
import 'package:peak_packer/pages/checkout_page.dart';
import 'package:peak_packer/service/product_service.dart';
import 'package:peak_packer/widgets/api_widget.dart';
import 'package:peak_packer/widgets/category_navigation_wodget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String selectedCategory = "Rekomendasi";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchingProduct(String query) {
    if (searchController.text.isNotEmpty) {
      setState(() {
        selectedCategory = 'Pencarian';
        getProductByCategory(selectedCategory);
        print(query);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: PageView(
                        children: [
                          Image.asset(
                            'assets/images/gambar1.png',
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            'assets/images/gambar2.png',
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                Positioned(
                  right: 20,
                  top: 50,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[50],
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckoutPage()));
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      color: Colors.green,
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 50,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Image.network(
                      'https://www.shareicon.net/data/2016/09/01/822739_user_512x512.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 290,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFE0E0E0),
                                hintText: 'Cari barang...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(10.0),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 56, 153, 4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  String query = searchController.text;
                                  onSearchingProduct(query);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: TextStyle(
                      color: Color(0xFF388B04),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 6.0),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Rekomendasi';
                        });
                      },
                      child: CategoryNavigation(category: "Rekomendasi"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Tenda';
                        });
                      },
                      child: CategoryNavigation(category: "Tenda"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Alat Camping';
                        });
                      },
                      child: CategoryNavigation(category: "Alat Camping"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Lainnya';
                        });
                      },
                      child: CategoryNavigation(category: "Lainnya"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
              child: SizedBox(
                height: 285,
                child: ApiWidget(
                  selectedCategory: getProductByCategory(selectedCategory),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Product>> getProductByCategory(String category) async {
    switch (category) {
      case "Tenda":
        return ProductService.getProductByCategoryTenda();
      case "Alat Camping":
        return ProductService.getProductByCategoryAlatAlatCamping();
      case "Lainnya":
        return ProductService.getProductByCategoryAlatLainnya();
      case "Pencarian":
        return ProductService.searchingProductByName(searchController.text);
      default:
        return ProductService.getProducts();
    }
  }
}
