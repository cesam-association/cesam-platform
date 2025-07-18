import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/auth_scaffold.dart';

class AmciCodePage extends StatefulWidget {
  const AmciCodePage({super.key});

  @override
  State<AmciCodePage> createState() => _AmciCodePageState();
}

class _AmciCodePageState extends State<AmciCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();

  bool _showResult = false;

  // Dummy data simulée
  final Map<String, Map<String, String>> _amciData = {
    '20251234': {
      'nom': 'Fatou NDIAYE',
      'pays': 'Sénégal',
      'code': '3646|9342'
    },
    '20259876': {
      'nom': 'Youssef BOUAZZA',
      'pays': 'Maroc',
      'code': '1425|4561'
    },
  };

  Map<String, String>? _result;

  void _handleLookup() {
    if (_formKey.currentState!.validate()) {
      final matricule = _matriculeController.text.trim();
      final found = _amciData[matricule];

      setState(() {
        _result = found;
        _showResult = true;
      });
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
      title: 'Bourse AMCI',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Récupérez votre code en toute simplicité',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _matriculeController,
              decoration: _inputDecoration('Entrer votre matricule', Icons.badge_outlined),
              validator: (val) => val != null && val.isNotEmpty ? null : 'Veuillez entrer un matricule',
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _handleLookup,
                child: const Text(
                  'Récupérer votre code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_showResult)
              _result != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Résultat de la recherche :',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Table(
                          border: TableBorder.all(color: Colors.black26),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(2),
                            2: FlexColumnWidth(2),
                          },
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(color: CesamColors.primary),
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Nom & Prénom', style: TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Pays', style: TextStyle(color: Colors.white)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Code de Bourse', style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_result!['nom'] ?? ''),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_result!['pays'] ?? ''),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(_result!['code'] ?? ''),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Text(
                      "Aucun code trouvé pour ce matricule.",
                      style: TextStyle(color: Colors.red),
                    ),
          ],
        ),
      ),
    );
  }
}
