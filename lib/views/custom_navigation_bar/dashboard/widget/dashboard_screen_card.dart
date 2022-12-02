import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/text_styles.dart';

class DashBoardScreenCard extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onPressed;
  const DashBoardScreenCard({Key? key, this.title, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 2),
              color: ColorPallet.PRIMARY_BLACK.withOpacity(0.5),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorPallet.PRIMARY_PURPLE.withOpacity(0.6),
              Colors.blueGrey,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: ColorPallet.AMBER_COLOR),
            SizedBox(height: 20),
            Text(
              title!,
              style: AppTextStyles.DASHBOARD_MENU_STYLE,
            ),
          ],
        ),
      ),
    );
  }
}
