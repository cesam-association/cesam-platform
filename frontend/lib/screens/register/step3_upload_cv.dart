import 'package:flutter/material.dart';
import '../../../models/registration_data.dart';
import '../../../constants/colors.dart';
import '../../../components/auth_scaffold.dart';
import '../../app_routes.dart';

class Step3UploadCV extends StatefulWidget {
  final RegistrationData data;

  const Step3UploadCV({super.key, required this.data});

  @override
  State<Step3UploadCV> createState() => _Step3UploadCVState();
}

class _Step3UploadCVState extends State<Step3UploadCV> {
  bool _cvSelected = false;

  final List<String> _skills = [];
  final List<String> _projects = [];

  final TextEditingController _skillController = TextEditingController();
  final TextEditingController _projectController = TextEditingController();

  void _simulateCVSelection() {
    setState(() {
      _cvSelected = true;
      widget.data.cvFilePath = 'fake_path/cv_etudiant.pdf';
    });
  }

  void _addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty) {
      setState(() {
        _skills.add(skill);
        _skillController.clear();
      });
    }
  }

  void _addProject() {
    final project = _projectController.text.trim();
    if (project.isNotEmpty) {
      setState(() {
        _projects.add(project);
        _projectController.clear();
      });
    }
  }

  void _goToNextStep() {
    widget.data.skills = _skills.join(', ');
    widget.data.projects = _projects.join(', ');

    Navigator.pushNamed(
      context,
      AppRoutes.registerStep4,
      arguments: widget.data,
    );
  }

  @override
  void dispose() {
    _skillController.dispose();
    _projectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Étape 3 - CV et Compétences (optionnel)',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Souhaitez-vous ajouter un CV ?", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _simulateCVSelection,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Choisir un fichier'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                if (_cvSelected)
                  const Text("CV sélectionné ✔️", style: TextStyle(color: Colors.green)),
              ],
            ),
            const SizedBox(height: 32),

            const Text("Compétences", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _skillController,
                    decoration: const InputDecoration(
                      hintText: 'Ex: Flutter, Firebase...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addSkill,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.accent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Ajouter"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._skills.map((skill) => ListTile(
                  title: Text(skill),
                  leading: const Icon(Icons.check_circle_outline),
                )),

            const SizedBox(height: 24),
            const Text("Projets réalisés", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _projectController,
                    decoration: const InputDecoration(
                      hintText: 'Ex: App gestion de stock...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addProject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CesamColors.accent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Ajouter"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._projects.map((proj) => ListTile(
                  title: Text(proj),
                  leading: const Icon(Icons.folder_open),
                )),

            const SizedBox(height: 32),
            const Text(
              "⚠️ Tous ces champs sont facultatifs. Vous pourrez compléter ou modifier vos informations plus tard.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _goToNextStep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CesamColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Suivant', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
