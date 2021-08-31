import 'package:comet_news/core/services/news_api_service.dart';
import 'package:comet_news/features/view_news/data/data_sources/remote_data_source.dart';
import 'package:comet_news/features/view_news/data/repositories/view_news_repo_impl.dart';
import 'package:comet_news/features/view_news/domain/repositories/view_news_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

void setUpServices() {
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<NewsApiService>(NewsApiServiceImpl());
  sl.registerSingleton<RemoteDateSource>(RemoteDateSourceImpl());
  sl.registerSingleton<ViewNewsRepo>(ViewNewsRepoImpl());
}