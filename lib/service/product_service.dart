import 'dart:convert';

import 'package:peak_packer/client.dart';
import 'package:peak_packer/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:peak_packer/models/user.dart';

class ProductService {
  static String baseUrl = Client.baseUrl + '/products';

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var product in result['data']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception(result['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Product> getProductById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return Product.fromJson(result['data']);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Product>> getProductByCategoryTenda() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/category/tenda'));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var product in result['data']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Product>> getProductByCategoryAlatAlatCamping() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/category/alat-camping'));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var product in result['data']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Product>> getProductByCategoryAlatLainnya() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/category/lainnya'));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var product in result['data']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Product>> searchingProductByName(
      String nameproducts) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/search?keyword=${nameproducts}'));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<Product> products = [];
        for (var product in result['data']) {
          products.add(Product.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
