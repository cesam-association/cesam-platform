import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../components/auth_scaffold.dart';

class SubmitPfeFormPage extends StatefulWidget {
  const SubmitPfeFormPage({super.key});

  @override
  State<SubmitPfeFormPage> createState() => _SubmitPfeFormPageState();
}

class _SubmitPfeFormPageState extends State<SubmitPfeFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  String? _uploadedPdfName;

  void _simulatePdfUpload() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _uploadedPdfName = "mon_fichier_pfe.pdf";
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fichier PDF attaché (simulation).")),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_uploadedPdfName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Veuillez joindre un fichier PDF.")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Soumission envoyée (non enregistrée pour cette démo).")),
      );
      Navigator.pop(context); // Ferme simplement le formulaire
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const UnderlineInputBorder(),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: CesamColors.primary, width: 2),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _yearController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: "Soumettre un PFE / PFA",
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("Titre du PFE"),
                validator: (val) => val == null || val.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _authorController,
                decoration: _inputDecoration("Nom complet de l’auteur"),
                validator: (val) => val == null || val.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _yearController,
                decoration: _inputDecoration("Année"),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? "Champ requis" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _summaryController,
                decoration: _inputDecoration("Résumé"),
                maxLines: 4,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _simulatePdfUpload,
                icon: const Icon(Icons.attach_file),
                label: Text(_uploadedPdfName ?? "Joindre un fichier PDF"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Envoyer", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
