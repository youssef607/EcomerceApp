import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:heleapp/app/app_prefs.dart';
import 'package:heleapp/data/data_source/remote_data_source.dart';
import 'package:heleapp/data/network/app_api.dart';
import 'package:heleapp/data/network/dio_factory.dart';
import 'package:heleapp/data/network/network_info.dart';
import 'package:heleapp/data/repository/repository_impl.dart';
import 'package:heleapp/domain/repository/repository.dart';
import 'package:heleapp/domain/usecase/login_usecase.dart';
import 'package:heleapp/presentation/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;
Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  //shared prefs instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

//app prefs instance
  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));

  //NetworkInfo
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  //dio factory

  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  //App service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDateSource>(
      () => RemoteDataSourceImplementer(instance()));

  //repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImp(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
