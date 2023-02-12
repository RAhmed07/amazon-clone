import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handiling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices{
  Future<List<ProductModel>> fetchSearchedProducts(BuildContext context, String searchQuery) async{
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<ProductModel> productList =[];
    try{
      http.Response response = await http.get(
          Uri.parse('$uri/api/products/search/$searchQuery'),
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
}