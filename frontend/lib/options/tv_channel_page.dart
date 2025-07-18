import 'package:flutter/material.dart';
import '../constants/colors.dart';

class TvChannelPage extends StatefulWidget {
  const TvChannelPage({super.key});

  @override
  State<TvChannelPage> createState() => _TvChannelPageState();
}

class _TvChannelPageState extends State<TvChannelPage> {
  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Motivation du jour 🎓',
      'url': 'https://samplelib.com/lib/preview/mp4/sample-5s.mp4',
      'likes': 12,
      'liked': false,
      'thumbnail': 'https://img.youtube.com/vi/2Vv-BfVoq4g/0.jpg',
    },
    {
      'title': 'Interview Étudiante AMCI 🌍',
      'url': 'https://samplelib.com/lib/preview/mp4/sample-10s.mp4',
      'likes': 21,
      'liked': false,
      'thumbnail': 'https://img.youtube.com/vi/ScMzIvxBSi4/0.jpg',
    },
    {
      'title': 'Conseils d\'études à l\'étranger ✈️',
      'url': 'https://samplelib.com/lib/preview/mp4/sample-15s.mp4',
      'likes': 34,
      'liked': false,
      'thumbnail': 'https://img.youtube.com/vi/fLexgOxsZu0/0.jpg',
    },
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    final filteredVideos = videos.where((video) => video['title'].toLowerCase().contains(search.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
  backgroundColor: CesamColors.background, // Couleur de fond blanche bleutée
  elevation: 0, // Supprime l’ombre sous l’AppBar pour un look plus léger
  iconTheme: const IconThemeData(color: Colors.black), // Icônes en noir
  title: Text(
    'Chaîne TV Étudiante',
    style: const TextStyle(color: Colors.black), // Titre en noir
  ),
  centerTitle: true,
),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => search = value),
              decoration: InputDecoration(
                hintText: 'Rechercher une vidéo...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                final video = filteredVideos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Simulated video thumbnail
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          video['thumbnail'],
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                video['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                video['liked'] ? Icons.favorite : Icons.favorite_border,
                                color: video['liked'] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  video['liked'] = !video['liked'];
                                  video['likes'] += video['liked'] ? 1 : -1;
                                });
                              },
                            ),
                            Text('${video['likes']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
