// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pretty_dio_logger/pretty_dio_logger.dart' as _i528;

import '../../api/api_manager.dart' as _i149;
import '../../api/data/data_sources/remote/auth/auth_remote_data_source_impl.dart'
    as _i1051;
import '../../api/dio/dio_interceptors.dart' as _i577;
import '../../api/dio/get_it_module.dart' as _i814;
import '../../data/data_sources/remote/auth/auth_remote_data_source.dart'
    as _i202;
import '../../data/data_sources/remote/home/home_remote_data_source.dart'
    as _i973;
import '../../data/repository/auth/auth_repository_impl.dart' as _i392;
import '../../data/repository/home/home_repository_impl.dart' as _i605;
import '../../domain/repository/auth/auth_repository.dart' as _i912;
import '../../domain/repository/home/home_repository.dart' as _i839;
import '../../domain/use_cases/home/home_use_cases.dart' as _i36;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../Features/UI/auth/Login/cubit/cubit.dart' as _i969;
import '../../Features/UI/auth/register_screen/cubit/register_cubit.dart'
    as _i831;
import '../../Features/UI/home/cubit/home_cubit.dart' as _i795;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final getItModule = _$GetItModule();
    gh.singleton<_i361.BaseOptions>(() => getItModule.provideBaseOptions);
    gh.singleton<_i528.PrettyDioLogger>(
      () => getItModule.providePrettyDioLogger,
    );
    gh.singleton<_i577.DioInterceptors>(
      () => getItModule.provideDioInterceptors,
    );
    gh.singleton<_i361.Dio>(
      () => getItModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i528.PrettyDioLogger>(),
        gh<_i577.DioInterceptors>(),
      ),
    );
    gh.singleton<_i149.ApiManager>(
      () => getItModule.provideApiManager(gh<_i361.Dio>()),
    );
    gh.factory<_i202.AuthRemoteDataSource>(
      () => _i1051.AuthRemoteDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i973.HomeRemoteDataSource>(
      () => _i973.HomeRemoteDataSourceImpl(gh<_i149.ApiManager>()),
    );
    gh.factory<_i912.AuthRepository>(
      () => _i392.AuthRepositoryImpl(gh<_i202.AuthRemoteDataSource>()),
    );
    gh.factory<_i471.LoginUseCase>(
      () => _i471.LoginUseCase(gh<_i912.AuthRepository>()),
    );
    gh.factory<_i479.RegisterUseCase>(
      () => _i479.RegisterUseCase(gh<_i912.AuthRepository>()),
    );
    gh.factory<_i839.HomeRepository>(
      () => _i605.HomeRepositoryImpl(gh<_i973.HomeRemoteDataSource>()),
    );
    gh.factory<_i831.RegisterCubit>(
      () => _i831.RegisterCubit(gh<_i479.RegisterUseCase>()),
    );
    gh.factory<_i36.GetCategoriesUseCase>(
      () => _i36.GetCategoriesUseCase(gh<_i839.HomeRepository>()),
    );
    gh.factory<_i36.GetProductsUseCase>(
      () => _i36.GetProductsUseCase(gh<_i839.HomeRepository>()),
    );
    gh.factory<_i969.LoginCubit>(
      () => _i969.LoginCubit(gh<_i471.LoginUseCase>()),
    );
    gh.factory<_i795.HomeCubit>(
      () => _i795.HomeCubit(
        gh<_i36.GetCategoriesUseCase>(),
        gh<_i36.GetProductsUseCase>(),
      ),
    );
    return this;
  }
}

class _$GetItModule extends _i814.GetItModule {}
