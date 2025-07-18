import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'offer_list_page.dart';

class StageEmploiPage extends StatelessWidget {
  const StageEmploiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        backgroundColor: CesamColors.background, // fond appbar en blanc
        elevation: 0,
        title: const Text(
          'Stages & Emplois',
          style: TextStyle(color: Colors.black), // texte noir
        ),
        iconTheme: const IconThemeData(color: Colors.black), // icônes (flèche retour) en noir
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildOptionButton(context, 'Stages', true),
            const SizedBox(height: 20),
            _buildOptionButton(context, 'Emplois', false),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(BuildContext context, String title, bool isStage) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      backgroundColor: CesamColors.primary,          // Fond bleu CESAM
      foregroundColor: Colors.white,                 // Texte + icône en blanc ✅
      minimumSize: const Size(double.infinity, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    icon: Icon(isStage ? Icons.school : Icons.work),
    label: Text(title, style: const TextStyle(fontSize: 18)),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OfferListPage(isStage: isStage),
        ),
      );
    },
  );
}

}
