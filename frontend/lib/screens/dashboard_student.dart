import 'package:flutter/material.dart';
import '../models/registration_data.dart';
import '../models/cesam_user.dart'; // ✅ Import du modèle CesamUser
import 'main_screen.dart';

class StudentDashboard extends StatelessWidget {
  final RegistrationData data;

  const StudentDashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    debugPrint('Étudiant connecté : ${data.fullName} | Rôle : ${data.role}');

    // Simuler la conversion RegistrationData → CesamUser
    final user = CesamUser(
      name: data.fullName,
      email: data.email,
      isAdmin: false, // tu peux adapter selon un rôle si dispo dans `data`
    );

    return MainScreen(user: user); // ✅ Passe l'utilisateur
  }
}
