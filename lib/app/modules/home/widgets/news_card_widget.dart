import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/model/news_model.dart';
import 'package:newsapp/app/modules/detail/views/detail_view.dart';
import 'package:shimmer/shimmer.dart';

class NewsCardWidget extends StatelessWidget {
  final Articles article;

  const NewsCardWidget({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => DetailPage(article: article)),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: article.urlToImage != null
                ? Image.network(
                    article.urlToImage!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.blueAccent,
                        child:
                            const Icon(Icons.broken_image, color: Colors.white),
                      );
                    },
                  )
                : Container(
                    width: 60,
                    height: 60,
                    color: Colors.blueAccent,
                    child: const Icon(Icons.article, color: Colors.white),
                  ),
          ),
          title: Text(article.title ?? "No Title",
              style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(
            article.description ?? "No Description",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
