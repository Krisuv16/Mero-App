import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';

class RequestServices extends StatefulWidget {
  int index;
  RequestServices({this.index});
  @override
  _RequestServicesState createState() => _RequestServicesState();
}

class _RequestServicesState extends State<RequestServices> {
  LocalStorage storage = LocalStorage('storage-key');
  String value;
  String catvalue;
  DateTime date = DateTime.now();
  TimeOfDay time;
  List listItem = [
    "Battery Replacement",
    "Brake Pad Change",
    "Timing Belt Replacement",
    "Wheel Turing",
    "Servicing",
    "Wash"
  ];

  List category = [
    'Two Wheeler with Gear',
    '4 Wheeler with gear',
    '4 wheeler without gear'
  ];
  final TextEditingController vnamecontroller = new TextEditingController();
  final TextEditingController vnocontroller = new TextEditingController();
  final TextEditingController vmodelcontroller = new TextEditingController();
  final TextEditingController vbrandcontroller = new TextEditingController();
  final TextEditingController problemcontroller = new TextEditingController();

  Future<Null> selectdate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        print(
            "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}");
      });
    }
  }

  Future<void> postdata() async {
    LocalStorage storage = LocalStorage('storage-key');
    var id = storage.getItem("user_id");
    var token = storage.getItem("token");
    var data = {
      "category": catvalue,
      "vehicle_no": vnocontroller.text.trim(),
      "vehicle_name": vnamecontroller.text.trim(),
      "vehicle_model": vmodelcontroller.text.trim(),
      "vehicle_brand": vbrandcontroller.text.trim(),
      "services": value,
      "problem_description": problemcontroller.text.trim(),
      "date":
          "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}",
      "customer": id,
      "workshop": widget.index
    };
    print(data);

    var url = Uri.parse(api_url + "/booking/request/");
    var response = await http.post(url, body: json.encode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Confirmation Pending"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("user-home");
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.statusCode);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Request Error"),
              content: Text("Sign In Again"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "ok",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            );
          });
      print(response.body);
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    print(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Services"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: DropdownButton(
                    hint: Text("Select Category"),
                    // dropdownColor: Colors.amber,
                    value: catvalue,
                    items: category.map((valueitem) {
                      return DropdownMenuItem(
                          value: valueitem, child: Text(valueitem));
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        catvalue = newvalue;
                      });
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicle Number',
                  labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                controller: vnocontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicle Name',
                  labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                controller: vnamecontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicle Model',
                  labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                controller: vmodelcontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Vehicle Brand',
                  labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                controller: vbrandcontroller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Vehicle Problem Details',
                  labelStyle: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                controller: problemcontroller,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: Text("Select Service"),
                  // dropdownColor: Colors.amber,
                  value: value,
                  items: listItem.map((valueitem) {
                    return DropdownMenuItem(
                        value: valueitem, child: Text(valueitem));
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      value = newvalue;
                      print(value);
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      "Pick Date:   ",
                      style: TextStyle(fontSize: 25),
                    ),
                    GestureDetector(
                        onTap: () {
                          selectdate(context);
                          print("test");
                        },
                        child: Icon(Icons.date_range))
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  postdata();
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
