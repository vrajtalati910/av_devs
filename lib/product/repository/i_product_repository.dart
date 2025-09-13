import 'package:av_devs/core/constant/app_string.dart';
import 'package:av_devs/core/utils/extentions/fpdart_extentions.dart';
import 'package:av_devs/core/utils/network/client.dart';
import 'package:av_devs/product/response/product_list_response.dart';
import 'package:injectable/injectable.dart';

part 'product_repository.dart';

abstract class IProductRepository {
  IProductRepository(this.client);
  final Client client;

  ApiResult<ProductListResponse> getProductList({
    int? page,
    int? perPage,
  });
}
