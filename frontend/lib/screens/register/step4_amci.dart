import 'package:flutter/material.dart';
import '../../../models/registration_data.dart';
import '../../../constants/colors.dart';
import '../../../components/auth_scaffold.dart';
import '../../app_routes.dart';

class Step4AMCI extends StatefulWidget {
  final RegistrationData data;

  const Step4AMCI({super.key, required this.data});

  @override
  State<Step4AMCI> createState() => _Step4AMCIState();
}

class _Step4AMCIState extends State<Step4AMCI> {
  bool _isAffilie = false;
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isAffilie = widget.data.isAmci ?? false;
    _codeController.text = widget.data.amciCode ?? '';
  }

  void _goToNextStep() {
    widget.data
      ..isAmci = _isAffilie
      ..amciCode = _isAffilie ? _codeController.text.trim() : null;

    Navigator.pushNamed(
      context,
      AppRoutes.registerStep5,
      arguments: widget.data,
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      prefixIcon: const Icon(Icons.badge_outlined),
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
      title: 'Étape 4 - Affiliation AMCI',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text('Êtes-vous affilié(e) à l\'AMCI ?'),
              value: _isAffilie,
              onChanged: (value) {
                setState(() => _isAffilie = value);
              },
              activeColor: CesamColors.primary,
            ),
            const SizedBox(height: 16),
            if (_isAffilie)
              TextField(
                controller: _codeController,
                decoration: _inputDecoration('Code AMCI (si connu)'),
              ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Suivant',
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
      ),
    );
  }
}
