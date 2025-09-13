// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:av_devs/core/local_storage/i_local_storage_repository.dart'
    as _i8;
import 'package:av_devs/core/utils/network/client.dart' as _i3;
import 'package:av_devs/core/utils/network/http_client.dart' as _i4;
import 'package:av_devs/injector/shared_preference_injectable_module.dart'
    as _i9;
import 'package:av_devs/product/bloc/product_bloc.dart' as _i6;
import 'package:av_devs/product/repository/i_product_repository.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPrefrenceInjectableModule = _$SharedPrefrenceInjectableModule();
    gh.factory<_i3.Client>(() => _i4.HttpClient());
    gh.factory<_i5.IProductRepository>(
        () => _i5.ProductRepository(gh<_i3.Client>()));
    gh.factory<_i6.ProductBloc>(
        () => _i6.ProductBloc(gh<_i5.IProductRepository>()));
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => sharedPrefrenceInjectableModule.prefs,
      preResolve: true,
    );
    gh.factory<_i8.ILocalStorageRepository>(
        () => _i8.LocalStorageRepository(gh<_i7.SharedPreferences>()));
    return this;
  }
}

class _$SharedPrefrenceInjectableModule
    extends _i9.SharedPrefrenceInjectableModule {}
