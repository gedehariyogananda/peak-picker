import 'dart:convert';

import 'package:peak_packer/client.dart';
import 'package:peak_packer/models/checkout.dart';
import 'package:http/http.dart' as http;
import 'package:peak_packer/models/history.dart';
import 'package:peak_packer/models/total_checkout.dart';
import 'package:peak_packer/models/user.dart';

class CheckoutService {
  static String baseUrl = Client.baseUrl + '/purchased';

  static Future<List<Checkout>> getProductUserCheckout() async {
    final response = await http.get(
      Uri.parse('$baseUrl/keranjang'),
      headers: {
        'Authorization': 'Bearer ${AuthToken.token}',
        'Content-Type': 'application/json',
      },
    );
    final result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Checkout> checkout = [];
      for (var productCheckout in result['data']) {
        checkout.add(Checkout.fromJson(productCheckout));
      }
      return checkout;
    } else {
      throw Exception(result['message']);
    }
  }

  static Future<void> addProductCheckout(String id) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/keranjang/${id}/tambah"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Success: Product added to checkout.");
      } else {
        throw Exception(
            'Failed to add product to checkout: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> deleteProductCheckout(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/keranjang/${id}/hapus"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Success: Product added to checkout.");
      } else {
        throw Exception(
            'Failed to add product to checkout: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> checkoutProduct() async {
    try {
      final response = await http.patch(
        Uri.parse("$baseUrl/keranjang/checkout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Success: Product aman checkout.");
      } else {
        throw Exception(
            'Failed to add product to checkout: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> addCheckoutProductId(
      String id, String startDate, String endDate) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/masuk-keranjang"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
        body: jsonEncode(<String, dynamic>{
          'product_id': id,
          'start_borrow_purchased': startDate,
          'end_borrow_purchased': endDate,
        }),
      );

      if (response.statusCode == 200) {
        print("Success: Product added to checkout.");
      } else {
        throw Exception(
            'Failed to add checkout product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> deleteProductAllCheckout(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/keranjang/hapus-semua/${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Success: Product added to checkout.");
      } else {
        throw Exception(
            'Failed to add product to checkout: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<TotalCheckout> getPriceAllResultCheckout() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/keranjang/checkout/total'),
        headers: {
          'Authorization': 'Bearer ${AuthToken.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return TotalCheckout.fromJson(result);
      } else {
        throw Exception('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<PurchasedHistory>> getRiwayate() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/riwayat/pembelian'),
        headers: {
          'Authorization': 'Bearer ${AuthToken.token}',
          'Content-Type': 'application/json',
        },
      );
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        List<PurchasedHistory> checkout = [];
        for (var productCheckout in result['data']) {
          checkout.add(PurchasedHistory.fromJson(productCheckout));
        }
        return checkout;
      } else {
        throw Exception(result['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
