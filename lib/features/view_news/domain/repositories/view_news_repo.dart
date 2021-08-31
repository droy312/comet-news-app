import 'package:comet_news/core/errors/failure.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:dartz/dartz.dart';

abstract class ViewNewsRepo {
  Future<Either<Failure, List<NewsInfo>>> getNews(String url);
}