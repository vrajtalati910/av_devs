import 'dart:developer';

import 'package:av_devs/product/bloc/product_event.dart';
import 'package:av_devs/product/bloc/product_state.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:av_devs/product/repository/i_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _repository;

  ProductBloc(this._repository) : super(const ProductState()) {
    on<ProductLoad>(_onProductLoad);
  }

  Future<void> _onProductLoad(
    ProductLoad event,
    Emitter<ProductState> emit,
  ) async {
    if (event.isRefresh) {
      emit(state.copyWith(
        products: [],
        isLoading: true,
        currentPage: 1,
      ));
    } else if (event.page > 1) {
      emit(state.copyWith(isPageLoading: true));
    } else {
      emit(state.copyWith(isLoading: true));
    }

    final result = await _repository.getProductList(
      page: event.page,
      perPage: event.perPage,
    );

    result.fold(
      (l) {
        log('LLLLLLLLL::::::::$l');
        emit(
          state.copyWith(
            isLoading: false,
            isPageLoading: false,
            hasMore: false,
          ),
        );
      },
      (r) {
        log('RRRRRRRRR::::::::$r');
        final incoming = r.products ?? <ProductModel>[];

        final List<ProductModel> newProducts =
            (event.isRefresh || event.page == 1) ? incoming : [...state.products, ...incoming];

        emit(
          state.copyWith(
            products: newProducts,
            isLoading: false,
            isPageLoading: false,
            currentPage: event.page,
            hasMore: (r.products?.length ?? 0) == event.perPage,
          ),
        );
      },
    );
  }
}
