import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/stars.dart';
import 'package:amazon_clone/features/product%20details/services/product_details_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../search/screens/search_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final ProductModel product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductDetailsServices productDetailsServices = ProductDetailsServices();

  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {

    super.initState();
    double totalRating =0;
    for(int i =0; i< widget.product.rating!.length; i++ ){
      totalRating += widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context, listen: false).user.id){
        myRating = widget.product.rating![i].rating;
      }
    }

    if(totalRating !=0){
      avgRating = totalRating/widget.product.rating!.length;
    }
  }



  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // Add to cart

  void AddToCart(){
    productDetailsServices.addToCart(context: context, product: widget.product);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            //padding: EdgeInsets.only(),
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                      height: 42,
                      margin: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
                            decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 23,
                                    ),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.only(top: 10),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide.none),
                                enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7)),
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1)),
                                hintText: 'Search Amazon.in',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17))),
                      ))),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.mic,
                  size: 25,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(widget.product.id!), Stars(ratings: avgRating)],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
                items: widget.product.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(viewportFraction: 1, height: 300)),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: 'Deal Price: ',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      )
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(text: 'Buy Now', onTap: (){}),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  text: 'Add to Cart',
                  color: Color.fromRGBO(254, 216, 19, 1),
                  onTap: AddToCart),
            ),

            SizedBox(height: 10,),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Rate the product',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            RatingBar.builder(
               initialRating: myRating,
                direction: Axis.horizontal,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4),

                itemBuilder: (context,_)=>
                Icon(Icons.star,color: GlobalVariables.secondaryColor,),
                onRatingUpdate: (rating){
               productDetailsServices.ratingProducts(context: context, product: widget.product, rating: rating);
            })

          ],
        ),
      ),
    );
  }
}
