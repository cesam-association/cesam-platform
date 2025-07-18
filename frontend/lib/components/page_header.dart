// lib/components/page_header_with_avatar.dart
import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PageHeaderWithAvatar extends StatelessWidget {
  final String title;

  const PageHeaderWithAvatar({super.key, required this.title});

  void _showUserMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
  radius: 24,
  backgroundColor: CesamColors.primary, // fond contrasté
  child: Text(
    'ED',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
),

                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edouard Diallo',
                        style: TextStyle(color: Colors.black87, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: const Text(
                          'Voir le profil',
                          style: TextStyle(
                            color: CesamColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.black12),
              const SizedBox(height: 8),
              _UserMenuItem(
                icon: Icons.person_add,
                label: 'Ajouter un compte',
                onTap: () => Navigator.pop(context),
              ),
              _UserMenuItem(
                icon: Icons.bolt,
                label: 'Nouveautés',
                onTap: () => Navigator.pop(context),
              ),
              _UserMenuItem(
                icon: Icons.access_time,
                label: 'Récents',
                onTap: () => Navigator.pop(context),
              ),
              _UserMenuItem(
                icon: Icons.settings,
                label: 'Préférences et confidentialité',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CesamColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: () => _showUserMenu(context),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: CesamColors.primary,
              child: Text(
                'ED',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _UserMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(label, style: const TextStyle(color: Colors.black87)),
      onTap: onTap,
    );
  }
}
