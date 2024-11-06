import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/pages/home/food_page_body.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:delish_go/ui/reusable_widgets/big_text.dart';
import 'package:delish_go/ui/reusable_widgets/small_text.dart';
import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //shows the header
          Container(
            margin: EdgeInsets.only(
                top: Dimensions.height45, bottom: Dimensions.height15),
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(
                        text: "India",
                        color: AppColors.mainColor,
                        size: Dimensions.font30),
                    Row(
                      children: [
                        SmallText(text: "Tamil Nadu", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: Dimensions.width45,
                      height: Dimensions.height45,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor,
                      ),
                      child: Icon(Icons.search,
                          color: Colors.white, size: Dimensions.icon24),
                    ),
                    SizedBox(
                        width: Dimensions
                            .width15), // Add space between search and logout buttons
                    GestureDetector(
                      onTap: Locator.userManagementService.signOut,
                      child: Container(
                        width: Dimensions.width45,
                        height: Dimensions.height45,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(Icons.logout,
                            color: Colors.white, size: Dimensions.icon24),
                      ),
                    )
                  ],
                )
              ],
            )),
          ),
          //shows the body
          Expanded(child: SingleChildScrollView(child: FoodPageBody())),
        ],
      ),
    );
  }
}
