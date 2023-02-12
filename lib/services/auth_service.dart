import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/error_handiling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/home/screens/home_screens.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  //sign up user 

  void SignUpUser({
    required BuildContext context,
     required String email,
    required String password,
    required String name,
  
  })async{
    try{
      User user = User(
        id: '',
       email: email,
        password: password,
         name: name, 
       address: '', 
       type: '',
        token: '',
        cart: []
      );

       http.Response response = await http.post(Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String , String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }  );

        HttpErrorHandle(response: response, context: context, onSuccess: (){
            showSnackBar(context, 'Account created! Log in with the same credential');
        });

    }catch(e){
      showSnackBar(context, e.toString());
    }

  }


   //sign In user 

  void SignInUser({
    required BuildContext context,
     required String email,
    required String password,
    
  
  })async{
    try{
    

       http.Response response = await http.post(Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email':email,
          'password':password
        }),
        headers: <String , String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }  );
       
        HttpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(response.body);
            await sharedPreferences.setString('x-auth-token', jsonDecode(response.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
             BottomBar.routeName,
             (route) => false,
             );
            
        });

    }catch(e){
      showSnackBar(context, e.toString());
    }

  }


   //get user data

  void getUserData(
     BuildContext context,
     
    
  
  )async{
    try{
    
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('x-auth-token');

    if(token == null){
      sharedPreferences.setString('x-auth-token','');
    }

    var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token!
    }
    );

    var response = jsonDecode(tokenRes.body);

    if(response == true){
      // get user data
      http.Response userRes = await http.get(Uri.parse('$uri/'),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token
    }
      
      );

      var userprovider = Provider.of<UserProvider>(context, listen: false);
      userprovider.setUser(userRes.body);
    }



      

    }catch(e){
      showSnackBar(context, e.toString());
    }

  }

}