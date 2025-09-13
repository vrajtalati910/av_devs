import 'package:av_devs/core/utils/pagination/pagination_mixin.dart';
import 'package:av_devs/product/bloc/product_bloc.dart';
import 'package:av_devs/product/bloc/product_event.dart';
import 'package:av_devs/product/bloc/product_state.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:av_devs/product/view/product_detail_page.dart';
import 'package:av_devs/product/widget/product_widget.dart';
import 'package:av_devs/widget/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({super.key});

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> with PaginationMixin<ProductsListPage> {
  final int _perPage = 10;

  @override
  void initState() {
    super.initState();
    initiatePagination();
    // load first page
    context.read<ProductBloc>().add(
          ProductLoad(page: 1, perPage: _perPage),
        );
  }

  @override
  void dispose() {
    disposePagination();
    super.dispose();
  }

  @override
  void onReachedLast() {
    final state = context.read<ProductBloc>().state;
    if (!state.isPageLoading && state.hasMore) {
      context.read<ProductBloc>().add(
            ProductLoad(
              page: state.currentPage + 1,
              perPage: _perPage,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Products",
        // centerTitle: true,
        actions: [],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading && state.products.isEmpty) {
            // first time loading
            return GridView.builder(
              controller: scrollPaginationController,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 8,
                childAspectRatio: 0.90,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ProductWidget(
                  product: ProductModel(),
                  isLoading: true,
                  onTap: () {},
                );
              },
            );
          }

          if (state.products.isEmpty) {
            return const Center(child: Text("No products found"));
          }

          final itemCount = state.isPageLoading ? state.products.length + 1 : state.products.length;

          return GridView.builder(
            controller: scrollPaginationController,
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 8,
              childAspectRatio: 0.90,
            ),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index >= state.products.length) {
                // pagination loader
                return ProductWidget(
                  product: ProductModel(),
                  isLoading: true,
                  onTap: () {},
                );
              }
              final product = state.products[index];
              return ProductWidget(
                product: product, // adjust according to ProductWidget props
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      product: product,
                    ),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
