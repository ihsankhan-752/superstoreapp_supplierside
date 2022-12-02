import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/text_styles.dart';
import 'order_info_card.dart';

class DeliverOrder extends StatelessWidget {
  const DeliverOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("supplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where("orderStatus", isEqualTo: "deliver")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "Sorry No Order Found For Delivery!",
                style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                  fontSize: 22,
                  color: Colors.blueGrey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var orderInfo = snapshot.data!.docs[index];
              return Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.brown),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 100,
                          width: 80,
                          child: Image.network(orderInfo['orderImage']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(orderInfo['orderName']),
                                Text("\$ ${orderInfo['orderPrice'].toString()}"),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 60, right: 20),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text("x${orderInfo['orderQuantity']}"),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text("See More"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              OrderInfoCard(title: "Name", value: orderInfo['customerName']),
                              OrderInfoCard(title: "Phone", value: orderInfo['customerPhone']),
                              OrderInfoCard(title: "Email", value: orderInfo['customerEmail']),
                              OrderInfoCard(title: "Address", value: orderInfo['customerAddress']),
                              OrderInfoCard(title: "Payment Status", value: orderInfo['paymentStatus']),
                              OrderInfoCard(
                                title: "Order Status",
                                value: orderInfo['orderStatus'],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
