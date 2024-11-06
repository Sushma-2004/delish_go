import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:flutter/material.dart';

class SalesView extends StatelessWidget {
  const SalesView({super.key, required this.saleModel});
  final SaleModel saleModel;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    double total = saleModel.cartProductList!.fold(0.0,
        (sum, cartProduct) => sum + (cartProduct.price * cartProduct.quantity));

    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0),
        ),
        backgroundColor: const Color(0xFF1F2128),
        contentPadding:
            const EdgeInsets.only(top: 7, bottom: 7, left: 7, right: 7),
        content: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 38),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 30),
                    child: const Text(
                      'VIEW ITEMS',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Open Sans SemiBold',
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.mainColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: screenWidth,
                height: 380,
                child: ListView.builder(
                  itemCount: saleModel.cartProductList!.length,
                  itemBuilder: (context, index) => CartProductViewTile(
                    cartProduct: saleModel.cartProductList![index],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 10, top: 15),
                child: Text("Total  : ₹ ${total.toStringAsFixed(2)}",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: 'Open Sans SemiBold',
                      color: AppColors.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 0,
                    )),
              ),
            ]))));
  }
}

class CartProductViewTile extends StatelessWidget {
  const CartProductViewTile({super.key, required this.cartProduct});
  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    double subTotal = cartProduct.price * cartProduct.quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 90,
      child: Row(
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  padding: const EdgeInsets.only(left: 5, right: 3, bottom: 10),
                  child: Text('${cartProduct.product.name}\n',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.mainColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Text(
                      " ${cartProduct.price.round().toString()} x ${cartProduct.quantity}",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: AppColors.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,
                      )),
                ),
              ]),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              child: Text("₹ ${subTotal.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    color:AppColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
