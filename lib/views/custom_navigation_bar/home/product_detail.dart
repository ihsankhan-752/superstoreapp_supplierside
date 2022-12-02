import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';

class ProductDetailScreen extends StatelessWidget {
  final dynamic data;
  const ProductDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = data['productImages'];
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        backgroundColor: Colors.grey.shade100,
        title: Text(data['pdtName'], style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 1, width: double.infinity, color: Colors.red),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Swiper(
                pagination: SwiperPagination(
                  builder: SwiperPagination.fraction,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Image.network(images[index], fit: BoxFit.cover),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              "USD ${data['price']}",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${data['quantity']} Pieces available in Stock",
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "------ Item Description------",
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 20,
                  color: ColorPallet.PRIMARY_BLACK,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "${data['pdtDescription']}",
              textAlign: TextAlign.center,
              style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.blueGrey,
              ),
            ),
            ExpansionTile(
              childrenPadding: EdgeInsets.only(right: 20),
              title: Text("Reviews"),
            ),
          ],
        ),
      ),
    );
  }
}
