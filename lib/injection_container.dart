import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/core/network/network_info.dart';
import 'features/core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

final sl = GetIt.instance; //Service Locator (sl)
//register under the type get instantiate for us
// example: sl() --- required InputConverter inputConverter
//Difference between factory and singleton is factory obviously always
// instantiate a new instance of that given class whenever we request it is
// so for example from within our first UI widget number trivia page REQUEST get
// it an instance a number trivia block if we registered as a factory we re
// always going obtain a new instance every call to get it however when
// use register something either as a lazy singleton or as a regular singleton
//get it will cash it then get it same instance.
///Classes requiring clean up (such as Bloc) shouldn't be registered as
///singletons.
Future<void> init() async {
  //Bloc
  sl
    ..registerFactory(
      () => NumberTriviaBloc(
        inputConverter: sl(),
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
      ),
    )
    //Use cases
    ..registerLazySingleton(() => GetConcreteNumberTrivia(sl()))
    ..registerLazySingleton(() => GetRandomNumberTrivia(sl()))
    //Repository
    ..registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    // Data Sources
    ..registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()),
    )
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    //! Core
    ..registerLazySingleton(InputConverter.new);
  //! External Libraries
  //We can not instantiniate cuz have no default constructor the way to get
  // instance shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  //must do that because it is Future
  sl
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    //http
    ..registerLazySingleton(http.Client.new)
    // internet connection checker
    ..registerLazySingleton(InternetConnection.new);
}

//Lazy singleton is registered only when is requested as a
// dependency for some other class
//Singleton always registered immediately after app starts

/*// ! Features - SettingsBloc
  //Bloc
  sl
    ..registerFactory(
          () => SettingsBloc(
        inputConverter: sl(),
        getConcreteNumberTrivia: sl(),
        getRandomNumberTrivia: sl(),
      ),
    )*/
// ! Features - NumberTrivia
