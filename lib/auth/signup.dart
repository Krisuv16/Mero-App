import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meroapp/constants/api_constants.dart';
import 'package:meroapp/widgets/alert_dialog.dart';
import 'package:meroapp/widgets/progress_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Dio dio = Dio();
  final TextEditingController emailcontroller = new TextEditingController();
  final TextEditingController passwordcontroller = new TextEditingController();
  final TextEditingController fullnamecontroller = new TextEditingController();
  final TextEditingController phonecontroller = new TextEditingController();
  final TextEditingController usernamecontroller = new TextEditingController();
  final TextEditingController addresscontroller = new TextEditingController();

  void onRegisterPressed(context) async {
    ProgressDialog progressDialog =
        buildProgressDialog(context, "Validating Data...");
    await progressDialog.show();
    var data = {
      "email": emailcontroller.text.trim(),
      "username": usernamecontroller.text.trim(),
      "password": passwordcontroller.text.trim(),
      "user_type": "C",
      "phone": phonecontroller.text.trim(),
      "name": fullnamecontroller.text.trim(),
      "address": addresscontroller.text.trim()
    };
    print(data);
    try {
      var baseurl = Uri.parse(api_url + "/register/");
      var response =
          await http.post(baseurl, body: json.encode(data), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.data);
        await progressDialog.hide();
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Verification Link Sent to Email!"),
                title: Text("Verification Pending"),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'login');
                      },
                      child: Text('Ok'))
                ],
              );
            });
        await Future.delayed(Duration(seconds: 1), () async {
          await Navigator.pushNamed(context, '/login');
        });
      }
    } catch (e) {
      await progressDialog.hide();
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Invalid Request"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Text('Ok'))
              ],
            );
          });
    }
    await progressDialog.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  inputFile(label: "Username", controller: usernamecontroller),
                  inputFile(
                      label: "Full Name ", controller: fullnamecontroller),
                  inputFile(label: "Email", controller: emailcontroller),
                  inputFile(
                      label: "Password",
                      obscureText: true,
                      controller: passwordcontroller),
                  inputFile(label: "Phone ", controller: phonecontroller),
                  inputFile(label: "Address ", controller: addresscontroller),
                ],
              ),
              Container(
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
                    emailcontroller.text == "" ||
                            passwordcontroller.text == "" ||
                            usernamecontroller.text == "" ||
                            fullnamecontroller.text == "" ||
                            phonecontroller.text == ""
                        ? null
                        : onRegisterPressed(context);
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  Text(
                    " Login",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  )
                ],
              )
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
