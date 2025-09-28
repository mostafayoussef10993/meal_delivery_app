// ignore_for_file: cast_from_null_always_fails

import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:musicapp/data/models/product/product.dart';

class ProductRepository {
  final http.Client client;
  ProductRepository({http.Client? client}) : client = client ?? http.Client();
  int? lastTotal;

  // ===============================
  // ===============================
  // FETCH PRODUCTS (with caching + pagination)
  // ===============================
  Future<List<Product>> fetchProducts({int limit = 10, int page = 1}) async {
    final skip = (page - 1) * limit;
    final url = Uri.parse(
      "https://dummyjson.com/products?limit=$limit&skip=$skip&select=id,title,price,thumbnail,rating,category,brand,discountPercentage,tags,reviews,description",
    );

    try {
      final res = await client.get(url).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) throw Exception('Failed to load products');

      final body = json.decode(res.body) as Map<String, dynamic>;

      // 👇 update total count for pagination
      lastTotal = body['total'];

      final list = (body['products'] as List)
          .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
          .toList();

      // 👇 save latest page into cache
      try {
        await _writeCache(list);
      } catch (_) {}

      return list;
    } catch (e) {
      if (kIsWeb) rethrow;

      // 👇 fallback to local cache
      final cached = await _readCache();
      if (cached.isNotEmpty) return cached;
      rethrow;
    }
  }

  // ===============================
  // FETCH PRODUCT BY ID (with caching)
  // ===============================
  Future<Product?> fetchProductById(int id) async {
    final url = Uri.parse('https://dummyjson.com/products/$id');
    try {
      final res = await client.get(url).timeout(const Duration(seconds: 10));
      if (res.statusCode != 200) throw Exception('Failed to load product');
      final body = json.decode(res.body) as Map<String, dynamic>;
      final product = Product.fromMap(body);

      // also merge into cache (optional)
      try {
        final cached = await _readCache();
        cached.removeWhere((p) => p.id == product.id);
        cached.insert(0, product);
        await _writeCache(cached);
      } catch (_) {}

      return product;
    } catch (e) {
      if (kIsWeb) return null;
      final cached = await _readCache();
      final found = cached.firstWhere(
        (p) => p.id == id,
        orElse: () => null as Product,
      );
      return found;
    }
  }

  // ===============================
  // FETCH PRODUCT BY ID (original)
  // ===============================
  Future<Product> fetchProductByIdOriginal(int id) async {
    final url = Uri.parse("https://dummyjson.com/products/$id");
    final res = await client.get(url);

    if (res.statusCode != 200) {
      throw Exception(
        'Failed to load product with id $id. Status code: ${res.statusCode}',
      );
    }

    return Product.fromMap(json.decode(res.body) as Map<String, dynamic>);
  }

  // ===============================
  // SEARCH PRODUCTS
  // ===============================
  Future<List<Product>> searchProducts(String query) async {
    final url = Uri.parse(
      "https://dummyjson.com/products/search?q=$query&select=id,title,price,thumbnail,rating",
    );

    final res = await client.get(url);
    if (res.statusCode != 200) {
      throw Exception(
        'Failed to search products. Status code: ${res.statusCode}',
      );
    }

    final body = json.decode(res.body) as Map<String, dynamic>;
    final list = (body['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return list;
  }

  // ===============================
  // LOCAL FILE CACHE HELPERS
  // ===============================
  Future<io.File> _cacheFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/products_cache.json';
    return io.File(path);
  }

  Future<void> _writeCache(List<Product> products) async {
    final f = await _cacheFile();
    final jsonStr = json.encode(products.map((p) => p.toMap()).toList());
    await f.writeAsString(jsonStr);
  }

  Future<List<Product>> _readCache() async {
    try {
      final f = await _cacheFile();
      if (!await f.exists()) return [];
      final s = await f.readAsString();
      final arr = json.decode(s) as List;
      return arr
          .map((e) => Product.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
