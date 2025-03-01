import 'package:flutter/material.dart';

import 'curd_api.dart';


class productcard extends StatelessWidget {
  final Data product;
  final VoidCallback onedit;
  final VoidCallback ondelete;

  const productcard(
      {super.key,
        required this.product,
        required this.onedit,
        required this.ondelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: ClipRect(
              child: Container(
                height: 100,
                width: double.infinity,
                child: Image.network(
                  product.img.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Text("Qty: ${product.qty} || Price: ${product.unitPrice}"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: onedit, icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: ondelete,
                  icon: Icon(
                    Icons.delete_outline_outlined,
                    color: Colors.red,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
