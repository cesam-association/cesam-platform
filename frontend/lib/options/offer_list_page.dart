import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'offer_detail_page.dart';

class OfferListPage extends StatelessWidget {
  final bool isStage;

  const OfferListPage({super.key, required this.isStage});

  @override
  Widget build(BuildContext context) {
    final title = isStage ? 'Offres de stage' : 'Offres d\'emploi';
    final offers = isStage ? _dummyStages : _dummyJobs;

    return Scaffold(
  backgroundColor: CesamColors.background,
  appBar: AppBar(
    backgroundColor: CesamColors.background, // 👈 fond clair
    elevation: 0,
    title: Text(
      title,
      style: const TextStyle(color: Colors.black), // 👈 texte noir
    ),
    iconTheme: const IconThemeData(color: Colors.black), // 👈 icône (retour) noir
  ),
  body: ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: offers.length,
    itemBuilder: (context, index) {
      final offer = offers[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.work_outline, color: CesamColors.primary),
                title: Text(offer['title']!),
                subtitle: Text('Publié le ${offer['date']!}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OfferDetailPage(
                        title: offer['title']!,
                        date: offer['date']!,
                        description: offer['description'] ?? 'Aucune description fournie.',
                        imageUrls: List<String>.from(offer['images'] ?? []),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.primary,
                    foregroundColor: Colors.white, // ✅ texte & icône blancs
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4, // ✅ optionnel : petite ombre
                  ),
                  onPressed: () {
                    _showConfirmationDialog(context, offer['title']!);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Postuler'),
                ),
              )
            ],
          ),
        ),
      );
    },
  ),
);

  }

  void _showConfirmationDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Votre candidature pour "$title" a été envoyée.'),
        actions: [
          TextButton(
            child: const Text('OK', style: TextStyle(color: CesamColors.primary)),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> _dummyStages = [
  {
    'title': 'Stage en développement Flutter',
    'date': '15 juillet 2025',
    'description': 'Ce stage vous permettra de développer une vraie app Flutter, de participer à des réunions agiles, et d’améliorer vos compétences en UI/UX.',
    'images': [],
  },
  {
    'title': 'Stage marketing digital',
    'date': '12 juillet 2025',
    'description': 'Nous cherchons un stagiaire pour animer les réseaux sociaux, analyser les campagnes et produire des contenus engageants.',
    'images': ['https://via.placeholder.com/150'],
  },
];

final List<Map<String, dynamic>> _dummyJobs = [
  {
    'title': 'Développeur junior (CDI)',
    'date': '10 juillet 2025',
    'description': 'Poste basé à Casablanca. Technologies principales : Flutter, Firebase, Git. Équipe jeune et dynamique.',
    'images': ['https://via.placeholder.com/150', 'https://via.placeholder.com/150'],
  },
  {
    'title': 'Chargé de communication',
    'date': '8 juillet 2025',
    'description': 'Communication interne/externe, rédaction de contenu, gestion d’événements. Une belle opportunité dans une entreprise tech.',
    'images': [],
  },
];
