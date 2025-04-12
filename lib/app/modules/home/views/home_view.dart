import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/auth/controller/auth_controller.dart';
import 'package:newsapp/app/modules/detail/views/detail_view.dart';
import 'package:newsapp/app/modules/home/controllers/home_controller.dart';
import 'package:newsapp/app/modules/home/widgets/empty_result_widget.dart';
import 'package:newsapp/app/modules/home/widgets/error_text_widget.dart';
import 'package:newsapp/app/modules/home/widgets/loading_widget.dart';
import 'package:newsapp/app/modules/home/widgets/news_card_widget.dart';
import 'package:newsapp/app/modules/home/widgets/search_bar_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../model/news_model.dart';
import '../../../utils/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  final AuthController auth = Get.put(AuthController());
  final ScrollController scrollController = ScrollController();

  RxList<Articles> filteredArticles = <Articles>[].obs;

  @override
  void initState() {
    super.initState();
    controller.fetchNews(initialLoad: true);

    controller.searchController.addListener(() {
      final query = controller.searchController.text.toLowerCase();
      if (query.isEmpty) {
        filteredArticles.assignAll(controller.articles);
      } else {
        filteredArticles.assignAll(controller.articles.where((article) {
          return article.title?.toLowerCase().contains(query) ?? false;
        }));
      }
    });

    ever(controller.articles, (_) {
      filteredArticles.assignAll(controller.articles);
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.fetchNews();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "News",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
        ),
        drawer: const DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const LoadingWidget();
            } else if (controller.error.isNotEmpty) {
              return ErrorTextWidget(error: controller.error.value);
            }

            return Column(
              children: [
                SearchBarWidget(controller: controller),
                const SizedBox(height: 20),
                Expanded(
                  child: filteredArticles.isEmpty
                      ? const EmptyResultWidget()
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: filteredArticles.length +
                              (controller.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == filteredArticles.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              );
                            }
                            final article = filteredArticles[index];
                            return NewsCardWidget(article: article);
                          },
                        ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
