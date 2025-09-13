import 'package:av_devs/bootstrap.dart';
import 'package:av_devs/core/constant/constants.dart';
import 'package:av_devs/injector/injector.dart';
import 'package:av_devs/product/bloc/product_bloc.dart';
import 'package:av_devs/product/view/product_list_page.dart';
import 'package:av_devs/view/app_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: MaterialApp(
        navigatorObservers: [routeObserver],
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: BlocProvider(
          create: (context) => getIt<ProductBloc>(),
          child: const ProductsListPage(),
        ),
      ),
    );
  }
}
