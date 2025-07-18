import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../constants/colors.dart';
import 'submit_pfe_form_page.dart';

class PfeDatabasePage extends StatefulWidget {
  const PfeDatabasePage({super.key});

  @override
  State<PfeDatabasePage> createState() => _PfeDatabasePageState();
}

class _PfeDatabasePageState extends State<PfeDatabasePage> {
  final List<Map<String, String>> _allReports = [
    {
      'title': 'Optimisation Flutter pour mobile',
      'author': 'Michelle Razafindrakoto',
      'year': '2025',
      'summary': 'Étude approfondie sur la performance des apps Flutter.',
      'pdfUrl': 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    },
    {
      'title': 'Analyse marketing digital',
      'author': 'Jean Dupont',
      'year': '2024',
      'summary': 'Rapport sur les stratégies digitales pour PME.',
      'pdfUrl': 'https://www.orimi.com/pdf-test.pdf',
    },
    {
      'title': 'Intelligence artificielle et éthique',
      'author': 'Fatou Ndiaye',
      'year': '2023',
      'summary': 'Réflexion sur les impacts sociétaux de l\'IA.',
      'pdfUrl': 'https://gahp.net/wp-content/uploads/2017/09/sample.pdf',
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredReports = _allReports.where((report) {
      final searchLower = _searchQuery.toLowerCase();
      return report['title']!.toLowerCase().contains(searchLower) ||
          report['author']!.toLowerCase().contains(searchLower);
    }).toList();

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Base de données PFE / Thèses', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Recherche par titre ou auteur',
                hintStyle: TextStyle(color: CesamColors.textSecondary),
                prefixIcon: const Icon(Icons.search, color: CesamColors.textSecondary),
                filled: true,
                fillColor: CesamColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() {
                _searchQuery = value;
              }),
            ),
          ),
          const SizedBox(height: 16),
          ...filteredReports.map((report) {
            return Card(
              color: CesamColors.cardBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: ExpansionTile(
                title: Text(report['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${report['author']} - ${report['year']}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Text(report['summary']!),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Ouvrir le PDF'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PdfViewerPage(
                            title: report['title']!,
                            pdfUrl: report['pdfUrl']!,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SubmitPfeFormPage()),
              );
            },
            icon: const Icon(Icons.upload_file),
            label: const Text('Soumettre un PFE / PFA'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CesamColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String title;
  final String pdfUrl;

  const PdfViewerPage({super.key, required this.title, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SfPdfViewer.network(pdfUrl),
    );
  }
}
