import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';

class CartProductTile extends StatelessWidget {
  const CartProductTile({Key? key, required this.cartProduct})
      : super(key: key);

  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    double desiredHeight = 400;
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double oneFourthScreenWidth = screenWidth / 4;
    double oneSixthScreenWidth = screenWidth / 6;

    final priceTextController = TextEditingController();
    final quantityTextController = TextEditingController();
    final totalTextController = TextEditingController();

    double price = cartProduct.price;
    num quantity = cartProduct.quantity;
    double total = price * quantity;

    priceTextController.text = price.toStringAsFixed(2);
    quantityTextController.text = quantity.toString();
    totalTextController.text = total.toStringAsFixed(2);

    return Container(
      height: desiredHeight,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Product Name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 5),
                child: Text(
                  cartProduct.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Padding(padding: EdgeInsets.only(left: 3)),
              GestureDetector(
                onTap: (() {
                  Locator.cartManagementService.removeCartProduct(cartProduct);
                }),
                child: Container(
                  width: 60,
                  height: 38,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: oneFourthScreenWidth,
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "PRICE",
                  style: TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
              SizedBox(
                width: oneSixthScreenWidth,
                child: const Text(
                  "TOTAL QUANTITY",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: AppColors.mainColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: oneFourthScreenWidth,
                alignment: Alignment.center,
                child: TextField(
                  controller: priceTextController,
                  readOnly: true,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    color: AppColors.mainColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(right: 10)),
              Expanded(
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.8),
                    border: Border.all(color: AppColors.mainColor),
                  ),
                  child: TextField(
                    controller: quantityTextController,
                    readOnly: true,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Open Sans SemiBold',
                      color: AppColors.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: oneFourthScreenWidth,
                padding: const EdgeInsets.only(left: 15),
                child: const Text(
                  "TOTAL",
                  style: TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainColor,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: oneFourthScreenWidth,
            alignment: Alignment.center,
            child: TextField(
              controller: totalTextController,
              readOnly: true,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mainColor),
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Open Sans SemiBold',
                color: AppColors.mainColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          Container(
            height: 1,
            color: AppColors.mainColor,
            margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
          )
        ],
      ),
    );
  }
}
