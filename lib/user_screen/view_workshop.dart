import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meroapp/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:meroapp/user_screen/workshop_details.dart';

class Product {
  final String name;
  final String description;
  final String location;
  final String image;
  Product(this.name, this.description, this.location, this.image);

  static List<Product> getProducts() {
    List<Product> items = <Product>[];
    items.add(Product(
        "Chabahil - workshop",
        "This workshop is the very popular workshop which provides the best service around ktm with the best price.",
        "chabahil",
        "assets/0012.jpg"));
    items.add(Product(
        "Basundhara-Workshop",
        "This workshop is the very popular workshop which provides the best service around ktm with the best price.",
        "basundhara",
        "assets/0012.jpg"));
    items.add(Product(
        "Lalitpur-Workshop",
        "This workshop is the very popular workshop which provides the best service around ktm with the best price.",
        "lalitpur",
        "assets/0013.jpg"));
    items.add(Product(
        "Kumaripati-Workshop",
        "This workshop is the very popular workshop which provides the best service around ktm with the best price.",
        "kumaripati",
        "assets/0012.jpg"));
    items.add(Product("DhobiKhola-Workshop", "iPhone is the stylist phone ever",
        "dhobikhola", "assets/0012.jpg"));
    items.add(Product(
        "Basantapur-Workshop",
        "This workshop is the very popular workshop which provides the best service around ktm with the best price.",
        "basantapur",
        "assets/0012.jpg"));
    return items;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = Product.getProducts();

  Future<List> getworkshops() async {
    var baseurl = Uri.parse(api_url + "/booking/services/");
    var response = await http.get(baseurl);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    getworkshops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("View Workshop")),
        body: FutureBuilder<List>(
          future: getworkshops(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => new WorkShopDetails(
                              list: snapshot.data,
                              index: index,
                            ))),
                    child: Container(
                        padding: EdgeInsets.all(2),
                        height: 180,
                        child: Card(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  height: double.infinity,
                                  width: 150,
                                  child: Card(
                                      child: snapshot.data[index]["user"]
                                                  ["profile_pic"] ==
                                              null
                                          ? Image.asset("assets/0012.jpg")
                                          : NetworkImage(snapshot.data[index]
                                              ["user"]["profile_pic"])),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                                snapshot.data[index]["user"]
                                                    ["user"]["name"],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(snapshot.data[index]["user"]
                                                ["user"]["phone"]),
                                            Text(snapshot.data[index]["user"]
                                                ["user"]["email"]),
                                            Text(
                                              snapshot.data[index]["user"]
                                                  ["user"]["address"],
                                              maxLines: 1,
                                            ),
                                          ],
                                        )))
                              ]),
                        )),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class ProductPage extends StatelessWidget {
  ProductPage({Key key, this.item}) : super(key: key);
  final Product item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        this.item.name,
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.blue[200],
          fontWeight: FontWeight.w600,
        ),
      )),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset("assets/assets/0012.jpg" + this.item.image),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87)),
                            Text(this.item.description),
                            Text("location: " + this.item.location.toString()),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.item}) : super(key: key);
  final Product item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 180,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 150,
                  child: Card(
                      child: Image.asset("assets/0012.jpg" + this.item.image)),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Location: " + this.item.location.toString()),
                          ],
                        )))
              ]),
        ));
  }
}
