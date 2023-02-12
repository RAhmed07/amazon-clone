import 'dart:convert';

import 'package:amazon_clone/constants/error_handiling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../constants/global_variables.dart';

class HomeService{
  Future<List<ProductModel>> fetchCategoryProducts(BuildContext context, String category) async{
     final userProvider = Provider.of<UserProvider>(context,listen: false);
     List<ProductModel> productList =[];
    try{
     http.Response response = await http.get(
          Uri.parse('$uri/api/products?category=$category'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

      });

      HttpErrorHandle(
          response: response,
          context: context,
          onSuccess: (){
          for(int i = 0; i< jsonDecode(response.body).length; i++ ){
            productList.add(
              ProductModel.fromJson(jsonEncode(jsonDecode(response.body)[i]))
            );
          }
      });




    }catch(e){
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // Deal of the day

  Future<ProductModel> fetchDealOfDay(BuildContext context,) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    ProductModel product = ProductModel(
        name: '',
        description: '',
        category: '',
        quantity: 0,
        price: 0,
        images: []
    );
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/deal-of-day'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

          });

      HttpErrorHandle(
          response: response,
          context: context,
          onSuccess: (){
            product = ProductModel.fromJson(response.body);
          });




    }catch(e){
      showSnackBar(context, e.toString());
    }
    return product;
  }

}