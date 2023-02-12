import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handiling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices{

  void addToCart({
    required BuildContext context,
    required ProductModel product,

  })async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{

      http.Response response = await http.post(
          Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

          },
          body: jsonEncode({
            'id': product.id!,

          })

      );

      HttpErrorHandle(response: response, context: context, onSuccess: (){
        User user = userProvider.user.copyWith(cart: jsonDecode(response.body)['cart']);

        userProvider.setUserFromModel(user);

      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }




  //Product Rating
  void ratingProducts({
    required BuildContext context,
    required ProductModel product,
    required double rating
  })async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{

      http.Response response = await http.post(
          Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

          },
          body: jsonEncode({
            'id': product.id!,
            'rating': rating
          })

      );

      HttpErrorHandle(response: response, context: context, onSuccess: (){


      });
    }catch(e){
      showSnackBar(context, e.toString());
    }
  }

}