import 'package:flutter/material.dart';
import '../../../models/registration_data.dart';
import '../../../constants/colors.dart';
import '../../../components/auth_scaffold.dart';
import '../../app_routes.dart'; // Import AppRoutes
// Plus besoin d'import direct step2, navigation via routes

class Step1PersonalInfo extends StatefulWidget {
  final RegistrationData data;

  const Step1PersonalInfo({super.key, required this.data});

  @override
  State<Step1PersonalInfo> createState() => _Step1PersonalInfoState();
}

class _Step1PersonalInfoState extends State<Step1PersonalInfo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.data.fullName);
    _emailController = TextEditingController(text: widget.data.email);
    _passwordController = TextEditingController(text: widget.data.password);
  }

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      widget.data
        ..fullName = _nameController.text
        ..email = _emailController.text
        ..password = _passwordController.text
        ..role = 'etudiant';

      Navigator.pushNamed(
        context,
        AppRoutes.registerStep2,
        arguments: widget.data,
      );
    }
  }

  InputDecoration _customInputDecoration(String label, IconData icon) {
    return InputDecoration(
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
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Étape 1 - Informations personnelles',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              cursorColor: CesamColors.primary,
              controller: _nameController,
              decoration: _customInputDecoration('Nom complet', Icons.person_outline),
              validator: (val) => val != null && val.isNotEmpty ? null : 'Veuillez entrer votre nom',
            ),
            const SizedBox(height: 16),
            TextFormField(
              cursorColor: CesamColors.primary,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _customInputDecoration('Email', Icons.email_outlined),
              validator: (val) => val != null && val.contains('@') ? null : 'Email invalide',
            ),
            const SizedBox(height: 16),
            TextFormField(
              cursorColor: CesamColors.primary,
              controller: _passwordController,
              obscureText: true,
              decoration: _customInputDecoration('Mot de passe', Icons.lock_outline),
              validator: (val) => val != null && val.length >= 6 ? null : 'Mot de passe trop court',
            ),
            const SizedBox(height: 24),
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
                onPressed: _goToNextStep,
                child: const Text(
                  "Suivant",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
