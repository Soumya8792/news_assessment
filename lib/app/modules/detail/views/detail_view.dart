import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/news_model.dart';

class DetailPage extends StatelessWidget {
  final Articles article;

  const DetailPage({Key? key, required this.article}) : super(key: key);

  String formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat.yMMMMd().add_jm().format(dateTime.toLocal());
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          article.source?.name ?? 'News Detail',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.urlToImage!,
                  height: 25.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 2.h),
            Text(
              article.title ?? 'No Title',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                if (article.author != null)
                  Text(
                    "By ${article.author}",
                    style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                  ),
                const Spacer(),
                if (article.publishedAt != null)
                  Text(
                    formatDate(article.publishedAt!),
                    style: TextStyle(fontSize: 14.sp, color: Colors.black45),
                  ),
              ],
            ),
            Divider(height: 4.h, color: Colors.grey.shade300),
            if (article.description != null && article.description!.isNotEmpty)
              Text(
                article.description!,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            if (article.description != null) SizedBox(height: 2.h),
            if (article.content != null && article.content!.isNotEmpty)
              Text(
                article.content!,
                style: TextStyle(fontSize: 15.sp, color: Colors.black87),
              ),
            SizedBox(height: 4.h),
            if (article.url != null)
              Center(
                child: TextButton(
                  onPressed: () async {
                    final url = article.url;
                    if (url != null) {
                      final uri = Uri.parse(url);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Could not launch the article URL')),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Read Full Article',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
