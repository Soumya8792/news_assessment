import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/auth/controller/auth_controller.dart';
import 'package:newsapp/app/utils/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WellcomeScreen extends StatelessWidget {
  WellcomeScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final PageController pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {"image": "assets/images/reading.png", "text": "Discover Latest News"},
    {"image": "assets/images/boy.png", "text": "Stay Informed Daily"},
    {"image": "assets/images/man.png", "text": "Trusted Sources Only"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: onboardingData.length,
                  onPageChanged: controller.changePage,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(onboardingData[index]["image"]!,
                            height: 400),
                        SizedBox(height: 20),
                        Text(
                          onboardingData[index]["text"]!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(onboardingData.length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 10,
                        width: controller.currentPage.value == index ? 30 : 10,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index
                              ? AppColors.primary
                              : AppColors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  )),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Obx(() => ElevatedButton(
                        onPressed: () {
                          if (controller.currentPage.value ==
                              onboardingData.length - 1) {
                            controller.navigateToLogin();
                          } else {
                            controller.nextPage(
                                onboardingData.length, pageController);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.background,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          controller.currentPage.value ==
                                  onboardingData.length - 1
                              ? "Get Started"
                              : "Next",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )),
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Obx(
                () => controller.currentPage.value == onboardingData.length - 1
                    ? SizedBox.shrink()
                    : TextButton(
                        onPressed: () {
                          pageController.jumpToPage(onboardingData.length - 1);
                        },
                        child: Text("Skip",
                            style: TextStyle(
                                fontSize: 16.sp, color: AppColors.primary)),
                      )),
          ),
        ],
      ),
    );
  }
}
