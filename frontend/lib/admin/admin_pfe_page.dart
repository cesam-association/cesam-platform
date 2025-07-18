import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/colors.dart';
import 'pdf_viewer_page.dart';

class AdminPfePage extends StatefulWidget {
  const AdminPfePage({super.key});

  @override
  State<AdminPfePage> createState() => _AdminPfePageState();
}

class _AdminPfePageState extends State<AdminPfePage> {
  final List<Map<String, dynamic>> pfeList = [
    {
      'title': "Développement d'une application mobile CESAM",
      'student': 'Fatoumata Dia',
      'url': 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      'status': 'en attente',
    },
    {
      'title': 'Analyse des données scolaires au Maroc',
      'student': 'Omar El Mehdi',
      'url': 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      'status': 'en attente',
    },
  ];

  void _viewPfePDF(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PdfViewerPage(url: url)),
    );
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      pfeList[index]['status'] = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Validation des PFE', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: pfeList.length,
          itemBuilder: (context, index) {
            final pfe = pfeList[index];
            return Card(
              color: CesamColors.cardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Ligne info + bouton PDF
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Infos à gauche
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pfe['title'],
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text('Étudiant : ${pfe['student']}'),
                              const SizedBox(height: 4),
                              Text(
                                'Statut : ${pfe['status']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: pfe['status'] == 'accepté'
                                      ? Colors.green
                                      : pfe['status'] == 'refusé'
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Bouton Lire PDF à droite
                        _buildActionButton(
                          label: 'Lire PDF',
                          icon: Icons.picture_as_pdf,
                          color: Colors.indigo,
                          onPressed: () => _viewPfePDF(pfe['url']),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Boutons en bas
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            label: 'Accepter',
                            icon: Icons.check,
                            color: Colors.green,
                            onPressed: () => _updateStatus(index, 'accepté'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            label: 'Refuser',
                            icon: Icons.close,
                            color: Colors.redAccent,
                            onPressed: () => _updateStatus(index, 'refusé'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 3,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
