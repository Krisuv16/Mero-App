import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';

class ConfirmBooking extends StatefulWidget {
  List list;
  int index;
  ConfirmBooking({this.list, this.index});
  @override
  _ConfirmBookingState createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  LocalStorage storage = LocalStorage("storage-key");
  String value;
  List listItem = ["Booked", "Canceled"];
  Future<List> fetchrequests() async {
    var token = storage.getItem("token");
    var url = Uri.parse(api_url + "/booking/book/");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Krisuv");
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print("Krisuv");
      print(response.body);
      throw Exception("Error");
    }
  }

  Future<void> fetchprofile() async {
    var response = await http.get(
        api_url + "/auth/customer/${widget.list[widget.index]["customer"]}/");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception("Error");
    }
  }

  Future update() async {
    var data = {
      "id": widget.list[widget.index]["id"],
      "category": widget.list[widget.index]["category"],
      "vehicle_no": widget.list[widget.index]["vehicle_no"],
      "vehicle_name": widget.list[widget.index]["vehicle_name"],
      "vehicle_model": widget.list[widget.index]["vehicle_model"],
      "vehicle_brand": widget.list[widget.index]["vehicle_brand"],
      "services": widget.list[widget.index]["services"],
      "problem_description": widget.list[widget.index]["problem_description"],
      "date": widget.list[widget.index]["date"],
      "status": value,
      "customer": widget.list[widget.index]["customer"],
      "workshop": widget.list[widget.index]["workshop"]
    };
    var token = storage.getItem("token");
    var url = Uri.parse(
        api_url + "/booking/request/${widget.list[widget.index]["id"]}/");
    var response = await http.patch(url, body: json.encode(data), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return new AlertDialog(
              title: Text("Booking Confirmed"),
              actions: [
                FlatButton(
                    color: Colors.green,
                    onPressed: () async {
                      Navigator.of(context).pushNamed("v_dashboard");
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
    print(data);
  }

  @override
  void initState() {
    fetchrequests();
    fetchprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Confirm Booking"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text("ID"),
                      title: Text(
                        widget.list[widget.index]["id"].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                        leading: Text("Category"),
                        title: Text(
                          widget.list[widget.index]["category"],
                          textAlign: TextAlign.center,
                        )),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                        leading: Text("Name"),
                        title: Text(
                          widget.list[widget.index]["vehicle_name"],
                          textAlign: TextAlign.center,
                        )),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Vehicle No"),
                      title: Text(
                        widget.list[widget.index]["vehicle_no"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Model"),
                      title: Text(
                        widget.list[widget.index]["vehicle_model"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Brand"),
                      title: Text(
                        widget.list[widget.index]["vehicle_brand"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Services"),
                      title: Text(
                        widget.list[widget.index]["services"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    ListTile(
                      leading: Text("Problem"),
                      title: Text(
                        widget.list[widget.index]["problem_description"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      leading: Text("Date"),
                      title: Text(
                        widget.list[widget.index]["date"],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    Container(
                      child: FutureBuilder(
                        future: fetchprofile(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              leading: Text("Customer"),
                              title: Text(
                                snapshot.data["user"]["name"],
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else {
                            return ListTile(
                              leading: Text("Customer"),
                              title: Text(
                                "",
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    Divider(
                      height: 0.6,
                      color: Colors.black87,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Confirm Booking",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    DropdownButton(
                      hint: Text("Status"),
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
                    ElevatedButton(
                        onPressed: () {
                          update();
                        },
                        child: Text("Confirm"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
