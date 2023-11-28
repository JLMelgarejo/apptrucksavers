import 'package:flutter/material.dart';
import 'authentication_service.dart';

class UpgradePlan extends StatefulWidget {
  @override
  _UpgradePlanState createState() => _UpgradePlanState();
}

class _UpgradePlanState extends State<UpgradePlan> {
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<void> _updateMembership(String newMembership) async {
    try {
      // Lógica para actualizar la membresía del usuario actual
      // Puedes utilizar el servicio de autenticación o realizar una solicitud HTTP al servidor
      // Ejemplo usando el servicio de autenticación:
      // await _authenticationService.updateMembership(newMembership);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Membresía actualizada a $newMembership'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al actualizar la membresía: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _deleteAccount() async {
    try {
      // Lógica para borrar la cuenta del usuario actual
      // Puedes utilizar el servicio de autenticación o realizar una solicitud HTTP al servidor
      // Ejemplo usando el servicio de autenticación:
      // await _authenticationService.deleteAccount();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cuenta borrada exitosamente'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al borrar la cuenta: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upgrade Plan'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _updateMembership('premium');
            },
            child: Text('Premium'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateMembership('gratuita');
            },
            child: Text('Gratuita'),
          ),
          ElevatedButton(
            onPressed: () {
              _deleteAccount();
            },
            child: Text('Borrar Cuenta'),
          ),
        ],
      ),
    );
  }
}
