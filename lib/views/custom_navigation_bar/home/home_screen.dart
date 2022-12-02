import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/utils/app_text.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/home/widgets/all_categories.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/home/widgets/kids_category.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/home/widgets/men_category.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/home/widgets/women_category.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade100,
          extendBody: true,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(),
                    Spacer(),
                    Text(AppText.DISCOVER, style: AppTextStyles.APPBAR_HEADING_STYLE),
                    Spacer(),
                    Icon(
                      Icons.search,
                      color: ColorPallet.GREY_COLOR,
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return FilterScreen();
                            },
                          ),
                        );
                      },
                      child: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TabBar(
                  padding: EdgeInsets.zero,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  indicator: UnderlineTabIndicator(borderSide: BorderSide.none),
                  tabs: [
                    Text(AppText.ALL, style: AppTextStyles.TAB_BAR_ITEM_STYLE),
                    Text(AppText.WOMEN, style: AppTextStyles.TAB_BAR_ITEM_STYLE),
                    Text(AppText.MEN, style: AppTextStyles.TAB_BAR_ITEM_STYLE),
                    Text(AppText.KIDS, style: AppTextStyles.TAB_BAR_ITEM_STYLE),
                    Text(AppText.BEST_SELLER, style: AppTextStyles.TAB_BAR_ITEM_STYLE),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: TabBarView(
                    children: [
                      ALlCategories(),
                      WomenCategory(),
                      MenCategory(),
                      KidsCategory(),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
