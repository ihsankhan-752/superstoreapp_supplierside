import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superstore_supplier_side/controllers/auth_controller.dart';
import 'package:superstore_supplier_side/main.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/balance_screen.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/orders.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/sub_view/statics.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/widget/dashboard_screen_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: ColorPallet.PRIMARY_WHITE,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthController>(context, listen: false).signOut(context);
            },
            icon: Icon(Icons.logout),
          )
        ],
        iconTheme: IconThemeData(
          color: ColorPallet.PRIMARY_BLACK,
        ),
        title: Text("Dashboard", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              children: [
                DashBoardScreenCard(title: "My Store", icon: Icons.home_work),
                DashBoardScreenCard(
                    onPressed: () {
                      navigateToPage(context, OrderScreen());
                    },
                    title: "Orders",
                    icon: Icons.shop),
                DashBoardScreenCard(title: "Edit Profile", icon: Icons.edit),
                DashBoardScreenCard(title: "Manage Products", icon: Icons.settings),
                DashBoardScreenCard(
                    onPressed: () {
                      navigateToPage(context, BalanceScreen());
                    },
                    title: "My Balance",
                    icon: Icons.money),
                DashBoardScreenCard(
                    onPressed: () {
                      navigateToPage(context, Statics());
                    },
                    title: "Statics",
                    icon: Icons.bar_chart),
              ],
            ),
          )
        ],
      ),
    );
  }
}
