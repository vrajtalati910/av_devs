import 'dart:convert';

import 'package:av_devs/core/constant/app_string.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'local_storage_repository.dart';

abstract class ILocalStorageRepository {
  ILocalStorageRepository(this.preferences);
  final SharedPreferences preferences;

  /// Save or update a product in cart
  Future<List<ProductModel>> saveProduct(ProductModel? product);

  /// Get all products in cart
  List<ProductModel>? get getCartProducts;

  /// Remove a product from cart by id
  Future<List<ProductModel>> removeProduct(int productId);

  /// Clear the entire cart
  Future<bool> clearCart();
}
