import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iqded/core/AppStrings/app_strings.dart';
import 'package:iqded/core/widgets/buttons/elevated_button.dart';
import 'package:iqded/core/theme/app_colors.dart';
import 'package:iqded/features/categories/presentation/categories_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 160),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Image.asset('assets/logo/iq.png', height: 100),
                  Text(
                    'ded',
                    style: GoogleFonts.fingerPaint(
                      color: AppColors.textWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                height: 350,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(35, 41, 120, 255),
                      spreadRadius: 0,
                      blurRadius: 200,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                  border: BoxBorder.all(color: AppColors.buttonBlue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Text(
                      AppStrings.currScore,
                      style: GoogleFonts.inter(
                        color: AppColors.textWhite,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '     IQ Dead ?\nStart the quiz!',
                      style: GoogleFonts.inter(
                        color: AppColors.textWhite,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 40),
                    AppStyleButton(
                      icon: const Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.textWhite,
                        size: 24,
                      ),
                      text: AppStrings.playNewQuiz,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CategoriesPage(),
                          ),
                        );
                      },
                      minSize: const Size(300, 50),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
