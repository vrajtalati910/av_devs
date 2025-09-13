import 'package:av_devs/bootstrap.dart';
import 'package:av_devs/core/local_storage/i_local_storage_repository.dart';
import 'package:av_devs/core/theme/app_assets.dart';
import 'package:av_devs/core/theme/app_color.dart';
import 'package:av_devs/core/utils/utility.dart';
import 'package:av_devs/injector/injector.dart';
import 'package:av_devs/product/model/product_model.dart';
import 'package:av_devs/product/view/product_list_page.dart';
import 'package:av_devs/product/widget/product_bottom_sheet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with RouteAware {
  List<ProductModel> cartDetail = [];
  int quantity = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    loadCart(); // Refresh cart and quantity
  }

  Future<void> loadCart() async {
    final cart = getIt<ILocalStorageRepository>().getCartProducts ?? [];
    setState(() {
      cartDetail = cart;
      final existingProduct = cart.firstWhere(
        (p) => p.id == widget.product.id,
        orElse: () => ProductModel(id: 0),
      );
      quantity = existingProduct.id != 0 ? existingProduct.qty ?? 0 : 0;
    });
  }

  Future<void> addToCart() async {
    final product = widget.product;
    final currentQty = quantity;

    if (product.stock != null && currentQty >= product.stock!) {
      Utility.toast(message: "Cannot add more, stock limit reached");

      return;
    }

    setState(() => quantity++);
    product.qty = quantity;

    await getIt<ILocalStorageRepository>().saveProduct(product);

    await loadCart();
  }

  Future<void> removeFromCart() async {
    if (quantity == 0) return;
    setState(() => quantity--);
    final product = widget.product;
    product.qty = quantity;

    await getIt<ILocalStorageRepository>().saveProduct(product); // save/update product in local storage
    await loadCart();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel with shadow & rounded corners
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    margin: const EdgeInsets.only(top: 42),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.whiteOffColor.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CarouselSlider(
                        items: product.images != null && product.images!.isNotEmpty
                            ? product.images!
                                .map((e) => Utility.imageLoader(
                                      borderRadius: BorderRadius.circular(0),
                                      url: e,
                                      placeholder: AppAssets.appLogo,
                                      fit: BoxFit.fitHeight,
                                    ))
                                .toList()
                            : [
                                Image.asset(
                                  AppAssets.appLogo,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              ],
                        options: CarouselOptions(
                          height: 300,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 70,
                  left: 16,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).maybePop().then((didPop) {
                        if (!didPop) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsListPage()),
                          );
                        }
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(4, 4, 6, 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.bgColor.withOpacity(0.5),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          AppAssets.leftArrowIcon,
                          color: AppColors.white,
                        )),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating
                  Text(
                    product.title ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: product.rating ?? 0.0,
                        itemBuilder: (context, index) => const Icon(Icons.star, color: AppColors.yellow),
                        itemCount: 5,
                        itemSize: 22.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${product.rating?.toStringAsFixed(1) ?? '0.0'} / 5',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    product.description ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Price Card

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ProductBottomSheet(
        product: product,
        cartDetail: cartDetail,
        quantity: quantity,
        addToCart: addToCart,
        removeFromCart: removeFromCart,
      ),
    );
  }
}
