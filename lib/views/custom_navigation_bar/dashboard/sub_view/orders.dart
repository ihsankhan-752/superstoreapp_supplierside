import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/deliver_order.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/preparing_order.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/widgets/shipment_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: _currentIndex,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          backgroundColor: Colors.blueGrey.shade500,
          elevation: 5,
          centerTitle: true,
          title: Text(
            "Orders",
            style: AppTextStyles.APPBAR_HEADING_STYLE,
          ),
          bottom: TabBar(
            onTap: (v) {
              setState(() {
                _currentIndex = v;
              });
            },
            indicatorWeight: 3,
            tabs: [
              Text(
                "Preparing",
                style: AppTextStyles.FASHION_STYLE.copyWith(
                  color: _currentIndex == 0 ? Colors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                "Shipment",
                style: AppTextStyles.FASHION_STYLE.copyWith(
                  color: _currentIndex == 1 ? Colors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
              Text(
                "Deliver",
                style: AppTextStyles.FASHION_STYLE.copyWith(
                  color: _currentIndex == 2 ? Colors.black : Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PreparingOrder(),
            ShipmentOrder(),
            DeliverOrder(),
          ],
        ),
      ),
    );
  }
}
