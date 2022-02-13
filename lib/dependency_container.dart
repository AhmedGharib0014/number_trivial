import 'package:get_it/get_it.dart';
import 'package:number_trivial/core/network/networkInfo.dart';
import 'package:number_trivial/core/utils/input_converter.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/locae_number_trivial_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/datasources/remote_data_source_data_source.dart';
import 'package:number_trivial/features/numbertrivial/data/repositories/number_trevial_repo_impl.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get-random_trivial.dart';
import 'package:number_trivial/features/numbertrivial/domain/usescases/get_concrete_number_trivial.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/bloc/bloc/numbertrivial_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/numbertrivial/domain/repositories/number_trivial_repository.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  // register features
  getIt.registerLazySingletonAsync(() => SharedPreferences.getInstance());

  //bloc
  getIt.registerFactory(() => NumbertrivialBloc(
        getConcreteNumberTrivial: getIt(),
        inputConverter: getIt(),
        getRandomTrivialUseCase: getIt(),
      ));

  // use case
  getIt.registerLazySingleton(() => GetConcreteNumberTrivialUseCase(getIt()));
  getIt.registerLazySingleton(() => GetRandomTrivialUseCase(getIt()));

  // repos
  getIt.registerLazySingleton<NumberTrevialRepository>(() =>
      NumberTrivialRepositpryImplemantation(
          remoteDateSource: getIt(),
          localDateSource: getIt(),
          netWorkInfo: getIt()));

  // register datasources
  getIt.registerLazySingleton<RemoteDateSource>(
      () => RemoteDateSourceImple(getIt()));
  getIt.registerLazySingleton<LocalDateSource>(
      () => LocalNumberTrivialDataSourceImple(getIt()));

  // register core
  getIt.registerLazySingleton(() => InputConverter());
  getIt.registerLazySingleton<NetWorkInfo>(() => NetworkInfoImple());

  // register extrnal
  getIt.registerLazySingleton(() => http.Client());
}
