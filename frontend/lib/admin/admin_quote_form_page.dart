import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'admin_quotes_page.dart'; // Pour l'objet Quote

class AdminQuoteFormPage extends StatefulWidget {
  final Quote? existingQuote;
  final int? index;

  const AdminQuoteFormPage({super.key, this.existingQuote, this.index});

  @override
  State<AdminQuoteFormPage> createState() => _AdminQuoteFormPageState();
}

class _AdminQuoteFormPageState extends State<AdminQuoteFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _textController;
  late TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.existingQuote?.text ?? '');
    _authorController = TextEditingController(text: widget.existingQuote?.author ?? '');
  }

  @override
  void dispose() {
    _textController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newQuote = Quote(
      text: _textController.text.trim(),
      author: _authorController.text.trim(),
      submittedBy: widget.existingQuote?.submittedBy ?? 'AdminMichelle', // ou récupérer admin courant
      isPublished: widget.existingQuote?.isPublished ?? false,
    );

    Navigator.pop(context, {'quote': newQuote, 'index': widget.index});
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingQuote != null;
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier une citation' : 'Ajouter une citation', style: const TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _textController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Texte de la citation',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Auteur',
                  filled: true,
                  fillColor: CesamColors.cardBackground,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.primary,
                    foregroundColor: Colors.white, // texte blanc
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(isEditing ? 'Modifier' : 'Ajouter', style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
