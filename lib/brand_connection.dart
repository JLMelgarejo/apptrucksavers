import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'login_page.dart';
import 'connection_fail.dart';

class BrandConnectionPage extends StatefulWidget {
  @override
  _BrandConnectionPageState createState() => _BrandConnectionPageState();
}

class _BrandConnectionPageState extends State<BrandConnectionPage> {
  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  _checkConnection() async {
    await Future.delayed(Duration(seconds: 5));

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ConnectionFailPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brand Connection Page'),
      ),
      body: Center(
        child: Text('Bienvenido'),
      ),
    );
  }
}
