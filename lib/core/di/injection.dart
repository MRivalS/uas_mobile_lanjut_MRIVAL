import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../config/env_config.dart';
import '../database/isar_service.dart';
import '../../features/home/data/repositories/news_repository.dart';
import '../../features/home/presentation/cubit/news_cubit.dart'; 

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<IsarService>(() => IsarService());

  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: EnvConfig.baseUrl));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepository(locator<Dio>(), locator<IsarService>()),
  );

  // 🔥 2. TAMBAHKAN REGISTRASI NEWS_CUBIT DI SINI
  locator.registerFactory<NewsCubit>(
    () => NewsCubit(locator<NewsRepository>()),
  );
}