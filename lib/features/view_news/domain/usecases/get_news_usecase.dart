import 'package:comet_news/core/errors/failure.dart';
import 'package:comet_news/core/service_locator.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:comet_news/features/view_news/domain/repositories/view_news_repo.dart';
import 'package:dartz/dartz.dart';

class GetNewsUsecase {
  final ViewNewsRepo viewNewsRepo = sl<ViewNewsRepo>();

  Future<Either<Failure, List<NewsInfo>>> call(String url) {
    return viewNewsRepo.getNews(url);
  }
}