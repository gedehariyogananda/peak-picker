import 'dart:convert';

import 'package:peak_packer/client.dart';
import 'package:http/http.dart' as http;
import 'package:peak_packer/models/favorit.dart';
import 'package:peak_packer/models/user.dart';
import 'package:peak_packer/models/favorit_product.dart';

class FavoritService {
  static String favoritUrl = Client.baseUrl + "/favorit";

  static Future<void> addFavoriteProduct(Favorit favorit) async {
    try {
      final response = await http.post(
        Uri.parse(favoritUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
        body: jsonEncode(<String, dynamic>{
          'product_id': favorit.product_id,
        }),
      );

      if (response.statusCode == 200) {
        print("Success: Product added to favorites.");
      } else {
        throw Exception(
            'Failed to add favorite product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Favo>> getAllFavoritProductUser() async {
    if (AuthToken.token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse(favoritUrl),
      headers: {
        'Authorization': 'Bearer ${AuthToken.token}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Favo> products = [];
      for (var item in jsonData['data']) {
        products.add(Favo.fromJson(item));
      }

      return products;
    } else {
      throw Exception('Failed to load favorite products');
    }
  }

  // buatkan saya untuk menghapus dari category dengan enpoint api/favorit/id, dihapus berdasarkan id nya dari table Favarorit
  static Future<void> deleteFavoriteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse(favoritUrl + "/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${AuthToken.token}',
        },
      );

      if (response.statusCode == 200) {
        print("Success: Product deleted from favorites.");
      } else {
        throw Exception(
            'Failed to delete favorite product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
