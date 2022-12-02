import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';

import '../home/widgets/pdt_model.dart';

class VisitSupplierStoreScreen extends StatelessWidget {
  final String id;
  final dynamic data;
  const VisitSupplierStoreScreen({Key? key, required this.id, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.red)),
                    SizedBox(width: 20),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.network(data['image'], fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['userName'].toString().toUpperCase(),
                          style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                            fontSize: 18,
                            letterSpacing: 1.6,
                            color: ColorPallet.PRIMARY_WHITE,
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorPallet.PRIMARY_BLACK, width: 1.5),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                data['uid'] == FirebaseAuth.instance.currentUser!.uid ? "Edit" : "Follow",
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("products").where("supplierId", isEqualTo: id).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Data Found!!"),
                  );
                }
                return StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return ProductModel(
                      products: snapshot.data!.docs[index],
                    );
                  },
                  staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
