import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';
// void main() => runApp(MyApp());

class WorkShopProfile extends StatefulWidget {
  @override
  _WorkShopProfileState createState() => _WorkShopProfileState();
}

class _WorkShopProfileState extends State<WorkShopProfile> {
  final LocalStorage storage = new LocalStorage('storage-key');
  Future<void> fetchprofile() async {
    var id = storage.getItem("user_id");
    var response = await http.get(api_url + "/auth/workshops/$id/");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      print(id);
      print(response.statusCode);
      print(response.body);
      throw Exception("Error");
    }
  }

  @override
  void initState() {
    fetchprofile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: fetchprofile(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    //for circle avtar image
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Card(
                          child: snapshot.data["profile_pic"] == null
                              ? Image.asset("assets/0012.jpg")
                              : NetworkImage(
                                  snapshot.data["profile_pic"])),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.80, //80% of width,
                      child: Center(
                        child: Text(
                          snapshot.data["user"]["name"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            //row for each deatails
                            ListTile(
                              leading: Icon(Icons.email),
                              title: Text(snapshot.data["user"]["email"]),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                            ListTile(
                              leading: Icon(Icons.phone),
                              title: Text(snapshot.data["user"]["phone"]),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title: Text(snapshot.data["user"]["address"]),
                            ),
                            Divider(
                              height: 0.6,
                              color: Colors.black87,
                            ),
                            ListTile(
                              leading: Icon(Icons.account_box_outlined),
                              title: Text(snapshot.data["workshop_about"]),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
