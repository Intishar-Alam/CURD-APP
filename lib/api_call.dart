
//https://jsonplaceholder.typicode.com/users

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Api_calling_prct extends StatefulWidget {
  const Api_calling_prct({super.key});

  @override
  State<Api_calling_prct> createState() => _Api_calling_prctState();
}


class _Api_calling_prctState extends State<Api_calling_prct> {
  List users = [];
  bool isloading= false;


  Future<void> fetchuser() async {
    setState(() {
      isloading = true;
    });
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    setState(() {
      isloading = false;
    });
    if(response.statusCode == 200){
      users = jsonDecode(response.body);
    }else{
      throw Exception("Failed collection ");
    }
  }
  @override
  void initState() {
    super.initState();
    fetchuser();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.green[100],
        appBar: AppBar(
          title: Text("Api Call"),

        ),
        body: isloading ? Center(child: CircularProgressIndicator()): Expanded(
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context,index){
                final user = users[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: ListTile(
                    title: Text(user['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("username :${user['username']} "),
                        Text("email: ${user['email']}"),
                        Text("phone: ${user['phone']}"),
                        Text("website: ${user['website']}"),

                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text("${user['name'][0]}"),
                    ),
                  ),
                );
              }
          ),
        )
    );
  }


}

