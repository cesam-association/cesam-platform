class RegistrationData {
  String fullName;
  String email;
  String password;
  String role;

  String phone;
  String nationality;
  String academicLevel;
  String studyField;
  String emergencyContactName;
  String emergencyContactPhone;

  bool hasCV;
  bool isAmci;
  String? photoPath;

  String ecole;
  String filiere;
  String niveau;

  String? cvFilePath;

  String? amciCode;

  bool emailVerified;
  String? skills;
  String? projects;


  RegistrationData({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.role = '',
    this.phone = '',
    this.nationality = '',
    this.academicLevel = '',
    this.studyField = '',
    this.emergencyContactName = '',
    this.emergencyContactPhone = '',
    this.hasCV = false,
    this.isAmci = false,
    this.photoPath,
    this.ecole = '',
    this.filiere = '',
    this.niveau = '',
    this.cvFilePath,
    this.amciCode,
    this.emailVerified = false,
    this.skills='',
    this.projects=''

  });
}
