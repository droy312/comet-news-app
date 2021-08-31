import 'package:comet_news/core/constants/strings.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';

class NewsInfoModel extends NewsInfo {
  NewsInfoModel({
    required String title,
    String? author,
    required String url,
    String? imageUrl,
    required String content,
    required String dateTime,
  }) : super(
          title: title,
          author: author,
          url: url,
          imageUrl: imageUrl,
          content: content,
          dateTime: DateTime.parse(dateTime).toLocal(),
        );

  factory NewsInfoModel.fromMap(Map<String, dynamic> map) {
    return NewsInfoModel(
      title: map[Strings.titleKey].toString(),
      author: map[Strings.authorKey] != null
          ? map[Strings.authorKey].toString()
          : null,
      url: map[Strings.urlKey].toString(),
      imageUrl: map[Strings.imageUrlKey] != null
          ? map[Strings.imageUrlKey].toString()
          : null,
      content: map[Strings.contentKey].toString(),
      dateTime: map[Strings.dateTimeKey] != null
          ? map[Strings.dateTimeKey].toString()
          : DateTime.now().toString(),
    );
  }
}
