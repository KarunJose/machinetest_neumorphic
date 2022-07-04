
import 'package:dio/dio.dart';

fetchProduct() async {
  var response = await Dio().get('https://fakestoreapi.com/products');
  return response;
}