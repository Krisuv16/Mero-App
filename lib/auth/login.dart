import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meroapp/constants/api_constants.dart';
import 'package:meroapp/widgets/progress_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Dio dio = new Dio();
  final LocalStorage storage = new LocalStorage('storage-key');
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  Response response;
  Future<void> onLoginPressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Logging in...");
    await progressDialog.show();
    var data = {
      'email': emailcontroller.text,
      'password': passwordcontroller.text
    };
    dio.options.headers['content-Type'] = 'application/json';
    try {
      var baseurl = Uri.parse(api_url + "/login/");
      // var response =
      //     await http.post(baseurl, body: json.encode(data), headers: {
      //   HttpHeaders.contentTypeHeader: "application/json",
      // });
      var response =
          await dio.post(api_url + "/login/", data: json.encode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        await progressDialog.hide();
        print(response.statusCode);

        if (response.data != null) {
          if (response.data['user_type'] == "C") {
            await storage.setItem("user_id", response.data["id"]);
            await storage.setItem("token", response.data["tokens"]['access']);
            await storage.setItem(
                "refresh", response.data["tokens"]['refresh']);
            print(storage.getItem("user_id"));
            print(storage.getItem("token"));
            print(response.data);
            await Navigator.pushNamed(context, 'user-home');
          } else {
            print(response.data);
            await storage.setItem("user_id", response.data["id"]);
            await storage.setItem("token", response.data["tokens"]['access']);
            await storage.setItem(
                "refresh", response.data["tokens"]['refresh']);
            print(storage.getItem("user_id"));
            print(storage.getItem("token"));
            await Navigator.pushNamed(context, 'v_dashboard');
          }
        }
      }
    } catch (e) {
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("Invalid"),
            );
          });
    }
    await progressDialog.hide();
  }

  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        key: key,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputFile(label: "Email", controller: emailcontroller),
                        inputFile(
                            label: "Password",
                            obscureText: true,
                            controller: passwordcontroller)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          if (emailcontroller.text == "" ||
                              passwordcontroller.text == "") {
                            return key.currentState.showSnackBar(new SnackBar(
                              content: new Text("Enter Data To Proceed"),
                            ));
                          } else {
                            onLoginPressed(context);
                          }
                        },
                        color: Color(0xff0095FF),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () =>
                            Navigator.of(context).pushNamed("forgotpassword"),
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed("register"),
                        child: Text(
                          " Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(top: 100),
                  //   height: 200,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage("assets/0013.jpg"),
                  //         fit: BoxFit.fitHeight),
                  //   ),
                  // )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

// we will be creating a widget for text field

Widget inputFile({label, obscureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        //yo controller vaneko hai
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]))),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}
