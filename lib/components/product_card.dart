// import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/config.dart';
import 'package:groceryapp/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product? model;
  const ProductCard({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: 150,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Stack(
        children: [
          Visibility(
            visible: model!.calculateDiscount>0,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.green
                ),
                child: Text(
                  "${model!.calculateDiscount}% OFF",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: SizedBox(
                  child:
                  CachedNetworkImage(
        imageUrl: model!.fullImagePath,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
     ),
                  // Image.network(
                  //   model!.fullImagePath,
                  //   // fit:BoxFit.cover,
                  // ),
                  height: 280,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8,left: 10),
                child: Text(
                  model!.productName,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    )
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        Text("${Config.currency}${model!.productPrice.toString()}",
                        textAlign:TextAlign.left ,
                        style: TextStyle(
                          fontSize: 12,
                          color: model!.calculateDiscount>0 ? Colors.blue:Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: model!.productSalePrice>0 
                          ? TextDecoration.lineThrough:null,
                        ),
                      ),
                      Text(
                        (model!.calculateDiscount>0) 
                        ? "(${model!.productSalePrice.toString()})"
                         : "",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          color:Colors.black,
                          fontWeight:FontWeight.bold,
                          )
                      )
                      ],
                    ),
                    ),
                    GestureDetector(
                      child: const Icon(
                      Icons.favorite,
                      color: Colors.grey,
                      size: 20,
                      ),
                      onTap:(){
                        
                      }
                    )
                ],
              )
      
            ],
          ),
        ],
      ),
    );
  }
}
