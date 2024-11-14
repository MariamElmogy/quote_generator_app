import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quote_app/core/utils/api_service.dart';
import 'package:quote_app/screens/home/data/repo/quote_repo_implement.dart';

final getIt = GetIt.instance;

void setUpServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<QuoteRepoImplement>(
    QuoteRepoImplement(getIt.get<ApiService>()),
  );
}
