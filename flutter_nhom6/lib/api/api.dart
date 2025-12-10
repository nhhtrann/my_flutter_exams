
import 'package:dio/dio.dart';
import 'package:flutter_nhom6/product.dart';

class API {
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var response = await dio.request('https://fakestoreapi.com/products');
    List<Product> ListProduct = [] ;
    if (response.statusCode == 200) {
      List ls = response.data;
      var lsProduct = ls.map((json)=>Product.fromJson(json)).toList() ;
      return lsProduct;
    }
    else{
      print('Loi roi em oiiiii') ;
    }
    return ListProduct ;
  }
}
var test_api = API();