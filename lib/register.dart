import 'package:flutter/material.dart';
import 'authentication_service.dart';
import 'id_card.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final AuthenticationService _authenticationService = AuthenticationService();

  final FocusNode confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Correo Electrónico'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'Ciudad'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: userController,
                decoration: InputDecoration(labelText: 'Nombre de Usuario'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocus,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String city = cityController.text;
                    String user = userController.text;
                    String password = passwordController.text;
                    String confirmPassword = confirmPasswordController.text;

                    if (email.isNotEmpty &&
                        city.isNotEmpty &&
                        user.isNotEmpty &&
                        password.isNotEmpty &&
                        confirmPassword.isNotEmpty) {
                      if (password == confirmPassword) {
                        try {
                          await _authenticationService.registerUser(
                            email: email,
                            city: city,
                            user: user,
                            membresia: 'gratuita',
                            image: 'default',
                            password: password,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registro exitoso'),
                              duration: Duration(seconds: 2),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IdCard(
                                email: email,
                                city: city,
                                user: user,
                                membresia: 'gratuita',
                                image: 'default',
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al registrar: $e'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Las contraseñas no coinciden'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Todos los campos son obligatorios'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    confirmPasswordFocus.unfocus();
                  },
                  child: Text("Registrarse"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
