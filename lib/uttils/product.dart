class Product {
  String nameProduct;
  String priceDayProduct;
  String categoryProduct;
  String descriptionProduct;
  String imageProduct;
  String conditionProduct;

  Product({
    required this.nameProduct,
    required this.categoryProduct,
    required this.priceDayProduct,
    required this.descriptionProduct,
    required this.imageProduct,
    required this.conditionProduct,
  });

  static fromJson(json) {}
}

List<Product> listProduct = [
  Product(
    nameProduct: 'Tenda Kapasitas 2',
    priceDayProduct: "Rp 50.000",
    categoryProduct: "Tenda",
    descriptionProduct:
        "Tenda ini cocok untuk 2 orang, sangat nyaman dan mudah dibawa kemana-mana",
    imageProduct:
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    conditionProduct: "Baru",
  ),
  Product(
    nameProduct: 'Sleeping Bag Keren',
    priceDayProduct: "Rp 30.000",
    categoryProduct: "Perlengkapan Camping",
    descriptionProduct:
        "Sleeping bag yang nyaman untuk digunakan di alam terbuka",
    imageProduct:
        'https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826__480.jpg',
    conditionProduct: "Baru",
  ),
  Product(
    nameProduct: 'Kompor Gas Portable',
    priceDayProduct: "Rp 40.000",
    categoryProduct: "Perlengkapan Camping",
    descriptionProduct:
        "Kompor gas portable yang ringan dan mudah dibawa saat camping",
    imageProduct:
        'https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826__480.jpg',
    conditionProduct: "Baru",
  ),
  Product(
    nameProduct: 'Tenda Kapasitas 4',
    priceDayProduct: "Rp 70.000",
    categoryProduct: "Tenda",
    descriptionProduct:
        "Tenda besar yang cocok untuk 4 orang, dilengkapi dengan ventilasi baik",
    imageProduct:
        'https://cdn.pixabay.com/photo/2016/02/19/11/36/tent-1208201__480.jpg',
    conditionProduct: "Baru",
  ),
];
