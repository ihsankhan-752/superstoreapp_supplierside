import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:superstore_supplier_side/utils/colors.dart';
import 'package:superstore_supplier_side/utils/text_input_decoration.dart';
import 'package:superstore_supplier_side/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/lists.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool isLoading = false;
  String pdtId = '';
  String pdtName = '';
  String pdtDescription = '';
  double price = 0.0;
  int discount = 0;
  int quantity = 0;

  List<String> imageUrlList = [];
  GlobalKey<FormState> _key = GlobalKey();
  String selectedCategory = "men";
  List<XFile>? imageFileList;

  ImagePicker _picker = ImagePicker();
  Future<void> uploadProductImages() async {
    final pickedImages = await _picker.pickMultiImage(
      imageQuality: 95,
      maxHeight: 300,
      maxWidth: 300,
    );
    setState(() {
      imageFileList = pickedImages;
    });
  }

  Future<void> uploadProductData() async {
    pdtId = Uuid().v4();
    if (imageFileList!.isNotEmpty) {
      try {
        setState(() {
          isLoading = true;
        });
        for (var _image in imageFileList!) {
          FirebaseStorage fs = FirebaseStorage.instance;
          Reference ref = await fs.ref().child(DateTime.now().millisecondsSinceEpoch.toString());
          await ref.putFile(File(_image.path));
          await ref.getDownloadURL();
          imageUrlList.add(await ref.getDownloadURL());
        }
        await FirebaseFirestore.instance.collection("products").doc(pdtId).set({
          "pdtId": pdtId,
          "supplierId": FirebaseAuth.instance.currentUser!.uid,
          "category": selectedCategory,
          "productImages": imageUrlList,
          "pdtName": pdtName,
          "pdtDescription": pdtDescription,
          "discount": 0,
          "quantity": quantity,
          "price": price,
        });
        setState(() {
          isLoading = false;
        });
        imageUrlList = [];
        imageFileList = [];
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Upload Images")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Upload", style: AppTextStyles.APPBAR_HEADING_STYLE),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ColorPallet.PRIMARY_WHITE,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width * 0.45,
                        width: MediaQuery.of(context).size.width * 0.45,
                        color: Colors.blueGrey,
                        child: Center(
                          child: imageFileList == null
                              ? Text("No Photo to preview")
                              : ListView.builder(
                                  itemCount: imageFileList!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: MediaQuery.of(context).size.width * 0.4,
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      margin: EdgeInsets.all(05),
                                      child: Image.file(File(imageFileList![index].path), fit: BoxFit.cover),
                                    );
                                  },
                                ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 150, child: Text("Select Main Category", style: AppTextStyles.APPBAR_HEADING_STYLE)),
                          DropdownButton(
                            value: selectedCategory.isEmpty ? Text("No Category is Selected") : selectedCategory,
                            items: allCategories.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                selectedCategory = v.toString();
                              });
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Divider(color: ColorPallet.AMBER_COLOR, thickness: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (v) {
                            setState(() {
                              price = double.parse(v!);
                            });
                          },
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Price Must be Filled";
                            } else {
                              return null;
                            }
                          },
                          decoration: textInputDecoration.copyWith(hintText: "Price"),
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .4,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: textInputDecoration.copyWith(hintText: "Discount"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (v) {
                      setState(() {
                        quantity = int.parse(v!);
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter Product Quantity";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(hintText: "Quantity"),
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        pdtName = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Product Name must be given";
                      } else {
                        return null;
                      }
                    },
                    decoration: textInputDecoration.copyWith(hintText: "Product Name"),
                  ),
                  SizedBox(height: 13),
                  TextFormField(
                    onSaved: (v) {
                      setState(() {
                        pdtDescription = v!;
                      });
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Description must be given";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 3,
                    maxLength: 100,
                    decoration: textInputDecoration.copyWith(hintText: "Description"),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  uploadProductImages();
                },
                child: Icon(Icons.photo, color: ColorPallet.PRIMARY_BLACK),
                backgroundColor: ColorPallet.AMBER_COLOR),
            SizedBox(width: 10),
            FloatingActionButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_key.currentState!.validate()) {
                          _key.currentState!.save();
                          uploadProductData().then((value) {
                            _key.currentState!.reset();
                          });
                        } else {
                          print("Not Valid State");
                        }
                      },
                child: isLoading ? CircularProgressIndicator() : Icon(Icons.upload, color: ColorPallet.PRIMARY_BLACK),
                backgroundColor: ColorPallet.AMBER_COLOR),
          ],
        ));
  }
}
