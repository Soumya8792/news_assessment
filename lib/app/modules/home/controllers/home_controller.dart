import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../api_servises/home_api.dart';
import '../../../model/news_model.dart';

class HomeController extends GetxController {
  final HomeApiServise newsService = HomeApiServise();
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString error = ''.obs;
  bool isSearchEditable = false;

  Rx<NewsModel?> newsModel = Rx<NewsModel?>(null);
  RxList<Articles> articles = <Articles>[].obs;

  int currentPage = 1;
  final int pageSize = 20;
  bool hasMore = true;
  bool isFetchingMore = false;

  @override
  void onInit() {
    fetchNews(initialLoad: true);
    super.onInit();
  }

  Future<void> fetchNews({bool initialLoad = false}) async {
    if (isFetchingMore || !hasMore) return;

    if (initialLoad) {
      isLoading(true);
      currentPage = 1;
      articles.clear();
    } else {
      isFetchingMore = true;
    }

    try {
      final result = await newsService.fetchNews(
        page: currentPage,
        pageSize: pageSize,
      );

      if (result.articles == null || result.articles!.isEmpty) {
        hasMore = false;
      } else {
        articles.addAll(result.articles!);
        if (result.articles!.length < pageSize) {
          hasMore = false;
        } else {
          currentPage++;
        }
      }
    } catch (e) {
      error(e.toString());
    } finally {
      isLoading(false);
      isFetchingMore = false;
    }
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
}
