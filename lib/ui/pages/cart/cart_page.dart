import 'package:delish_go/data/data_models/cart_product_model.dart';
import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/logic/data_management_service/cart_management_service.dart';
import 'package:delish_go/logic/locator.dart';
import 'package:delish_go/ui/pages/cart/cart_product_tile.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget with WatchItMixin {
  CartPage({super.key});

  List<Widget> getProductsWidget(List<CartProductModel> cartProductList) {
    List<Widget> cartListView = [];

    for (var cartProduct in cartProductList) {
      Widget tile = CartProductTile(cartProduct: cartProduct);
      cartListView.add(tile);
    }

    return cartListView;
  }

  final TextEditingController saleDateController = TextEditingController(
      text: DateFormat.yMMMd('en_US')
          .format(DateTime.now().add(const Duration(days: 7))));

  void createOrder() {
    final cartProductList = Locator.cartManagementService.cartProductList.value;
    final subTotal = Locator.cartManagementService.subTotal.value;
    DateTime orderDate = DateTime.now();

    SaleModel saleModel = SaleModel(
      cartProductList: cartProductList,
      orderDate: orderDate,
      subTotal: subTotal,
    );
    Locator.saleManagementService.addSale(saleModel);
    Locator.cartManagementService.clearCart();
    Locator.navigationService.currentPageIndex.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    var cartProductList =
        watchValue((CartManagementService x) => x.cartProductList);
    var subTotal = watchValue((CartManagementService x) => x.subTotal);

    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(13),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Text('  Cart ',
                  style: TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    letterSpacing: 1.33,
                    fontSize: Dimensions.font30,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  )),
            ),
          ),
          Column(
            children:
                getProductsWidget(cartProductList.cast<CartProductModel>()),
          ),
          divider(),
          Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                      text: "Total :  ₹ ${(subTotal).round().toString()}",
                      style: const TextStyle(
                        fontFamily: 'Open Sans SemiBold',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      )),
                ),
                divider(),
                GestureDetector(
                  onTap: () {
                    if (cartProductList.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: SizedBox(
                                  height: 300.0,
                                  width: 360.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          "Please Add Product",
                                          style: TextStyle(
                                              fontFamily: 'Open Sans SemiBold',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 22.0),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (() {
                                          Navigator.of(context).pop();
                                        }),
                                        child: Container(
                                          height: 56,
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: const Text("Close",
                                              style: TextStyle(
                                                fontFamily:
                                                    'Open Sans SemiBold',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                    } else {
                      createOrder();
                      Locator.cartManagementService.clearCart();
                      Locator.navigationService.currentPageIndex.value = 0;
                    }
                  },
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.mainColor,
                    ),
                    child: Text("Place order",
                        style: TextStyle(
                          fontFamily: 'Open Sans SemiBold',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Container divider() {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    );
  }
}
