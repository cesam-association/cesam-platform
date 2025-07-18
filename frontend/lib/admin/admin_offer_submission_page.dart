import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AdminOfferSubmissionPage extends StatefulWidget {
  const AdminOfferSubmissionPage({super.key});

  @override
  State<AdminOfferSubmissionPage> createState() => _AdminOfferSubmissionPageState();
}

class _AdminOfferSubmissionPageState extends State<AdminOfferSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _details = '';
  List<String> _imageUrls = [];

  final _imageController = TextEditingController();

  void _addImage() {
    final url = _imageController.text.trim();
    if (url.isNotEmpty) {
      setState(() {
        _imageUrls.add(url);
        _imageController.clear();
      });
    }
  }

  void _submitOffer() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Offre envoyée avec succès !")),
      );
      // TODO: envoyer au backend ou base de données
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Envoyer une offre', style: TextStyle(color: Colors.black)),
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
                  labelText: 'Titre de l\'offre',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => _title = val ?? '',
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Détails de l\'offre',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (val) => val == null || val.isEmpty ? 'Champ requis' : null,
                onSaved: (val) => _details = val ?? '',
              ),
              const SizedBox(height: 20),
              const Text('Photos (liens facultatifs)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _imageController,
                      decoration: InputDecoration(
                        hintText: 'URL de l\'image',
                        filled: true,
                        fillColor: CesamColors.cardBackground,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: CesamColors.primary),
                    onPressed: _addImage,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _imageUrls.map((url) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(url, height: 80, width: 80, fit: BoxFit.cover),
                )).toList(),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitOffer,
                  icon: const Icon(Icons.send),
                  label: const Text('Publier l\'offre'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
