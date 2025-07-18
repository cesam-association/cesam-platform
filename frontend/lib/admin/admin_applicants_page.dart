import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Applicant {
  final String name;
  final String email;
  final String appliedPosition;
  final String cvUrl;

  Applicant({
    required this.name,
    required this.email,
    required this.appliedPosition,
    required this.cvUrl,
  });
}

class AdminApplicantsPage extends StatefulWidget {
  const AdminApplicantsPage({super.key});

  @override
  State<AdminApplicantsPage> createState() => _AdminApplicantsPageState();
}

class _AdminApplicantsPageState extends State<AdminApplicantsPage> {
  final List<Applicant> applicants = [
    Applicant(
      name: 'Jean Dupont',
      email: 'jean@cesam.com',
      appliedPosition: 'Stage en IA',
      cvUrl: 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf',
    ),
    Applicant(
      name: 'Sarah K.',
      email: 'sarah@cesam.com',
      appliedPosition: 'Dev Web Frontend',
      cvUrl: 'https://gahp.net/wp-content/uploads/2017/09/sample.pdf',
    ),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredApplicants = applicants.where((app) {
      final query = _searchQuery.toLowerCase();
      return app.name.toLowerCase().contains(query) ||
             app.email.toLowerCase().contains(query) ||
             app.appliedPosition.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Candidatures reçues', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher un candidat...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: CesamColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredApplicants.length,
                itemBuilder: (context, index) {
                  final app = filteredApplicants[index];
                  return Card(
                    color: CesamColors.cardBackground,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: CesamColors.primary.withOpacity(0.2),
                        child: Text(app.name[0], style: const TextStyle(color: CesamColors.primary)),
                      ),
                      title: Text('${app.name} - ${app.appliedPosition}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(app.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.picture_as_pdf),
                            onPressed: () => launchUrl(Uri.parse(app.cvUrl), mode: LaunchMode.externalApplication),
                          ),
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Candidat ${app.name} accepté.')),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Candidat ${app.name} rejeté.')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
