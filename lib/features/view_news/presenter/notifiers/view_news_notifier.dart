import 'package:comet_news/core/widgets/snackbar.dart';
import 'package:comet_news/features/view_news/domain/entities/news_info.dart';
import 'package:comet_news/features/view_news/domain/usecases/get_news_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewNewsNotifier extends ChangeNotifier {
  final GetNewsUsecase getNewsUsecase = GetNewsUsecase();

  bool _isLoading = false;
  bool _isMoreLoading = false;
  bool _isSearched = false;
  String _searchText = '';
  List<NewsInfo> _newsInfos = [];
  List<NewsInfo> _searchedNewsInofs = [];
  bool get isLoading => _isLoading;
  bool get isMoreLoading => _isMoreLoading;
  bool get isSearched => _isSearched;
  String get searchText => _searchText;
  List<NewsInfo> get newsInfos => _newsInfos;
  List<NewsInfo> get searchedNewsInofs => _searchedNewsInofs;

  int _pageIndex = 2;
  int _searchedPageIndex = 2;

  void getInitialNews(BuildContext context) async {
    _isLoading = true;

    final String url = 'https://newsapi.org/v2/top-headlines?country=in';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _newsInfos = r;
      });

    _isLoading = false;
    notifyListeners();
  }

  void getRefreshedNews(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final String url = 'https://newsapi.org/v2/top-headlines?country=in';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _newsInfos = r;
      });

    _isLoading = false;
    notifyListeners();
  }

  void getMoreNews(BuildContext context) async {
    _isMoreLoading = true;
    notifyListeners();

    final String url =
        'https://newsapi.org/v2/top-headlines?country=in&page=$_pageIndex';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        final List<NewsInfo> news = r;
        if (news.length > 0) {
          _pageIndex++;
          for (int i = 0; i < news.length; i++) _newsInfos.add(news[i]);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: 'No more news to load'));
        }
      });

    _isMoreLoading = false;
    notifyListeners();
  }

  void getSearchedNews(BuildContext context, String searchText) async {
    _searchText = searchText;

    _isLoading = true;
    notifyListeners();

    final String url = 'https://newsapi.org/v2/everything?q=$_searchText';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        final List<NewsInfo> news = r;
        if (news.length > 0) {
          _searchedNewsInofs = r;
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: 'No more news to load'));
        }
      });

    _isLoading = false;
    notifyListeners();
  }

  void getRefreshedSearchedNews(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final String url = 'https://newsapi.org/v2/everything?q=$_searchText';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        _searchedNewsInofs = r;
      });

    _isLoading = false;
    notifyListeners();
  }

  void getMoreSearchedNews(BuildContext context) async {
    _isMoreLoading = true;
    notifyListeners();

    final String url =
        'https://newsapi.org/v2/everything?q=$_searchText%$_searchedPageIndex';
    await getNewsUsecase(url)
      ..fold((l) {
        ScaffoldMessenger.of(context)
            .showSnackBar(Snackbar(message: l.message));
      }, (r) {
        final List<NewsInfo> news = r;
        if (news.length > 0) {
          for (int i = 0; i < news.length; i++) _searchedNewsInofs.add(news[i]);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(Snackbar(message: 'No more news to load'));
        }
      });

    _isMoreLoading = false;
    notifyListeners();
  }

  void emptySearchedNews() {
    _searchedNewsInofs = [];
    notifyListeners();
  }

  void changeSearchedState(bool isSearched) {
    _isSearched = isSearched;
    notifyListeners();
  }
}
