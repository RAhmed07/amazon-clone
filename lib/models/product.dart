import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  final String name;
  final String description;
  final String category;
  final double quantity;
  final double price;
  final List<String> images;
  final String?  id;
  final List<Rating>? rating;

  ProductModel({
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.price,
    required this.images,
     this.id,
    this.rating

  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'category': category,
      'quantity': quantity,
      'price': price,
      'images': images,
      'id': id,
      'rating':rating

    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        name: map['name'] as String,
        description: map['description'] as String,
        category: map['category'] as String,
        quantity: map['quantity']?.toDouble()?? 0.0,
        price: map['price']?.toDouble()?? 0.0,
        images: List<String>.from(map['images'] ),
        id: map['_id'] ,
        rating: map['ratings'] !=null? List<Rating>.from(map['ratings']?.map((x)=>Rating.fromMap(x))) :null
        );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
//
//