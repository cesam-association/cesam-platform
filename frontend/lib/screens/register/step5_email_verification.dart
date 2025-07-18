import 'package:flutter/material.dart';
import '../../../models/registration_data.dart';
import '../../../constants/colors.dart';
import '../../../components/auth_scaffold.dart';
import '../../app_routes.dart';

class Step5EmailVerification extends StatefulWidget {
  final RegistrationData data;

  const Step5EmailVerification({super.key, required this.data});

  @override
  State<Step5EmailVerification> createState() => _Step5EmailVerificationState();
}

class _Step5EmailVerificationState extends State<Step5EmailVerification> {
  final _codeController = TextEditingController();
  final String _codeEnvoye = '123456';
  bool _codeInvalide = false;

  void _validerCode() {
    if (_codeController.text.trim() == _codeEnvoye) {
      widget.data.emailVerified = true;

      Navigator.pushNamed(
        context,
        AppRoutes.registerStep6,
        arguments: widget.data,
      );
    } else {
      setState(() => _codeInvalide = true);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), _afficherNotificationSimulation);
  }

  void _afficherNotificationSimulation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Code de vérification simulé'),
        content: const Text('Un email contenant le code "123456" vous a été envoyé (simulation).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Étape 5 - Vérification Email",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Entrez le code envoyé à votre adresse email :",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Code de vérification',
              prefixIcon: const Icon(Icons.lock_open_outlined),
              errorText: _codeInvalide ? 'Code incorrect' : null,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _validerCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: CesamColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
              ),
              child: const Text(
                'Vérifier',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white, // texte blanc
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
