import 'package:av_devs/core/theme/app_assets.dart';
import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/core/utils/utility.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;
  final bool isForEdit;
  final bool isLoading;
  const ProductWidget({
    super.key,
    required this.product,
    required this.onTap,
    this.isForEdit = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Shimmer placeholder
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.whiteOffColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 100, width: double.infinity, color: Colors.white),
              const SizedBox(height: 12),
              Container(height: 16, width: 150, color: Colors.white),
              const SizedBox(height: 6),
              Container(height: 14, width: 80, color: Colors.white),
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.whiteOffColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Avatar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Utility.imageLoader(
                    url: product.images?[0] ?? '', placeholder: AppAssets.appLogo, height: 100, width: 100),
              ],
            ),
            const SizedBox(width: 12),

            /// Name, phone, location
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (product.title ?? ""),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$ ${(product.price ?? 0).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
