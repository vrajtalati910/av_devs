part of 'i_product_repository.dart';

@Injectable(as: IProductRepository)
class ProductRepository extends IProductRepository {
  ProductRepository(
    super.client,
  );

  @override
  ApiResult<ProductListResponse> getProductList({int? page, int? perPage}) async {
    final skip = page != null ? (page - 1) * (perPage ?? 0) : 0;
    final limit = perPage;

    final response = await client.getPublic(
      url: AppStrings.productList,
      params: {
        if (page != null) 'skip': skip.toString(),
        if (perPage != null) 'limit': limit.toString(),
      },
    );
    print("RAW RESPONSE = ${response}");
    // print("RAW RESPONSE = ${response.}");

    return response.parseResponse(ProductListResponse.fromJson);
  }
}
