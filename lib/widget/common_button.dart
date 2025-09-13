import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/widget/app_asset_image.dart';
import 'package:av_devs/widget/custom_progress_indecator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    this.text,
    required this.onTap,
    super.key,
    this.isLoading = false,
    this.backgroundColor,
    this.removeShadow = false,
    this.showBorder = false,
    this.textColor,
    this.maximumSize,
    this.icon,
    this.borderColor,
    this.padding,
    this.child,
  });
  final String? text;
  final void Function()? onTap;
  final bool isLoading;
  final Color? backgroundColor;
  final bool removeShadow;
  final bool showBorder;
  final Color? textColor;
  final Color? borderColor;
  final Size? maximumSize;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maximumSize?.width ?? double.infinity,
        maxHeight: maximumSize?.height ?? double.infinity,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: showBorder
            ? Border.all(
                color: borderColor ?? AppColors.disabledBorder,
              )
            : null,
        boxShadow: removeShadow
            ? null
            : [
                BoxShadow(
                  color: AppColors.boxShadow.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: isLoading ? () {} : onTap,
        child: isLoading
            ? SizedBox(
                height: 18,
                width: 18,
                child: CustomProgressIndecator(
                  color: showBorder ? AppColors.primaryBlack : AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[
                      AppAssetImage(icon ?? '', height: 20, width: 20, color: AppColors.primary),
                      const Gap(8),
                    ],
                    Flexible(
                      child: Text(
                        text ?? '',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: textColor ?? AppColors.white,
                            ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
