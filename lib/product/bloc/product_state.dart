import 'package:av_devs/product/model/product_model.dart';
import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final List<ProductModel> products;
  final bool isLoading;
  final bool isPageLoading;
  final bool hasMore;
  final int currentPage;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.isPageLoading = false,
    this.hasMore = true,
    this.currentPage = 1,
  });

  ProductState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    bool? isPageLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, isPageLoading, hasMore, currentPage];
}
