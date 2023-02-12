import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


enum Auth{
  signin,
  signup
}
class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  

  @override
  void dispose() {

    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser(){
    authService.SignUpUser(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text,
       name: _nameController.text
       );
  }

  void signInUser(){
    authService.SignInUser(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text,
       
       );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text("Welcome",
              style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500
            ),),
          SizedBox(height: 10,),
          ListTile(
            tileColor: _auth == Auth.signup? GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundColor,
            title: Text("Create an account",style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val){
                setState(() {
                  _auth =val!;
                });
                }),
          ),
         if(_auth == Auth.signup)
           Container(
             padding: EdgeInsets.all(8),
             color: GlobalVariables.backgroundColor,
             child: Form(
               key: _signUpFormKey ,
                 child: Column(
                   children: [
                     CustomTextField(controller: _nameController, hintText: 'Name',),
                     SizedBox(height: 10,),
                     CustomTextField(controller: _emailController, hintText: 'Email',),
                     SizedBox(height: 10,),
                     CustomTextField(controller: _passwordController, hintText: 'Password',),
                     SizedBox(height: 10,),
                     CustomButton(text: 'Sign up', onTap: (){
                      if(_signUpFormKey.currentState!.validate()){
                        signUpUser();
                      }
                     })


                   ],
                 )
             ),
           ),

          ListTile(
            tileColor: _auth == Auth.signin? GlobalVariables.backgroundColor:GlobalVariables.greyBackgroundColor,
            title: Text("Sign-In",style: TextStyle(
                fontWeight: FontWeight.bold
            ),),
            leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val){
                  setState(() {
                    _auth =val!;
                  });
                }),
          ),

          if(_auth == Auth.signin)
            Container(
              padding: EdgeInsets.all(8),
              color: GlobalVariables.backgroundColor,
              child: Form(
                  key: _signInFormKey ,
                  child: Column(
                    children: [


                      CustomTextField(controller: _emailController, hintText: 'Email',),
                      SizedBox(height: 10,),
                      CustomTextField(controller: _passwordController, hintText: 'Password',),
                      SizedBox(height: 10,),
                      CustomButton(text: 'Sign in', onTap: (){
                         if(_signInFormKey.currentState!.validate()){
                        signInUser();
                      }
                      })


                    ],
                  )
              ),
            ),
        ],
      ),
          )),
    );
  }
}
