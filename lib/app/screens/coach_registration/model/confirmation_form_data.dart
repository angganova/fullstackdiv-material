import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';

class ConfirmationFormData {
  ConfirmationFormData({
    this.url,
    this.category,
    this.title,
    this.description,
  });
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController urlTC = TextEditingController();
  final TextEditingController categoryTC = TextEditingController();
  final TextEditingController titleTC = TextEditingController();
  final TextEditingController descriptionTC = TextEditingController();

  String url;
  String title;
  String category;
  String description;

  bool editData = false;

  bool get isPopulated =>
      url.isNotNullOrEmpty &&
      category.isNotNullOrEmpty &&
      title.isNotNullOrEmpty &&
      description.isNotNullOrEmpty;

  void setDataFromTC() {
    editData = false;
    url = urlTC.text;
    category = categoryTC.text;
    title = titleTC.text;
    description = descriptionTC.text;
  }

  void deleteData() {
    url = null;
    category = null;
    title = null;
    description = null;
  }
}
