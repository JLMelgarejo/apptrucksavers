import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'login_page.dart';

class ConnectionFailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection Fail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('La conexión no ha sido posible.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _retryConnection(context);
              },
              child: Text('Reintentar conexión'),
            ),
          ],
        ),
      ),
    );
  }

  _retryConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Puedes mostrar un mensaje aquí si lo deseas
    }
  }
}
