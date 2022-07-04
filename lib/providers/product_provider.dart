import 'package:flutter/material.dart';

import '../network/service.dart';
import '../screens/Home/view/model/productmodel.dart';

class ProductProvider extends ChangeNotifier {
  List<Products> products = [];

  bool loading = false;

  toggleLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  getProduct() async {
    toggleLoading(true);

    products = [];
    var response = await fetchProduct();

    for (var product in response.data) {
      products.add(Products.fromJson(product));
    }
    toggleLoading(false);
  }
}
