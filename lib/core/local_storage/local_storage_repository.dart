part of 'i_local_storage_repository.dart';

@Injectable(as: ILocalStorageRepository)
class LocalStorageRepository extends ILocalStorageRepository {
  LocalStorageRepository(super.preferences);

  // --- Save or update a product in the cart ---
  @override
  Future<List<ProductModel>> saveProduct(ProductModel? product) async {
    if (product == null) throw Exception('Product cannot be null');

    final cart = getCartProducts ?? [];

    if (product.qty == 0) {
      // Remove product if qty is 0
      cart.removeWhere((p) => p.id == product.id);
    } else {
      final index = cart.indexWhere((p) => p.id == product.id);
      if (index >= 0) {
        cart[index] = product;
      } else {
        cart.add(product);
      }
    }

    await preferences.setString(
      AppStrings.productCartKey,
      jsonEncode(cart.map((e) => e.toJson()).toList()),
    );

    return cart;
  }

  // --- Get all products in cart ---
  @override
  List<ProductModel>? get getCartProducts {
    try {
      final cartKey = preferences.getString(AppStrings.productCartKey);
      if (cartKey != null) {
        final List<dynamic> jsonList = jsonDecode(cartKey);
        return jsonList.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // --- Remove a single product from cart ---
  @override
  Future<List<ProductModel>> removeProduct(int productId) async {
    try {
      final cart = getCartProducts ?? [];
      cart.removeWhere((p) => p.id == productId);

      await preferences.setString(AppStrings.productCartKey, jsonEncode(cart.map((e) => e.toJson()).toList()));
      return cart;
    } catch (e) {
      throw Exception('Error removing product: ${e.toString()}');
    }
  }

  // --- Clear entire cart ---
  @override
  Future<bool> clearCart() async {
    return preferences.remove(AppStrings.productCartKey);
  }
}
