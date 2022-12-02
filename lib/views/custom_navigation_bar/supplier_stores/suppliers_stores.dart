import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/main.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/supplier_stores/visit_supplier_store.dart';

class SupplierStores extends StatelessWidget {
  const SupplierStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: ColorPallet.PRIMARY_WHITE,
        title: Text("Supplier Stores", style: AppTextStyles.APPBAR_HEADING_STYLE),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("users").where("isSupplier", isEqualTo: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text("No Store Found"),
                  );
                }
                return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return InkWell(
                      onTap: () {
                        navigateToPage(
                            context,
                            VisitSupplierStoreScreen(
                              id: snapshot.data!.docs[index].id,
                              data: snapshot.data!.docs[index],
                            ));
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        color: ColorPallet.PRIMARY_WHITE,
                        elevation: 3.5,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              color: ColorPallet.GREY_COLOR.withOpacity(0.4),
                              child: Center(
                                child: Text(data['userName']),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
