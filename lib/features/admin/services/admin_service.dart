import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handiling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class AdminServices{
  void sellProducts({
  required BuildContext context,
    required String name,
    required String description,
    required String category,
    required double  price,
    required double quantity,
    required List<File> images,
})async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
  try{
   final cloudinary = CloudinaryPublic('dsjp3nfh1', 'xpak72y9');
   List<String> imageUrls =[];
   for(int i =0; i<images.length; i++){
     CloudinaryResponse response= await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path,folder: name));
     imageUrls.add(response.secureUrl);
   }
   ProductModel product = ProductModel(
       name: name,
       description: description,
       category: category,
       quantity: quantity,
       price: price,
       images: imageUrls
   );
   
   http.Response response = await http.post(
       Uri.parse('$uri/admin/add-product'),
       headers: {
         'Content-Type': 'application/json; charset=UTF-8',
         'x-auth-token': userProvider.user.token,

   },
     body: product.toJson()

   );

   HttpErrorHandle(response: response, context: context, onSuccess: (){
     showSnackBar(context, 'Product added successfully');
     Navigator.pop(context);
   });
  }catch(e){
    showSnackBar(context, e.toString());
  }
  }

  //get all the products

 Future<List<ProductModel>> fetchAllProducts(BuildContext context) async{
  final userProvider = Provider.of<UserProvider>(context,listen: false);
  List<ProductModel> productList =[];
    try{
       http.Response response = await http.get(Uri.parse('$uri/admin/get-products'),
          headers: {

            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,

      });

       HttpErrorHandle(
           response: response,
           context: context,
           onSuccess: (){
             for(int i=0; i<jsonDecode(response.body).length; i++){
               productList.add(
                 ProductModel.fromJson(jsonEncode(jsonDecode(response.body)[i]),),
               );
             }
           }
       );


    }catch(e){
      showSnackBar(context, e.toString());
    }

    return productList;

  }


  // Delete product
 void deleteProduct({
  required BuildContext context,
   required ProductModel product,
   required VoidCallback onSuccess,
}) async{

   final userProvider = Provider.of<UserProvider>(context, listen: false);
   try{


     http.Response response = await http.post(
         Uri.parse('$uri/admin/delete-product'),
         headers: {
           'Content-Type': 'application/json; charset=UTF-8',
           'x-auth-token': userProvider.user.token,

         },
         body: jsonEncode(
             {
               'id': product.id
             }
         )

     );

     HttpErrorHandle(
         response: response,
         context: context,
         onSuccess: onSuccess
     );
   }catch(e){
     showSnackBar(context, e.toString());
   }


 }
}