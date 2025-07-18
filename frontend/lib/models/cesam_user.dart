class CesamUser {
  final String name;
  final String email;
  final bool isAdmin;

  final String? phone;
  final String? nationality;
  final String? academicLevel;
  final String? studyField;
  final bool? isAmci;
  final String? emergencyContact; // ex : "Nom – Téléphone"
  final String? skills;           // chaîne séparée par des virgules
  final String? projects;         // idem
  final bool? hasCV;
  final String? photoPath;        // chemin vers image locale

  CesamUser({
    required this.name,
    required this.email,
    this.isAdmin = false,
    this.phone,
    this.nationality,
    this.academicLevel,
    this.studyField,
    this.isAmci,
    this.emergencyContact,
    this.skills,
    this.projects,
    this.hasCV,
    this.photoPath,
  });
}
