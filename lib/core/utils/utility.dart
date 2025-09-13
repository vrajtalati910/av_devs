import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/core/utils/extentions/string_extentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utility {
  // Flutter toast
  static void toast({required String? message, Color? color}) {
    if (message != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message, backgroundColor: color ?? AppColors.inputField, textColor: AppColors.black);
    }
  }

  static Widget noDataWidget({required BuildContext context, required String text}) {
    return Center(
      child: Text(
        text.inCaps,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  // Image loader
  static Widget imageLoader(
      {required String url,
      required String placeholder,
      double? height,
      double? width,
      BoxFit? fit,
      BuildContext? context,
      bool isShapeCircular = false,
      BorderRadius? borderRadius,
      List<BoxShadow>? boxShadow,
      BoxShape? shape}) {
    if (url.trim() == '') {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: isShapeCircular ? null : borderRadius ?? BorderRadius.circular(0),
          boxShadow: boxShadow,
          image: DecorationImage(
            image: AssetImage(placeholder),
            fit: fit ?? BoxFit.cover,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isShapeCircular ? null : borderRadius ?? BorderRadius.circular(10),
          // borderRadius: borderRadius ?? BorderRadius.circular(10),
          shape: shape ?? BoxShape.rectangle,
          boxShadow: boxShadow,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, error, dynamic a) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius: isShapeCircular ? null : borderRadius ?? BorderRadius.circular(10),
          // borderRadius: borderRadius ??  BorderRadius.circular(10),
          boxShadow: boxShadow,
          image: DecorationImage(
            image: AssetImage(placeholder),
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: boxShadow,
          color: AppColors.background,
        ),
      ),
    );
  }
}
