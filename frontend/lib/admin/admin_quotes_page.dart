import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'admin_quote_form_page.dart'; // <-- nouvelle page formulaire

class Quote {
  final String text;
  final String author;
  final String submittedBy;
  bool isPublished;

  Quote({
    required this.text,
    required this.author,
    required this.submittedBy,
    this.isPublished = false,
  });
}

class AdminQuotesPage extends StatefulWidget {
  const AdminQuotesPage({super.key});

  @override
  State<AdminQuotesPage> createState() => _AdminQuotesPageState();
}

class _AdminQuotesPageState extends State<AdminQuotesPage> {
  final String currentAdmin = 'AdminMichelle';

  final List<Quote> _quotes = [
    Quote(
      text: "Le succès n'est pas final, l'échec n'est pas fatal : c'est le courage de continuer qui compte.",
      author: "Winston Churchill",
      submittedBy: "AdminMichelle",
    ),
    Quote(
      text: "La seule limite à notre épanouissement de demain sera nos doutes d'aujourd'hui.",
      author: "Franklin D. Roosevelt",
      submittedBy: "AdminJohn",
    ),
  ];

  // Remplace _showAddEditDialog par navigation vers la page formulaire
  Future<void> _openQuoteForm({Quote? quote, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminQuoteFormPage(existingQuote: quote, index: index),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        if (result['index'] != null) {
          _quotes[result['index']] = result['quote'];
        } else {
          _quotes.add(result['quote']);
        }
      });
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la citation ?'),
        content: const Text('Cette action est irréversible.'),
        backgroundColor: CesamColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              setState(() {
                _quotes.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(Quote quote, {required bool isPublished}) {
    return Card(
      color: CesamColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text('"${quote.text}"', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('- ${quote.author} • par ${quote.submittedBy}'),
        trailing: isPublished
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    tooltip: "Publier",
                    onPressed: () {
                      setState(() => quote.isPublished = true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Citation publiée !')),
                      );
                    },
                  ),
                  if (quote.submittedBy == currentAdmin) ...[
                    IconButton(
                      icon: const Icon(Icons.edit, color: CesamColors.primary),
                      onPressed: () => _openQuoteForm(quote: quote, index: _quotes.indexOf(quote)),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => _confirmDelete(_quotes.indexOf(quote)),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unpublishedQuotes = _quotes.where((q) => !q.isPublished).toList();
    final publishedQuotes = _quotes.where((q) => q.isPublished).toList();

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text('Gestion des citations', style: TextStyle(color: Colors.black)),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("📝 Citations proposées", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...unpublishedQuotes.map((q) => _buildQuoteCard(q, isPublished: false)).toList(),
          const SizedBox(height: 24),
          const Text("✅ Citations publiées", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...publishedQuotes.map((q) => _buildQuoteCard(q, isPublished: true)).toList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CesamColors.primary,
        onPressed: () => _openQuoteForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
