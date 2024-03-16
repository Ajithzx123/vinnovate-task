import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vinnovate/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  List<ProductModel> _productsList = [];
  bool isLoading = true;

  List<ProductModel> get products => _productsList;

  List<ProductModel> _filteredItems = [];

  List<ProductModel> get filteredItems => _filteredItems;

  void filterItems(String query) {
    if (query.length > 2) {
      _filteredItems = _productsList.where((item) => item.title!.toLowerCase().contains(query.toLowerCase())).toList();
      isLoading = false;
      notifyListeners();
    } else {
      _filteredItems = _productsList;
    }
  }

  Future<void> fetchData({required int limit}) async {
    isLoading = true;

    try {
      final response = await Dio().get('https://fakestoreapi.com/products?limit=$limit');

      if (response.statusCode == 200) {
        final List<ProductModel> fetchedProducts = (response.data as List).map((data) => ProductModel.fromJson(data)).toList();

        _productsList.clear();
        _filteredItems.clear();
        _productsList.addAll(fetchedProducts);
        _filteredItems.addAll(fetchedProducts);

        if (_productsList.length < limit) {
          isLoading = false;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      // isLoading = false;
      notifyListeners();
    }
  }
}
