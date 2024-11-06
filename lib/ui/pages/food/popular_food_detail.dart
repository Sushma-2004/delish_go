import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/data/data_models/product_model.dart';
import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/pages/home/home_page.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:delish_go/ui/reusable_widgets/app_column.dart';
import 'package:delish_go/ui/reusable_widgets/app_icon.dart';
import 'package:delish_go/ui/reusable_widgets/big_text.dart';
import 'package:delish_go/ui/reusable_widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';

class PopularFoodDetail extends StatefulWidget {
  const PopularFoodDetail({super.key, required this.product});
  final ProductModel product;

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  double quantity = 0;
  CartProductModel? cartProduct;
  final TextEditingController priceTextController = TextEditingController();
  final TextEditingController quantityTextController =
      TextEditingController(text: "0");
  final TextEditingController sumTotal = TextEditingController();

  void navigateToMainFoodPageDetail() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  // void navigateToCartPageDetail() {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => CartPage()));
  // }

  void quantityIncrement() {
    var currentQuantity = int.parse(quantityTextController.value.text);
    currentQuantity += 1;
    quantityTextController.text = currentQuantity.toString();
    double pricePerUnit = double.tryParse(priceTextController.text) ?? 0;
    double newTotal = pricePerUnit * currentQuantity;
    sumTotal.text = newTotal.toStringAsFixed(2);
    setState(() {});
    Locator.cartManagementService.updateCart(CartProductModel(
      product: widget.product,
      quantity: currentQuantity,
      price: pricePerUnit,
    ));
  }

  void quantityDecrement() {
    var currentQuantity = int.parse(quantityTextController.value.text);
    if (currentQuantity > 0) {
      currentQuantity -= 1;
      quantityTextController.text = currentQuantity.toString();
      double pricePerUnit = double.tryParse(priceTextController.text) ?? 0;
      double newTotal = pricePerUnit * currentQuantity;
      sumTotal.text = newTotal.toStringAsFixed(2);
      setState(() {});
      Locator.cartManagementService.updateCart(CartProductModel(
        product: widget.product,
        quantity: currentQuantity,
        price: pricePerUnit,
      ));
    }
  }

  void setQuantity(String value) {}

  void setInitialValues() {
    cartProduct =
        Locator.cartManagementService.getCartProductFromCart(widget.product);
    if (cartProduct != null) {
      quantityTextController.text = cartProduct!.quantity.toString();
      priceTextController.text = widget.product.price.toString();
      double? price = double.tryParse(priceTextController.text) ?? 0;
      quantity = double.tryParse(quantityTextController.text) ?? 0;
      double results = price * quantity;
      sumTotal.text = results.toStringAsFixed(1);

      setState(() {});
    } else {
      quantityTextController.text = "0";
      priceTextController.text = widget.product.price.toString();
      double? price = double.tryParse(priceTextController.text) ?? 0;
      quantity = 0;
      double results = price * quantity;
      sumTotal.text = results.toStringAsFixed(1);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    quantityTextController.addListener(() {
      double? price = double.tryParse(priceTextController.text) ?? 0;
      int? quantity = int.tryParse(quantityTextController.text);
      if (quantity != null) {
        double results = price * quantity;
        sumTotal.text = results.toStringAsFixed(1);

        Locator.cartManagementService.updateCart(CartProductModel(
          product: widget.product,
          quantity: int.parse(quantityTextController.value.text),
          price: double.tryParse(priceTextController.value.text) ?? 0,
        ));
      }
    });

    priceTextController.addListener(() {
      double? price = double.tryParse(priceTextController.text);
      double quantity = double.tryParse(quantityTextController.text) ?? 0;

      if (price != null) {
        double results = price * quantity;
        sumTotal.text = results.toStringAsFixed(1);
      }

      Locator.cartManagementService.updateCart(CartProductModel(
        product: widget.product,
        quantity: int.parse(quantityTextController.value.text),
        price: double.parse(priceTextController.value.text),
      ));
    });
  }

  @override
  void dispose() {
    priceTextController.dispose();
    quantityTextController.dispose();
    sumTotal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setInitialValues();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                child:(widget.product.img != "")
                            ? ClipRRect(
                                child: Image.network(
                                  widget.product.img,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : const ClipRRect(// Match the Container border radius
                                child: Image(
                                  image:
                                      AssetImage("asset/images/NO_PRODUCT.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),       
              )),
          //icon widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => navigateToMainFoodPageDetail(),
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  // GestureDetector(
                  //   onTap: navigateToCartPageDetail,
                  //   child: AppIcon(icon: Icons.shopping_cart_outlined))
                ],
              )),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(
                      text: widget.product.name,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                          text: widget.product.description,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: quantityDecrement,
                      child: Icon(Icons.remove, color: AppColors.signColor)),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: Dimensions.height45,
                    width: Dimensions.width45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: quantityTextController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.mainColor
                      ),
                      onChanged: (value) {
                        setQuantity(value);
                      },
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  GestureDetector(
                      onTap: quantityIncrement,
                      child: Icon(Icons.add, color: AppColors.signColor)),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: BigText(
                  text: "Rs. ${widget.product.price}",
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
