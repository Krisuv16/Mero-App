import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/auth/login.dart';
import 'package:meroapp/user_screen/customer_profile.dart';
import 'package:meroapp/user_screen/my_bookings.dart';
import 'package:meroapp/user_screen/view_workshop.dart';
import 'package:meroapp/vehicle_screen/delivery_address.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  LocalStorage storage = LocalStorage("storage-key");
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; //
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              'Mero app',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.extent(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    crossAxisSpacing: 10,
                    // mainAxisSpacing: 7,
                    maxCrossAxisExtent: 200.0,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new MyHomePage())),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.car_repair,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("View Workshops",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new MyRequests())),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.note,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("My Bookings",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new CustomerProfile())),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_box_rounded,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("My Profile",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new DeliveryAddress())),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.account_box_rounded,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("My Delivery",
                                      style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Logout"),
                                content:
                                    Text("Are you sure you want to logout ?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        storage.deleteItem("user_id");
                                        storage.deleteItem("token");
                                        storage.deleteItem("refresh");
                                        print(storage.getItem("user_id"));
                                        print(storage.getItem("token"));
                                        print(storage.getItem("refresh"));
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        new LoginPage()));
                                      },
                                      child: Text("Yes")),
                                  ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("No")),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 90,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Logout", style: TextStyle(fontSize: 18))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
