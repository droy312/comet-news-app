import 'package:comet_news/core/constants/nums.dart';
import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/core/utils/news_page_util.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  static const String routeName = '/news_page';

  final NewsInfo newsInfo;
  const NewsPage({Key? key, required this.newsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String content = newsInfo.content;
    if (content.compareTo('null') == 0)
      content = 'There is no content in this page';

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        elevation: 0,
        leading: IconButton(
          splashRadius: 0.1,
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 20,
            color: Palette.deepBlue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: Nums.horizontalPadding,
          right: Nums.horizontalPadding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 16),
              Text(
                newsInfo.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Palette.deepBlue,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: NewsPageUtil.getMonthDayYear(newsInfo.dateTime),
                      style: TextStyle(
                        color: Palette.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    newsInfo.author != null
                        ? TextSpan(
                            text: ' by ',
                            style: TextStyle(
                              color: Palette.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const TextSpan(),
                    newsInfo.author != null
                        ? TextSpan(
                            text: '${newsInfo.author!}',
                            style: TextStyle(
                              color: Palette.deepBlue,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const TextSpan(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width - 32,
                height: MediaQuery.of(context).size.width / 1.5,
                color: Palette.lightGrey,
                // alignment: Alignment.center,
                child: newsInfo.imageUrl != null ? Hero(
                  tag: newsInfo.imageUrl!,
                  child: Image.network(newsInfo.imageUrl!, fit: BoxFit.cover),
                ) : Center(child: Text('No image', style: TextStyle(color: Palette.deepBlue)))
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: TextStyle(
                  color: Palette.deepBlue,
                  fontSize: 14,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
