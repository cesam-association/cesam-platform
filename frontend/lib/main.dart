import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'constants/colors.dart';
import 'models/registration_data.dart';
import 'models/cesam_user.dart'; // ✅ Ajout du modèle utilisateur
import 'screens/login_page.dart';
import 'screens/main_screen.dart';
import 'pages/profile_page.dart';

// Imports des étapes du formulaire d’inscription
import 'screens/register/step1_personal_info.dart';
import 'screens/register/step2_academic_info.dart';
import 'screens/register/step3_upload_cv.dart';
import 'screens/register/step4_amci.dart';
import 'screens/register/step5_email_verification.dart';
import 'screens/register/step6_waiting_admin.dart';

// Import de la nouvelle page "Bourse AMCI"
import 'options/amci_code_page.dart';

void main() {
  runApp(const CesamApp());
}

class CesamApp extends StatelessWidget {
  const CesamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CESAM',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,

      onGenerateRoute: (settings) {
        final args = settings.arguments;

        if (settings.name == AppRoutes.main && args is CesamUser) {
          return MaterialPageRoute(
            builder: (_) => MainScreen(user: args), // ✅ MainScreen avec user
          );
        }

        switch (settings.name) {
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginPage());

          case AppRoutes.profile:
            return MaterialPageRoute(builder: (_) => ProfilePage(user: CesamUser(name: 'Invité', email: '', isAdmin: false)));


          case AppRoutes.registerStep1:
            return MaterialPageRoute(
              builder: (_) => Step1PersonalInfo(
                data: args is RegistrationData ? args : RegistrationData(),
              ),
            );

          case AppRoutes.registerStep2:
            return MaterialPageRoute(
              builder: (_) => Step2AcademicInfo(
                data: args is RegistrationData ? args : RegistrationData(),
              ),
            );

          case AppRoutes.registerStep3:
            return MaterialPageRoute(
              builder: (_) => Step3UploadCV(
                data: args is RegistrationData ? args : RegistrationData(),
              ),
            );

          case AppRoutes.registerStep4:
            return MaterialPageRoute(
              builder: (_) => Step4AMCI(
                data: args is RegistrationData ? args : RegistrationData(),
              ),
            );

          case AppRoutes.registerStep5:
            return MaterialPageRoute(
              builder: (_) => Step5EmailVerification(
                data: args is RegistrationData ? args : RegistrationData(),
              ),
            );

          case AppRoutes.registerStep6:
            return MaterialPageRoute(
              builder: (_) => const Step6WaitingAdmin(),
            );

          case AppRoutes.amciCode:
            return MaterialPageRoute(
              builder: (_) => const AmciCodePage(),
            );

          default:
            return null; // Route non reconnue
        }
      },

      theme: ThemeData(
        primaryColor: CesamColors.primary,
        scaffoldBackgroundColor: CesamColors.background,
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CesamColors.primary,
          background: CesamColors.background,
        ),
      ),
    );
  }
}
