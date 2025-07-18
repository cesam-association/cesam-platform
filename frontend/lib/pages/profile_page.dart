import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/cesam_app_bar.dart';
import '../models/cesam_user.dart';

class ProfilePage extends StatelessWidget {
  final CesamUser user;
  final bool showSkillsSectionOnly;

  const ProfilePage({
    super.key,
    required this.user,
    this.showSkillsSectionOnly = false,
  });

  List<String> _parseList(String? data) {
    return (data ?? '').split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Données simulées pour l'affichage
    final fakeUser = CesamUser(
      name: 'Fatima El Idrissi',
      email: 'fatima.idrissi@exemple.com',
      phone: '+212 612 345 678',
      nationality: 'Maroc',
      studyField: 'Informatique',
      academicLevel: 'Master 2',
      isAmci: true,
      emergencyContact: 'Mère - +212 622 334 556',
      skills: 'Flutter, UI/UX Design, Firebase',
      projects: 'Application CESAM, Portfolio personnel, Bot Telegram',
      hasCV: true,
      photoPath: '',
      isAdmin: false,
    );

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: const CesamAppBar(title: ''),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Avatar et nom
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const SweepGradient(
                      colors: [
                        CesamColors.primary,
                        CesamColors.accent,
                        CesamColors.primary,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: CesamColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: (fakeUser.photoPath != null && fakeUser.photoPath!.isNotEmpty)
                        ? AssetImage(fakeUser.photoPath!) as ImageProvider
                        : null,
                    child: (fakeUser.photoPath == null || fakeUser.photoPath!.isEmpty)
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Center(
                child: Text(
                  fakeUser.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CesamColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  fakeUser.email,
                  style: const TextStyle(fontSize: 14, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 16),

              if (!showSkillsSectionOnly)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.lock_outline, size: 18),
                      label: const Text("Modifier le mot de passe"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CesamColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CesamColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Partie 1 : Infos utilisateur (nom/prenom/pays/AMCI)
                    if (!showSkillsSectionOnly) ...[
                      _infoRow(Icons.flag, fakeUser.nationality!),
                      _infoRow(Icons.verified_user, fakeUser.isAmci! ? 'Affilié AMCI' : 'Non affilié AMCI'),
                    ],

                    // ✅ Partie 2 : Valorisation de compétences
                    if (showSkillsSectionOnly) ...[
                      _infoRow(Icons.category, fakeUser.studyField!),
                      Row(
                        children: [
                          Expanded(child: _infoRow(Icons.school, fakeUser.academicLevel!)),
                          IconButton(
                            icon: const Icon(Icons.edit, color: CesamColors.primary),
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Compétences", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          IconButton(
                            icon: const Icon(Icons.edit, color: CesamColors.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _parseList(fakeUser.skills).map((skill) => Chip(
                          label: Text(skill),
                          backgroundColor: CesamColors.primary.withOpacity(0.1),
                          labelStyle: const TextStyle(color: CesamColors.primary),
                        )).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text("Projets réalisés", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _parseList(fakeUser.projects).map((project) => Chip(
                          label: Text(project),
                          backgroundColor: CesamColors.primary.withOpacity(0.1),
                          labelStyle: const TextStyle(color: CesamColors.primary),
                        )).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text("CV", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.picture_as_pdf, color: CesamColors.primary),
                          const SizedBox(width: 12),
                          const Text("CV fourni", style: TextStyle(fontSize: 16, color: Colors.black87)),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.edit, color: CesamColors.primary),
                            onPressed: () {},
                          ),
                        ],
                      )
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),
              if (!showSkillsSectionOnly) _flatActionTile(Icons.help_outline, 'Aide / Contact CESAM'),
              if (!showSkillsSectionOnly) _flatActionTile(Icons.logout, 'Déconnexion'),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: CesamColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _flatActionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: CesamColors.primary),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
