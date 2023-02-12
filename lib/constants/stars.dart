import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double ratings;

  const Stars({Key? key, required this.ratings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        itemCount: 5,
        itemSize: 15,
        rating: ratings,
        direction: Axis.horizontal,
        itemBuilder: (context,_){
         return Icon(Icons.star, color: GlobalVariables.secondaryColor,);
    });
  }
}
