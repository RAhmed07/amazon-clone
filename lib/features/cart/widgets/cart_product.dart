import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product%20details/services/product_details_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ProductDetailsServices productDetailsServices = ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(ProductModel product){
   productDetailsServices.addToCart(context: context, product: product);
  }

  void decreaseQuantity(ProductModel product){
    cartServices.removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = ProductModel.fromMap(productCart['product']);
    final quantity = productCart['quantity'];
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top:5),
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),

                  ),


                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top:5),
                    child: Text(
                      '\$${product.price}',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),

                      maxLines: 2,
                    ),

                  ),

                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10,),
                    child: Text(
                      'Eligible for free shipping',
                      style: TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),

                  ),

                  Container(
                    width: 235,
                    padding: EdgeInsets.only(left: 10, top:5),
                    child: Text(
                      'In Stoke',
                      style: TextStyle(fontSize: 16,color: Colors.teal),
                      maxLines: 2,
                    ),

                  ),
                ],
              )
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap:()=> decreaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.remove,size: 18,),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border:Border.all(
                          color: Colors.black12
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0)
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(quantity.toString()),
                      ),
                    ),
                    InkWell(
                      onTap: ()=>increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Icon(Icons.add,size: 18,),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        )
      ],
    );
  }
}
