import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? btnColor;
  final double? width;
  const PrimaryButton({Key? key, this.title, this.onPressed, this.btnColor, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: width,
      onPressed: onPressed,
      child: Text(
        title!,
        style: TextStyle(
          fontSize: 16,
          color: ColorPallet.PRIMARY_BLACK,
        ),
      ),
      color: btnColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class MainButton extends StatelessWidget {
  final double? width;
  final String? title;
  final Function()? onPressed;
  const MainButton({Key? key, this.width, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Container(
        height: 35,
        width: width,
        decoration: BoxDecoration(
          color: ColorPallet.AMBER_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title!),
        ),
      ),
    );
  }
}
