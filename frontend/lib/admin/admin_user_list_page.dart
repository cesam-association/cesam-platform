import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/cesam_user.dart';

class AdminUserListPage extends StatelessWidget {
  final List<CesamUser> users;

  const AdminUserListPage({super.key, this.users = const []});

  List<CesamUser> _getMockUsers() {
    return [
      CesamUser(name: 'Amina Diallo', email: 'amina@cesam.com', isAdmin: false, phone: '0601020304'),
      CesamUser(name: 'Mohamed El Amrani', email: 'mohamed@cesam.com', isAdmin: false, phone: '0602030405'),
      CesamUser(name: 'Fatou Bensouda', email: 'fatou@cesam.com', isAdmin: false, phone: '0603040506'),
      CesamUser(name: 'Jean-Pierre Mbemba', email: 'jp@cesam.com', isAdmin: false, phone: '0604050607'),
      CesamUser(name: 'Admin CESAM', email: 'admin@cesam.com', isAdmin: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final userList = users.isNotEmpty ? users : _getMockUsers();

    return Scaffold(
      backgroundColor: CesamColors.background,
      appBar: AppBar(
        title: const Text(
          'Gestion des utilisateurs',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: CesamColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            color: CesamColors.cardBackground,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: CesamColors.primary.withOpacity(0.2),
                child: Text(
                  user.name.isNotEmpty ? user.name[0] : '?',
                  style: TextStyle(color: CesamColors.primary),
                ),
              ),
              title: Text(
                user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${user.email}${user.isAdmin ? ' • Admin' : ''}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  // 👇 Simuler une action plus tard
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Action "$value" sur ${user.name}')),
                  );
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'validate', child: Text('Valider')),
                  const PopupMenuItem(value: 'delete', child: Text('Supprimer')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
