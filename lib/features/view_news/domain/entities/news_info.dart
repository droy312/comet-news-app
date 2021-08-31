import 'package:equatable/equatable.dart';

class NewsInfo extends Equatable {
  final String title;
  final String? author;
  final String url;
  final String? imageUrl;
  final String content;
  final DateTime dateTime;

  NewsInfo({
    required this.title,
    this.author,
    required this.url,
    this.imageUrl,
    required this.content,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [title, author, url, imageUrl, content, dateTime];
}
