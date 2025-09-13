import 'package:av_devs/core/theme/app_assets.dart';
import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/core/utils/utility.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CartProductWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const CartProductWidget({
    super.key,
    required this.product,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Utility.imageLoader(
                url: product.images!.first,
                placeholder: AppAssets.appLogo,
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${(product.price ?? 0).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
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
                    onTap: onRemove,
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
                    onTap: onAdd,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 6, 6, 6),
                      child: SvgPicture.asset(AppAssets.addIcon),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
