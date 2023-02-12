import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product%20details/screens/product_details_screen.dart';
import 'package:amazon_clone/home/services/home_service.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

import '../../constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category-deals';

  final String category;
  const CategoryDealsScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  final HomeService homeService = HomeService();
  List<ProductModel>? productList;
  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList =
        await homeService.fetchCategoryProducts(context, widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            )),
      ),
      body: productList == null
          ? Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 15),
                      itemCount: productList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1.4,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = productList![index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black)),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(

                                padding: EdgeInsets.only(left: 0, top: 5, right: 15),
                                alignment: Alignment.topLeft,
                                child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,) ,

                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
