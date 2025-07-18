import 'package:flutter/material.dart';
import '../components/auth_scaffold.dart';
import '../constants/colors.dart';
import '../app_routes.dart';
import '../models/cesam_user.dart'; // <-- Nouveau modèle
import '../models/registration_data.dart';
import '../screens/register/step1_personal_info.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _simulateLogin() {
    if (_formKey.currentState!.validate()) {
      CesamUser? user;

      if (email == 'admin@cesam.com' && password == 'admin123') {
        user = CesamUser(name: 'Admin CESAM', email: email, isAdmin: true);
      } else if (email == 'test@cesam.com' && password == '123456') {
        user = CesamUser(name: 'Utilisateur Test', email: email);
      }

      if (user != null) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.main,
          arguments: user,
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text('Erreur'),
            content: Text('Identifiants invalides'),
          ),
        );
      }
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(icon, color: Colors.black),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CesamColors.primary, width: 2),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black26, width: 1),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Bienvenue dans l'App de la CESAM",
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              cursorColor: CesamColors.primary,
              decoration: _inputDecoration('Email', Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) => email = val,
              validator: (val) => val != null && val.contains('@') ? null : 'Email invalide',
            ),
            const SizedBox(height: 20),
            TextFormField(
              cursorColor: CesamColors.primary,
              decoration: _inputDecoration('Mot de passe', Icons.lock_outline),
              obscureText: true,
              onChanged: (val) => password = val,
              validator: (val) => val != null && val.length >= 6 ? null : 'Mot de passe trop court',
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                onPressed: _simulateLogin,
                child: const Text(
                  'Se connecter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.registerStep1);
              },
              child: const Text(
                "Vous n'avez pas encore de compte ? S'inscrire",
                style: TextStyle(color: CesamColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
