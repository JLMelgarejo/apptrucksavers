import 'package:http/http.dart' as http;
import 'dart:convert';

class Usuario {
  final String user;
  final String password;
  final String email;
  final String city;
  final String membresia;
  final String image;

  Usuario({
    required this.user,
    required this.password,
    required this.email,
    required this.city,
    required this.membresia,
    required this.image,
  });
}

class AuthenticationService {
  static const String baseUrl = 'http://192.168.1.69:8080';

  Future<Usuario> authenticateUser(String user, String password) async {
    final response = await http.get(Uri.parse('$baseUrl/user'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      for (var userData in data) {
        if (userData['user'] == user && userData['password'] == password) {
          return Usuario(
            user: userData['user'],
            password: userData['password'],
            email: userData['email'],
            city: userData['city'],
            membresia: userData['membresia'],
            image: userData['image'],
          );
        }
      }

      throw Exception("Credenciales incorrectas");
    } else {
      throw Exception("Error al conectarse a la API");
    }
  }

  Future<void> registerUser({
    required String email,
    required String city,
    required String user,
    required String membresia,
    required String image,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/user'),
        body: jsonEncode({
          'email': email,
          'city': city,
          'user': user,
          'membresia': membresia,
          'image': image,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Registro exitoso
        print('Usuario registrado con éxito');
      } else {
        // Manejo de errores en caso de que la solicitud falle
        print('Error en la solicitud de registro. Código de estado: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        throw Exception("Error al registrar el usuario");
      }
    } catch (e) {
      print('Error en la solicitud de registro: $e');
      throw Exception("Error al registrar el usuario");
    }
  }
}
