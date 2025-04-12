import 'package:flutter/material.dart';
import 'package:newsapp/app/modules/home/controllers/home_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final HomeController controller;

  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: TextField(
        controller: controller.searchController,
        readOnly: !controller.isSearchEditable,
        onTap: () {
          controller.isSearchEditable = true;
          Future.delayed(const Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(controller.searchFocusNode);
          });
        },
        focusNode: controller.searchFocusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Search news...",
          icon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
