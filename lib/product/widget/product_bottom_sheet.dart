import 'package:av_devs/core/theme/app_assets.dart';
import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:av_devs/product/view/product_cart_page.dart';
import 'package:av_devs/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductBottomSheet extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> cartDetail;
  final int quantity;
  final VoidCallback addToCart;
  final VoidCallback removeFromCart;

  const ProductBottomSheet({
    super.key,
    required this.product,
    required this.cartDetail,
    required this.quantity,
    required this.addToCart,
    required this.removeFromCart,
  });

  bool get isProductInCart => cartDetail.any((p) => p.id == product.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (cartDetail.isNotEmpty)
            GestureDetector(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ProductCartPage(),
                ));
              },
              child: Row(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white),
                      Positioned(
                        top: -5,
                        right: -50,
                        child: Text(
                          '${cartDetail.length}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (isProductInCart) ...[
                    const SizedBox(width: 8),
                    const Text(
                      'View Cart',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ],
              ),
            )
          else
            const SizedBox.shrink(),
          if (cartDetail.isEmpty || !isProductInCart) ...[
            if (cartDetail.isNotEmpty)
              const SizedBox(
                width: 16,
              ),
            Expanded(
              flex: 2,
              child: CommonButton(
                maximumSize: Size(cartDetail.isEmpty ? double.infinity : 100, 40),
                text: "Add to Cart",
                onTap: addToCart,
                backgroundColor: Colors.white,
                textColor: AppColors.primary,
                icon: AppAssets.itemsIcon,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            )
          ] else
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.greyF6,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: removeFromCart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 6, 6),
                      child: SvgPicture.asset(AppAssets.minIcon),
                    ),
                  ),
                  Text(
                    '${product.qty ?? 0}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: addToCart,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 6, 6),
                      child: SvgPicture.asset(AppAssets.addIcon),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
