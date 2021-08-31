import 'package:comet_news/core/constants/nums.dart';
import 'package:comet_news/core/constants/palette.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:comet_news/features/view_news/presenter/notifiers/view_news_notifier.dart';
import 'package:comet_news/features/view_news/presenter/pages/components/news_card.dart';
import 'package:comet_news/features/view_news/presenter/pages/components/search_bar.dart';
import 'package:comet_news/features/view_news/presenter/pages/news_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home_page';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _title = 'COMET News';

  final TextEditingController _searchBarController = TextEditingController();

  Widget _loadMoreRefreshBtns(ViewNewsNotifier notifier) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              notifier.isSearched
                  ? context
                      .read<ViewNewsNotifier>()
                      .getMoreSearchedNews(context)
                  : context.read<ViewNewsNotifier>().getMoreNews(context);
            },
            child: Center(
              child: Container(
                // alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Palette.background,
                  border: Border.all(color: Palette.deepBlue, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
                child: Text(
                  'Load more',
                  style: TextStyle(
                    color: Palette.deepBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              notifier.isSearched
                  ? context
                      .read<ViewNewsNotifier>()
                      .getRefreshedSearchedNews(context)
                  : context.read<ViewNewsNotifier>().getRefreshedNews(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Palette.background,
                border: Border.all(color: Palette.deepBlue, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              child: Text(
                'Refresh',
                style: TextStyle(
                  color: Palette.deepBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _searchBarController.addListener(() {
      if (_searchBarController.text.isNotEmpty) {
        context.read<ViewNewsNotifier>().changeSearchedState(true);
      } else {
        context.read<ViewNewsNotifier>().changeSearchedState(false);
        context.read<ViewNewsNotifier>().emptySearchedNews();
      }
    });

    context.read<ViewNewsNotifier>().getInitialNews(context);
    // context.read<ViewNewsNotifier>().mockGetInitialNews();
  }

  @override
  void dispose() {
    _searchBarController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        elevation: 0,
        title: Text(
          _title,
          style: TextStyle(
            fontSize: 20,
            color: Palette.deepBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<ViewNewsNotifier>(
        builder: (_, notifier, __) {
          return notifier.isLoading
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Nums.horizontalPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      SearchBar(controller: _searchBarController),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Nums.horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      SearchBar(controller: _searchBarController),
                      const SizedBox(height: 16),
                      Text(
                        notifier.isSearched ? 'Searched news' : 'Top news',
                        style: TextStyle(
                          fontSize: 20,
                          // fontFamily: Strings.poppintsRegularFont,
                          color: Palette.deepBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.builder(
                          itemCount: (notifier.isSearched
                                  ? notifier.searchedNewsInofs.length
                                  : notifier.newsInfos.length) +
                              1,
                          itemBuilder: (context, index) {
                            final List<NewsInfo> newsInfos = notifier.isSearched
                                ? notifier.searchedNewsInofs
                                : notifier.newsInfos;

                            if (index == newsInfos.length) {
                              return notifier.isMoreLoading
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : _loadMoreRefreshBtns(notifier);
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    NewsPage.routeName,
                                    arguments: newsInfos[index],
                                  );
                                },
                                child: NewsCard(
                                  newsInfo: newsInfos[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

class ChipInfo {
  final int index;
  final String text;
  const ChipInfo({required this.index, required this.text});
}
