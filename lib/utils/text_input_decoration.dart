import 'package:flutter/material.dart';
import 'package:superstore_supplier_side/utils/colors.dart';

var textInputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorPallet.PRIMARY_BLACK, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
  ),
);
