import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product%20details/screens/product_details_screen.dart';
import 'package:amazon_clone/home/services/home_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  ProductModel? product;
  HomeService homeService = HomeService();
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeService.fetchDealOfDay(context);
    setState(() {});
  }

  void navigateToDetailsScreen(){
    Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments:product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? Loader()
        : product!.name.isEmpty
            ? SizedBox()
            : GestureDetector(
              onTap: navigateToDetailsScreen,
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.network(
                      product!.images[0],
                      fit: BoxFit.fitHeight,
                      height: 232,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        '\$ 999',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: Text(
                        'Apple Macbook pro (14-inch with M1 pro chip with 8 gb Ram )',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: product!.images
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Image.network(
                                    e,
                                    fit: BoxFit.fitWidth,
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See more deals',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
            );
  }
}
