import 'package:flutter/material.dart';
import 'package:iqded/core/AppDimensions/app_dimensions.dart';
import 'package:iqded/core/theme/app_colors.dart';
import 'package:iqded/core/widgets/appBar/my_app_bar.dart';
import 'package:iqded/features/homepage/home_page.dart';
import 'package:iqded/features/resultPage/data/result.dart';
import 'package:iqded/features/resultPage/presentation/result_card.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  const ResultPage({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.edgePadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder:(context) => const HomePage(),),
                        (Route<dynamic>route) => false,
                      );
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: MyAppBar(
                      abTitle: Text(
                        'Quiz Result',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  //backgroundBlendMode: BlendMode.dstATop,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 24, 73, 156),
                      Color.fromARGB(255, 138, 44, 152),
                    ],
                  ),
                  //border: BoxBorder.all(color: AppColors.textWhite),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 200,
                      spreadRadius: 0.1,
                      color: Color.fromARGB(174, 124, 77, 255),
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Good Job! Keep Practicing !',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.emoji_events_outlined,
                      color: AppColors.textWhite,
                      size: 120,
                    ),
                    Text(
                      '$score / $totalQuestions',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 30),
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(10),
                      value: score / totalQuestions,
                      color: AppColors.buttonBlue,
                      backgroundColor: Colors.blueGrey,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'Review Your Answers',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final resultData = result[index];
                        return ResultCard(
                          statement: resultData.statement,
                          correctAnswerString: resultData.correctAnswer,
                          userAnswer: resultData.userAnswer,
                          qIndex: index + 1,
                        );
                      }, childCount: result.length),
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
