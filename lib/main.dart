import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqded/core/theme/app_colors.dart';
import 'package:iqded/features/homepage/home_page.dart';
import 'package:iqded/features/quizPage/presentation/bloc/questions_bloc.dart';
import 'package:iqded/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<QuestionsBloc>())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iQ ded',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBlack,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.buttonPurple,
            backgroundColor: AppColors.buttonBlue,
            textStyle: GoogleFonts.inter(color: AppColors.textWhite),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.inter(color: AppColors.textWhite),
          headlineMedium: GoogleFonts.inter(color: AppColors.textWhite),
          headlineSmall: GoogleFonts.inter(color: AppColors.textWhite),
          titleLarge: GoogleFonts.inter(color: AppColors.textWhite),
          titleMedium: GoogleFonts.inter(color: AppColors.textWhite),
          titleSmall: GoogleFonts.inter(color: AppColors.textWhite),
          bodyLarge: GoogleFonts.inter(color: AppColors.textWhite),
          bodyMedium: GoogleFonts.inter(color: AppColors.textWhite),
          bodySmall: GoogleFonts.inter(color: AppColors.textWhite),
        ),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.buttonBlue, // or AppColors.buttonPurple
          secondary: AppColors.textWhite,
          error: AppColors.wrongRed,
          onPrimary: AppColors.textWhite,
          onSecondary: AppColors.scaffoldBlack,
          surface: AppColors.scaffoldBlack,
          onError: AppColors.textWhite,
        ),
      ),
      home: const HomePage(),
    );
  }
}
