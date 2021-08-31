import 'package:comet_news/core/constants/strings.dart';
import 'package:comet_news/core/errors/exception.dart';
import 'package:comet_news/core/service_locator.dart';
import 'package:comet_news/core/services/news_api_service.dart';
import 'package:comet_news/features/view_news/data/models/news_info_model.dart';

abstract class RemoteDateSource {
  Future<List<NewsInfoModel>> getNews(String url);
}

class RemoteDateSourceImpl extends RemoteDateSource {
  final NewsApiService newsApiService = sl<NewsApiService>();

  List<NewsInfoModel> _newsMapsToModels(List<Map<String, dynamic>> newsMaps) {
    List<NewsInfoModel> newsInfoModels = [];
    for (int i = 0; i < newsMaps.length; i++) {
      newsInfoModels.add(NewsInfoModel.fromMap(newsMaps[i]));
    }
    return newsInfoModels;
  }
  List<Map<String, dynamic>> _newsDynamicsToMaps(List<dynamic> newsDynamics) {
    List<Map<String, dynamic>> newsMaps = [];
    for (int i = 0; i < newsDynamics.length; i++) {
      newsMaps.add(newsDynamics[i] as Map<String, dynamic>);
    } 
    return newsMaps;
  }

  @override
  Future<List<NewsInfoModel>> getNews(String url) async {
    final Map<String, dynamic> map = await newsApiService.getData(url);
    try {
      if (map[Strings.statusKey].toString().compareTo('ok') == 0) {
        final List<dynamic> newsDynamics = map[Strings.articlesKey];
        final List<Map<String, dynamic>> newsMaps = _newsDynamicsToMaps(newsDynamics);
        final List<NewsInfoModel> newsInfoModels = _newsMapsToModels(newsMaps);
        return newsInfoModels;
      } else {
        print('Error in [RemoteDateSource getNews]: ${map[Strings.codeKey]}');
        throw GetException(message: '${map[Strings.messageKey]}');
      }
    } catch (e) {
      print('Error in [RemoteDateSource getNews]: $e');
      throw GetException(message: e.toString());
    }
  }
}
