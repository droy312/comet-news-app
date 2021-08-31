import 'package:comet_news/core/errors/exception.dart';
import 'package:comet_news/core/service_locator.dart';
import 'package:comet_news/features/view_news/data/data_sources/remote_data_source.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:comet_news/core/errors/failure.dart';
import 'package:comet_news/features/view_news/domain/repositories/view_news_repo.dart';
import 'package:dartz/dartz.dart';

class ViewNewsRepoImpl extends ViewNewsRepo {
  final RemoteDateSource remoteDateSource = sl<RemoteDateSource>();

  @override
  Future<Either<Failure, List<NewsInfo>>> getNews(String url) async {
    try {
      return Right(await remoteDateSource.getNews(url));
    } on GetException catch (e) {
      return Left(GetFailure(message: e.message));
    }
  }
}