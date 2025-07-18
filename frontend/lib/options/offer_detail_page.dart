import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class OfferDetailPage extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final List<String> imageUrls;

  const OfferDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: CesamColors.background,
  appBar: AppBar(
    backgroundColor: CesamColors.background, // 👈 fond uniforme
    elevation: 0,
    title: const Text(
      'Détail de l\'offre',
      style: TextStyle(color: Colors.black), // 👈 texte noir
    ),
    iconTheme: const IconThemeData(color: Colors.black), // 👈 flèche de retour noire
  ),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Publié le $date', style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 16),
        Text(description, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 16),
        if (imageUrls.isNotEmpty) ...[
          const Text('Photos :', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrls[index],
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
        Center(
          child: ElevatedButton.icon(
            onPressed: () => _showConfirmationDialog(context),
            icon: const Icon(Icons.send),
            label: const Text('Postuler'),
            style: ElevatedButton.styleFrom(
              backgroundColor: CesamColors.primary,
              foregroundColor: Colors.white, // ✅ bien lisible
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 4,
            ),
          ),
        ),
      ],
    ),
  ),
);

  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmation'),
        content: Text('Votre candidature pour "$title" a été envoyée.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK', style: TextStyle(color: CesamColors.primary)),
          )
        ],
      ),
    );
  }
}
