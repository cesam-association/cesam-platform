import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AdminExcelUploadPage extends StatefulWidget {
  const AdminExcelUploadPage({super.key});

  @override
  State<AdminExcelUploadPage> createState() => _AdminExcelUploadPageState();
}

class _AdminExcelUploadPageState extends State<AdminExcelUploadPage> {
  String? _fileName;

  void _pickFile() {
    setState(() {
      _fileName = "fichier_bourses.xlsx"; // Simulé
    });
  }

  void _uploadFile() {
    if (_fileName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner un fichier")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Fichier $_fileName uploadé avec succès !")),
    );
    setState(() => _fileName = null); // Reset
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Envoyer fichier Excel bourse', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Sélection du fichier Excel"),
            const SizedBox(height: 12),
            _buildFileCard(),
            const SizedBox(height: 24),
            _buildSectionTitle("Envoi vers la base de données"),
            const SizedBox(height: 12),
            const Text(
              "Ce fichier doit contenir la liste des étudiants boursiers au format .xlsx. Il sera traité automatiquement côté serveur.",
              style: TextStyle(fontSize: 15, color: CesamColors.textSecondary),
            ),
            const SizedBox(height: 80), // pour ne pas être caché par le bouton
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ElevatedButton.icon(
            onPressed: _uploadFile,
            icon: const Icon(Icons.upload_file, color: Colors.white),
            label: const Text(
              'Uploader le fichier',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: CesamColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CesamColors.textPrimary,
        ),
      );

  Widget _buildFileCard() => Card(
        color: CesamColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(Icons.insert_drive_file, color: CesamColors.primary),
          title: Text(
            _fileName ?? 'Aucun fichier sélectionné',
            style: const TextStyle(color: CesamColors.textPrimary),
          ),
          trailing: TextButton(
            onPressed: _pickFile,
            style: TextButton.styleFrom(foregroundColor: CesamColors.primary),
            child: const Text('Parcourir'),
          ),
        ),
      );
}
