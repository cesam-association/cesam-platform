import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../components/cesam_app_bar.dart';
import '../components/page_header.dart';
import '../options/adhesion_paiement_page.dart';
import '../options/amci_code_page.dart';
import '../pages/profile_page.dart';
import '../options/stage_emploi_page.dart';
import '../options/pfe_database_page.dart';
import '../models/cesam_user.dart'; 
import '../admin/admin_applicants_page.dart';
import '../admin/admin_offer_submission_page.dart';
import '../admin/admin_quotes_page.dart';
import '../admin/admin_video_submission_page.dart';
import '../options/guides_poursuite_etudes_page.dart';
import '../admin/admin_excel_upload_page.dart';
import '../admin/admin_user_list_page.dart';
import '../options/tv_channel_page.dart';
import '../admin/admin_pfe_page.dart';


class ServicesPage extends StatefulWidget {
  final CesamUser user;

  const ServicesPage({super.key, required this.user});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  String? selectedServiceTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: const CesamAppBar(title: 'Services'),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPersistentHeader(
            pinned: true,
            delegate: _HeaderDelegate(
              height: 60,
              child: Container(
                color: CesamColors.background,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: const PageHeaderWithAvatar(title: 'Services'),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              if (widget.user.isAdmin) ...[
                _buildSectionTitle(' Administration'),
                _buildAdminTile('Gérer les utilisateurs', Icons.admin_panel_settings, () {
                  setState(() {
                    selectedServiceTitle = 'Gérer les utilisateurs';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AdminUserListPage(users: [])));
                }),
                                _buildAdminTile('PFE : valider / publier', Icons.library_add_check, () {
                  setState(() {
                    selectedServiceTitle = 'PFE : valider / publier';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminPfePage()));
                }),

                _buildAdminTile('Candidatures', Icons.description, () {
                  setState(() {
                    selectedServiceTitle = 'Candidatures';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminApplicantsPage()));
                }),
                _buildAdminTile('Envoyer fichier Excel bourse', Icons.file_upload, () {
                  setState(() {
                    selectedServiceTitle = 'Envoyer fichier Excel bourse';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminExcelUploadPage()));
                }),
                _buildAdminTile('Envoyer offres d\'emploi', Icons.work_outline, () {
                  setState(() {
                    selectedServiceTitle = 'Envoyer offres d\'emploi';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminOfferSubmissionPage()));
                }),
                _buildAdminTile('Gérer les citations', Icons.format_quote, () {
                  setState(() {
                    selectedServiceTitle = 'Gérer les citations';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminQuotesPage()));
                }),
                _buildAdminTile('Publier vidéos', Icons.ondemand_video, () {
                  setState(() {
                    selectedServiceTitle = 'Publier vidéos';
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminVideoSubmissionPage()));
                }),
                _buildAdminTile('Ajouter documents', Icons.insert_drive_file, () {
                  // TODO
                }),
              ],
              _buildSectionTitle('Adhésion & Compte'),
              _buildServiceTile('Comptes utilisateurs', Icons.person, context, ProfilePage(user: widget.user, showSkillsSectionOnly: false)),
              _buildServiceTile('Adhésions & Paiements', Icons.credit_card, context, const AdhesionPaiementPage()),
              _buildServiceTile('Logement', Icons.home, context),
              _buildSectionTitle('Associations & Communautés'),
              _buildServiceTile('Communautés étudiantes', Icons.groups, context),
              _buildServiceTile('Espace AMCI', Icons.school, context),
              _buildServiceTile('Espace publicitaire étudiant', Icons.campaign, context),
              _buildServiceTile('Orientation post-études', Icons.directions, context),
              _buildSectionTitle('Études & Carrière'),
              _buildServiceTile('Formations & Écoles', Icons.book, context),
              _buildServiceTile('Base de données PFE / Thèses', Icons.library_books, context, const PfeDatabasePage()),
              _buildServiceTile('Code de Bourses', Icons.description, context, const AmciCodePage()),
              _buildServiceTile('Stages & Emplois', Icons.work, context, const StageEmploiPage()),
              _buildServiceTile('Catalogue des entreprises', Icons.business_center, context),
              _buildServiceTile('Guides pour la poursuite d’études', Icons.school_outlined, context, const GuidesPoursuiteEtudesPage()),
              _buildSectionTitle('Réseautage & Échange'),
              _buildServiceTile('Échange entre étudiants', Icons.chat, context),
              _buildServiceTile('Valorisation des compétences', Icons.star, context, ProfilePage(user: widget.user, showSkillsSectionOnly: true)),
              _buildSectionTitle('Culture & Bien-être'),
              _buildServiceTile('Chaîne TV étudiante', Icons.live_tv, context, const TvChannelPage()),

              _buildServiceTile('Documentaires & Films', Icons.movie, context),
              _buildServiceTile('Motivations matinales', Icons.wb_sunny, context),
              _buildServiceTile('Loisirs et tourisme', Icons.local_activity, context),
              _buildServiceTile('Scores de matchs', Icons.sports_soccer, context),
              const SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CesamColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildServiceTile(String title, IconData icon, BuildContext context, [Widget? targetPage]) {
    final bool isSelected = selectedServiceTitle == title;
    final Color iconColor = isSelected ? CesamColors.primary : CesamColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: CesamColors.cardBackground,
        child: ListTile(
          leading: Icon(icon, color: iconColor, size: 26),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: CesamColors.textPrimary,
            ),
          ),
          onTap: () {
            setState(() {
              selectedServiceTitle = title;
            });
            if (targetPage != null) {
              Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage!));
            }
          },
        ),
      ),
    );
  }

  Widget _buildAdminTile(String title, IconData icon, VoidCallback onTap) {
    final bool isSelected = selectedServiceTitle == title;
    final Color iconColor = isSelected ? CesamColors.primary : CesamColors.textSecondary;
    final Color textColor = isSelected ? CesamColors.primary : CesamColors.textSecondary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: CesamColors.cardBackground.withOpacity(0.98),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  _HeaderDelegate({required this.child, this.height = 60});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
