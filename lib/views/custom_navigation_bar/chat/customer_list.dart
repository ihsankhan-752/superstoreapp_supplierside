import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superstore_supplier_side/main.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/chat/chat_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/text_styles.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  String image = '';

  File? selectedImage;
  ImagePicker _picker = ImagePicker();
  Future<void> uploadImage(ImageSource source) async {
    XFile? uploadImage = await _picker.pickImage(source: source);
    if (uploadImage != null) {
      setState(() {
        selectedImage = File(uploadImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text("All Customers", style: AppTextStyles.APPBAR_HEADING_STYLE),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: ColorPallet.PRIMARY_WHITE,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () {
                  uploadImage(ImageSource.gallery);
                },
                child: Text(
                  "Change Background",
                  style: AppTextStyles.APPBAR_HEADING_STYLE.copyWith(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: ColorPallet.PRIMARY_BLACK,
        height: MediaQuery.of(context).size.height * 0.92,
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chat")
              .where("ids", arrayContains: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text("You Have No Chat Yet"),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: selectedImage == null
                  ? BoxDecoration(
                      color: Colors.blueGrey.shade600,
                    )
                  : BoxDecoration(
                      image: DecorationImage(
                      image: FileImage(
                        File(selectedImage!.path),
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(ColorPallet.PRIMARY_BLACK.withOpacity(0.7), BlendMode.srcATop),
                    )),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  getUserId() {
                    List<dynamic> users = snapshot.data!.docs[index]['ids'];
                    if (users[0] == FirebaseAuth.instance.currentUser!.uid) {
                      return users[1];
                    } else {
                      return users[0];
                    }
                  }

                  return Container(
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance.collection("users").doc(getUserId()).snapshots(),
                      builder: (context, snap) {
                        print(snapshot.data!.docs.length);
                        if (snap.hasData) {
                          Map<String, dynamic> customerInfo = snap.data!.data() as Map<String, dynamic>;
                          bool isSupplier = customerInfo['isSuppler'] == true;
                          if (isSupplier) return SizedBox();
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 05),
                            child: ListTile(
                              onTap: () {
                                navigateToPage(
                                    context,
                                    ChatScreen(
                                      docId: snapshot.data!.docs[index].id,
                                      userId: customerInfo['uid'],
                                      email: customerInfo['email'],
                                      supplierName: customerInfo['userName'],
                                    ));
                              },
                              leading: Padding(
                                padding: EdgeInsets.symmetric(vertical: 05),
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(customerInfo['image']),
                                ),
                              ),
                              title: Text(
                                customerInfo['userName'].toString().toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPallet.PRIMARY_WHITE,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data!.docs[index]['msg'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                          );
                        }
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Text('no user');
                        }
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
