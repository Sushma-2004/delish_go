import 'package:delish_go/data/data_models/sale_model.dart';
import 'package:delish_go/ui/pages/order_history/sales_view.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.saleModel});
  final SaleModel saleModel;

  void _showPopupView(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SalesView(
            saleModel: saleModel,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width - 160;

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.buttonBackgroundColor,
        border: Border.all(
          color: AppColors.mainColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      height: Dimensions.height20*7,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 88,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipOval(
                  child: Image(
                    image: AssetImage("assets/image/CLIENTS.png"),
                    color: AppColors.mainBlackColor,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 6, bottom: 3),
                width: screenWidth,
                child: Text(
                  '${saleModel.orderDate}\n',
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    fontSize: 14,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showPopupView(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(5),
                  backgroundColor: AppColors.mainColor,
                ),
                child: Text(
                  'VIEW',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Open Sans SemiBold',
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}