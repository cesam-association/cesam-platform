import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AdminVideoSubmissionPage extends StatefulWidget {
  const AdminVideoSubmissionPage({super.key});

  @override
  State<AdminVideoSubmissionPage> createState() => _AdminVideoSubmissionPageState();
}

class _AdminVideoSubmissionPageState extends State<AdminVideoSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _videoUrl = '';
  String? _category;

  final List<String> _categories = [
    'Chaîne TV étudiante',
    'Documentaires & Films',
  ];

  void _submitVideo() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vidéo '$_title' envoyée dans $_category avec succès !")),
      );

      // TODO: Envoyer les données (_title, _videoUrl, _category) au backend ou base de données

      _formKey.currentState!.reset();
      setState(() {
        _title = '';
        _videoUrl = '';
        _category = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Envoyer une vidéo', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Titre de la vidéo',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => _title = val ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL de la vidéo',
                  hintText: 'https://...',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Champ requis';
                  final uri = Uri.tryParse(val);
                  if (uri == null || (!uri.isAbsolute)) return 'URL invalide';
                  return null;
                },
                onSaved: (val) => _videoUrl = val ?? '',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Catégorie',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                value: _category,
                items: _categories.map((cat) {
                  return DropdownMenuItem(value: cat, child: Text(cat));
                }).toList(),
                validator: (val) => val == null || val.isEmpty ? 'Veuillez choisir une catégorie' : null,
                onChanged: (val) => setState(() => _category = val),
                onSaved: (val) => _category = val,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitVideo,
                  icon: const Icon(Icons.send),
                  label: const Text('Publier la vidéo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
