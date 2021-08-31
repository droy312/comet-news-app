import 'package:comet_news/core/constants/nums.dart';
import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsInfo newsInfo;
  const NewsCard({Key? key, required this.newsInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Stack(
        children: [
          Container(
            height: 200,
            child: newsInfo.imageUrl != null
                ? Hero(
                    tag: newsInfo.imageUrl!,
                    child: Image.network(newsInfo.imageUrl!, fit: BoxFit.cover),
                  )
                : Container(color: Palette.lightGrey),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12),
              color: Colors.white,
              child: Text(
                newsInfo.title,
                style: TextStyle(
                    color: Palette.deepBlue,
                    fontSize: Nums.largeFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Regular'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
