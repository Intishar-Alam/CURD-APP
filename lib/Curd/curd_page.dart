import 'package:api_caall/Curd/curd_api.dart';
import 'package:api_caall/Curd/widget.dart';
import 'package:flutter/material.dart';

class CurdPage extends StatefulWidget {
  const CurdPage({super.key});

  @override
  State<CurdPage> createState() => _CurdPageState();
}

class _CurdPageState extends State<CurdPage> {
  bool isloading = false;
  Productmanager productmanager = Productmanager();

  Future<void> fetchdata() async {
    setState(() {
      isloading = true;
    });
    await productmanager.fetchproducts();
    setState(() {
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchdata();
  }

  void _snackbar(String textsnack) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(textsnack),
      duration: Duration(seconds: 2),
    ));
  }

  void _showdialog(
      {String? id,
      String? name,
      int? quantity,
      double? unitprice,
      double? total,
      String? img}) {
    TextEditingController _namecontroller = TextEditingController();
    TextEditingController _imgcontroller = TextEditingController();
    TextEditingController _quantitycontroller = TextEditingController();
    TextEditingController _unitpricecontroller = TextEditingController();
    TextEditingController _totalpricecontroller = TextEditingController();

    _namecontroller.text = name ?? '';
    _imgcontroller.text = img ?? '';
    _quantitycontroller.text = id != null ? quantity.toString() : '';
    _unitpricecontroller.text = id != null ? unitprice.toString() : '';
    _totalpricecontroller.text = id != null ? total.toString() : '';

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(id == null ? 'Add Product' : 'Update Product'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration:
                      InputDecoration(hintText: 'Name', labelText: 'Name'),
                  controller: _namecontroller,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: 'Image', labelText: 'Image'),
                  controller: _imgcontroller,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Quantity', labelText: 'Quantity'),
                  controller: _quantitycontroller,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: 'Unitprice', labelText: 'Unitprice'),
                  controller: _unitpricecontroller,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: 'Total', labelText: 'Total'),
                  controller: _totalpricecontroller,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        if (id == null) {
                          await productmanager.createproduct(
                              _namecontroller.text,
                              _imgcontroller.text,
                              int.parse(_quantitycontroller.text),
                              double.parse(_unitpricecontroller.text),
                              double.parse(_totalpricecontroller.text));
                        } else {
                          await productmanager.updateproduct(
                              id,
                              _namecontroller.text,
                              _imgcontroller.text,
                              int.parse(_quantitycontroller.text),
                              double.parse(_unitpricecontroller.text),
                              double.parse(_totalpricecontroller.text));
                        }
                        fetchdata();
                      },
                      child: Text(id == null ? "Add Product" : "Update"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple[200],
                          foregroundColor: Colors.white),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void _delete(String id) async {
    await productmanager.deleteProduct(id).then((Value) {
      if (Value) {
        return _snackbar("Succesfull");
      } else {
        return _snackbar("Sprry");
      }
    });
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("CURD"),
      ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.pink[200],
            ))
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 0.7),
              itemCount: productmanager.products.length,
              itemBuilder: (context, index) {
                var product = productmanager.products[index];
                return productcard(
                  product: product,
                  onedit: () {
                    _showdialog(
                        id: product.sId,
                        name: product.productName,
                        quantity: product.qty,
                        unitprice: double.parse(product.unitPrice.toString()),
                        total: double.parse(product.totalPrice.toString()),
                        img: product.img);
                  },
                  ondelete: () => _delete(product.sId.toString()),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showdialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}

