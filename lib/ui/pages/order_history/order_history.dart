import 'package:delish_go/logic/data_management_service/sale_management_service.dart';
import 'package:delish_go/ui/pages/order_history/order_tile.dart';
import 'package:delish_go/ui/utils/AppColors/app_colors.dart';
import 'package:delish_go/ui/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:watch_it/watch_it.dart';

class OrderHistory extends StatelessWidget with WatchItMixin {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var saleListToDisplay =
        watchValue((SaleManagementService x) => x.salesToDisplay);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text('  ORDERS ',
                  style: TextStyle(
                    fontFamily: 'Open Sans SemiBold',
                    letterSpacing: 1.33,
                    fontSize: Dimensions.font30,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  )),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: saleListToDisplay.length,
                itemBuilder: (context, index) => OrderTile(
                  saleModel: saleListToDisplay[index],
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
