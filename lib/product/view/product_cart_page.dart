import 'package:av_devs/core/local_storage/i_local_storage_repository.dart';
import 'package:av_devs/core/utils/extentions/string_extentions.dart';
import 'package:av_devs/core/utils/utility.dart';
import 'package:av_devs/injector/injector.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:av_devs/product/widget/cart_product_widget.dart';
import 'package:av_devs/product/widget/payment_cart_widget.dart';
import 'package:av_devs/widget/common_app_bar.dart';
import 'package:flutter/material.dart';

class ProductCartPage extends StatefulWidget {
  const ProductCartPage({super.key});

  @override
  State<ProductCartPage> createState() => _ProductCartPageState();
}

class _ProductCartPageState extends State<ProductCartPage> {
  List<ProductModel> cartProducts = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final cart = getIt<ILocalStorageRepository>().getCartProducts ?? [];
    setState(() {
      cartProducts = cart;
    });
  }

  Future<void> addProduct(ProductModel product) async {
    final currentQty = product.qty ?? 0;

    if (product.stock != null && currentQty >= product.stock!) {
      Utility.toast(message: "Cannot add more, stock limit reached");
      return;
    }

    product.qty = currentQty + 1;

    await getIt<ILocalStorageRepository>().saveProduct(product);

    // Reload cart
    await loadCart();
  }

  Future<void> removeProduct(ProductModel product) async {
    final qty = (product.qty ?? 0) - 1;
    product.qty = qty > 0 ? qty : 0;
    await getIt<ILocalStorageRepository>().saveProduct(product);
    await loadCart();
  }

  double get totalPrice {
    return cartProducts.fold(
      0,
      (sum, p) => sum + ((p.price ?? 0) * (p.qty ?? 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        isLeading: true,
        titleSpacing: 8,
        onBackTap: () {
          Navigator.pop(context);
        },
        title: ("My Cart"),
      ),
      bottomSheet:
          cartProducts.isEmpty ? const SizedBox.shrink() : BottomCartBar(onPayNow: () {}, totalPrice: totalPrice),
      body: cartProducts.isEmpty
          ? Center(
              child: Text(
                ("Your cart is empty").capitalizeFirstofEach,
                style: const TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: cartProducts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = cartProducts[index];
                    return CartProductWidget(
                      product: product,
                      onAdd: () => addProduct(product),
                      onRemove: () => removeProduct(product),
                    );
                  },
                )),
              ],
            ),
    );
  }
}
