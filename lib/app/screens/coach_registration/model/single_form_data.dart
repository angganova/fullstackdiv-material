import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class SingleFormDataModel {
  SingleFormDataModel({this.singleFormData});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController singleTC = TextEditingController();

  String singleFormData;

  bool editData = false;

  bool get isPopulated => singleFormData.isNotNullOrEmpty;

  void setDataFromTC() {
    singleFormData = singleTC.text;
    editData = false;
  }

  void deleteData() {
    singleFormData = null;
  }
}
