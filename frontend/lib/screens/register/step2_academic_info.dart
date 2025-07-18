import 'package:flutter/material.dart';
import '../../../models/registration_data.dart';
import '../../../constants/colors.dart';
import '../../../components/auth_scaffold.dart';
import '../../app_routes.dart';

class Step2AcademicInfo extends StatefulWidget {
  final RegistrationData data;

  const Step2AcademicInfo({super.key, required this.data});

  @override
  State<Step2AcademicInfo> createState() => _Step2AcademicInfoState();
}

class _Step2AcademicInfoState extends State<Step2AcademicInfo> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _ecoleController;
  late TextEditingController _filiereController;
  String? _niveauSelectionne;

  final List<String> _niveaux = [
    'Licence 1',
    'Licence 2',
    'Licence 3',
    'Master 1',
    'Master 2',
    'Doctorat',
  ];

  @override
  void initState() {
    super.initState();
    _ecoleController = TextEditingController(text: widget.data.ecole ?? '');
    _filiereController = TextEditingController(text: widget.data.filiere ?? '');
    _niveauSelectionne = widget.data.niveau.isNotEmpty ? widget.data.niveau : null;
  }

  @override
  void dispose() {
    _ecoleController.dispose();
    _filiereController.dispose();
    super.dispose();
  }

  void _goToNextStep() {
    if (_formKey.currentState!.validate()) {
      widget.data
        ..ecole = _ecoleController.text
        ..filiere = _filiereController.text
        ..niveau = _niveauSelectionne ?? '';

      Navigator.pushNamed(
        context,
        AppRoutes.registerStep3,
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
      title: 'Étape 2 - Informations académiques',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                cursorColor: CesamColors.primary,
                controller: _ecoleController,
                decoration: _customInputDecoration("Nom de l'école", Icons.school),
                validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: CesamColors.primary,
                controller: _filiereController,
                decoration: _customInputDecoration("Filière ou domaine", Icons.book_outlined),
                validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _niveauSelectionne,
                items: _niveaux.map((niveau) {
                  return DropdownMenuItem(
                    value: niveau,
                    child: Text(niveau),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _niveauSelectionne = value),
                decoration: _customInputDecoration("Niveau d'études", Icons.grade_outlined),
                validator: (value) => value == null ? 'Sélectionnez un niveau' : null,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black),
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
      ),
    );
  }
}
