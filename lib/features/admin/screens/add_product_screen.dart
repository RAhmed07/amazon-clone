import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final AdminServices adminServices = AdminServices();

  String category = 'Mobiles';
  List<File> images =[];

  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {

    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productsCategories =[
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  void selectImage()async{
     var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct(){
   if(_addProductFormKey.currentState!.validate() && images.isNotEmpty){
     adminServices.sellProducts(
         context: context,
         name: productNameController.text,
         description: descriptionController.text,
         category: category,
         price: double.parse(priceController.text),
         quantity: double.parse(quantityController.text),
         images: images
     );
   }
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
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(

              'Add product',
              style: TextStyle(color: Colors.black),
            )),

      ),

      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),

            child: Column(

              children: [
                SizedBox(height: 20,),
                images.isNotEmpty?CarouselSlider(
                    items: images.map((i) {
                      return Builder(builder: (BuildContext context)=>Image.file(i,fit: BoxFit.cover,height: 200,),);
                    }).toList(),
                    options: CarouselOptions(viewportFraction: 1,height: 200)):
                GestureDetector(
                  onTap: selectImage,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [10,4],
                      strokeCap: StrokeCap.round,

                      child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open,size: 40,),
                        SizedBox(height: 15,),
                        Text("Select product image", style: TextStyle(fontSize: 15, color: Colors.grey.shade400),)
                      ],
                    ),
                  )),
                ),
                SizedBox(height: 30,),
                CustomTextField(controller: productNameController, hintText: 'Product Name'),
                SizedBox(height: 10,),
                CustomTextField(controller: descriptionController, hintText: 'Description',maxLines: 7,),
                SizedBox(height: 10,),
                CustomTextField(controller: priceController, hintText: 'Price',),
                SizedBox(height: 10,),
                CustomTextField(controller: quantityController, hintText: 'Quantity',),
                SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category ,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: productsCategories.map((String item) {
                      return DropdownMenuItem(
                           value: item,
                          child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal){
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),

                ),
                SizedBox(height: 20,),
                CustomButton(text: 'Sell', onTap: sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
