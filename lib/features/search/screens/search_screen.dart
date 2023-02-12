import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product%20details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/search/services/search_service.dart';
import 'package:amazon_clone/features/search/widgets/search_products.dart';
import 'package:amazon_clone/home/widgets/address_box.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchServices searchServices = SearchServices();

  List<ProductModel>? productList;
  @override
  void initState() {

    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async{
    productList = await searchServices.fetchSearchedProducts(context, widget.searchQuery);
    setState(() {

    });
  }

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            //padding: EdgeInsets.only(),
            decoration:
            BoxDecoration(gradient: GlobalVariables.appBarGradient),
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
                                hintText: 'Search',
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
      body: productList ==null?
      Loader(): Column(
        children: [
          AddressBox(),
          const SizedBox(height: 10,),
          Expanded(child: ListView.builder(
            itemCount: productList!.length,
              itemBuilder: (context, index){
             return GestureDetector(
               onTap: (){
                 Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: productList![index]);
               },
                 child: SearchedProduct(product: productList![index]));
          }))

        ],
      ),

    );
  }
}
