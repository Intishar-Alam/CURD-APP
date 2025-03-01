import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Urls{
  static String baseurl = 'http://35.73.30.144:2008/api/v1';
  static String CreatProduct = '$baseurl/CreateProduct';
  static String ReadProduct = '$baseurl/ReadProduct';
  static String UpdateProduct(String id) => '$baseurl/UpdateProduct/$id';
  static String DeleteProduct(String id) => '$baseurl/DeleteProduct/$id';

}

// class Productmanager{
//   List products = [];
//
//   Future<void> fetchdata() async {
//     final response = await http.get(Uri.parse(Urls.ReadProduct));
//     if(response.statusCode == 200){
//       final data = jsonDecode(response.body);
//       products = data['data'];
//
//     }
//   }
//
//
//   Future<void> createproducts(String name, String image,int quantity,double unitprice,double totalprice)async {
//   final response = await http.post(Uri.parse(Urls.CreatProduct),
//   headers: {'Content-Type': 'application/json'},
//   body: jsonEncode({
//     "ProductName": name,
//     "ProductCode": DateTime.now().millisecondsSinceEpoch.toString(),
//     "Img": image,
//     "Qty": quantity,
//     "UnitPrice": unitprice,
//     "TotalPrice": totalprice
//   })
//     );
//
//   if(response.statusCode == 201){
//      fetchdata();
//
//   }
//   }
// }

class Productmanager{
  List<Data> products = [];
  Future<void> fetchproducts()async{

    final response = await http.get(Uri.parse(Urls.ReadProduct));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      product_js product_cntrl = product_js.fromJson(data);
      products = product_cntrl.data ?? [];

    }
  }
  Future<bool> deleteProduct(String id)async{
    final response = await http.get(Uri.parse(Urls.DeleteProduct(id)));

    if(response.statusCode ==200){
      return true;
    }else{
      return false;
    }
  }

  Future<void> createproduct(String name, String image,int quantity,double unitprice,double totalprice)async{
    final response = await http.post(Uri.parse(Urls.CreatProduct),
    headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        "ProductName": name,
        "ProductCode": DateTime.now().millisecondsSinceEpoch.toString(),
        "Img": image,
        "Qty": quantity,
        "UnitPrice": unitprice,
        "TotalPrice": totalprice
      })
    );

    if(response.statusCode == 201){
    fetchproducts();
    }
  }

  Future<void> updateproduct(String id,String name, String image,int quantity,double unitprice,double totalprice)async{
    final response = await http.post(Uri.parse(Urls.UpdateProduct(id)),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({
          "ProductName": name,
          "ProductCode": DateTime.now().millisecondsSinceEpoch.toString(),
          "Img": image,
          "Qty": quantity,
          "UnitPrice": unitprice,
          "TotalPrice": totalprice
        })
    );

    if(response.statusCode == 201){
      fetchproducts();
    }
  }
}

class product_js {
  String? status;
  List<Data>? data;

  product_js({this.status, this.data});

  product_js.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? productName;
  int? productCode;
  String? img;
  int? qty;
  int? unitPrice;
  int? totalPrice;

  Data(
      {this.sId,
        this.productName,
        this.productCode,
        this.img,
        this.qty,
        this.unitPrice,
        this.totalPrice});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    img = json['Img'];
    qty = json['Qty'];
    unitPrice = json['UnitPrice'];
    totalPrice = json['TotalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['ProductName'] = this.productName;
    data['ProductCode'] = this.productCode;
    data['Img'] = this.img;
    data['Qty'] = this.qty;
    data['UnitPrice'] = this.unitPrice;
    data['TotalPrice'] = this.totalPrice;
    return data;
  }
}