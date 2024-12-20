import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/logic/data_management_service/product_management_service.dart';
import 'package:delish_go/ui/pages/food/popular_food_detail.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:delish_go/ui/reusable_widgets/big_text.dart';
import 'package:delish_go/ui/reusable_widgets/icon_and_text_widget.dart';
import 'package:delish_go/ui/reusable_widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class FoodPageBody extends StatelessWidget with WatchItMixin {
  FoodPageBody({super.key});

  PageController pageController = PageController(viewportFraction: 0.85);

  // @override
  @override
  Widget build(BuildContext context) {
    void navigateToPopularFoodDetail(ProductModel product) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PopularFoodDetail(product: product)));
    }

    var productListToDisplay =
        watchValue((ProductManagementService x) => x.productsToDisplay);

    return Column(
      children: [
        // slider section
        // Container(
        //     //color: Colors.redAccent,
        //     height: Dimensions.pageView,
        //     child: PageView.builder(
        //         controller: pageController,
        //         itemCount:5,
        //         itemBuilder: (context, position) {
        //           return _buildPageItem(position);
        //         })),
        // dots
        // DotsIndicator(
        //   dotsCount: 5,
        //   position: _currPageValue,
        //   decorator: DotsDecorator(
        //       activeColor: AppColors.mainColor,
        //       size: const Size.square(9.0),
        //       activeSize: const Size(18.0, 9.0),
        //       activeShape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(Dimensions.radius20))),
        // ),
        //popular text
        // SizedBox(
        //   height: Dimensions.height30,
        // ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Popular"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Food pairing",
                ),
              )
            ],
          ),
        ),
        //list of food and images
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              final product = productListToDisplay[index];
              return GestureDetector(
                onTap: () => navigateToPopularFoodDetail(product),
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height10,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      //image section
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                        ),
                        child: (product.img != "")
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.network(
                                  product.img,
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    14), 
                                child: const Image(
                                  image:
                                      AssetImage("asset/images/NO_PRODUCT.png"),
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                      //text section
                      Expanded(
                          child: Container(
                        height: Dimensions.listViewTextContSize,
                        margin: EdgeInsets.only(),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius20),
                              bottomRight: Radius.circular(Dimensions.radius20),
                            ),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: product.name),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              SmallText(text: "With chinese characteristics"),
                              SizedBox(
                                height: Dimensions.height10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndTextWidget(
                                        icon: Icons.circle_sharp,
                                        text: "Normal",
                                        iconColor: AppColors.iconColor1),
                                    IconAndTextWidget(
                                        icon: Icons.location_on,
                                        text: "1.7km",
                                        iconColor: AppColors.mainColor),
                                    IconAndTextWidget(
                                        icon: Icons.access_time_filled_rounded,
                                        text: "32min",
                                        iconColor: AppColors.iconColor2),
                                  ])
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  // Widget _buildPageItem(int index) {
  //   Matrix4 matrix = Matrix4.identity();
  //   if (index == _currPageValue.floor()) {
  //     var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
  //     var currTrans = _height * (1 - currScale) / 2;
  //     matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //       ..setTranslationRaw(0, currTrans, 0);
  //   } else if (index == _currPageValue.floor() + 1) {
  //     var currScale =
  //         _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
  //     var currTrans = _height * (1 - currScale) / 2;
  //     matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //       ..setTranslationRaw(0, currTrans, 0);
  //   } else if (index == _currPageValue.floor() - 1) {
  //     var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
  //     var currTrans = _height * (1 - currScale) / 2;
  //     matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //       ..setTranslationRaw(0, currTrans, 0);
  //   } else {
  //     var currScale = 0.8;
  //     matrix = Matrix4.diagonal3Values(1, currScale, 1)
  //       ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
  //   }

  //   return Transform(
  //     transform: matrix,
  //     child: Stack(children: [
  //       Container(
  //           height: Dimensions.pageViewContainer,
  //           margin: EdgeInsets.only(
  //               left: Dimensions.width10, right: Dimensions.width10),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(Dimensions.radius30),
  //               color: index.isEven
  //                   ? const Color(0xFF69c5df)
  //                   : const Color(0xFF9294cc),
  //               image: const DecorationImage(
  //                   fit: BoxFit.cover,
  //                   image: AssetImage("assets/image/food1.png")))),
  //       Align(
  //         alignment: Alignment.bottomCenter,
  //         child: Container(
  //           height: Dimensions.pageViewTextContainer,
  //           margin: EdgeInsets.only(
  //               left: Dimensions.width30,
  //               right: Dimensions.width30,
  //               bottom: Dimensions.height30),
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(Dimensions.radius20),
  //               color: Colors.white,
  //               boxShadow: const [
  //                 BoxShadow(
  //                     color: Color(0xFFe8e8e8),
  //                     blurRadius: 5.0,
  //                     offset: Offset(0, 5)),
  //                 BoxShadow(
  //                     color: Color(0xFFe8e8e8),
  //                     blurRadius: 5.0,
  //                     offset: Offset(5, 0)),
  //               ]),
  //           child: Container(
  //             padding: EdgeInsets.only(
  //                 top: Dimensions.height10,
  //                 left: Dimensions.width15,
  //                 right: Dimensions.width15,),
  //             child: AppColumn(text: "Chinese Side",)
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }
}
