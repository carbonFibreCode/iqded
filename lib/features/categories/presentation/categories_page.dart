import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iqded/core/AppStrings/app_strings.dart';
import 'package:iqded/core/widgets/buttons/elevated_button.dart';
import 'package:iqded/core/widgets/snackbar/show_snackbar.dart';
import 'package:iqded/core/theme/app_colors.dart';
import 'package:iqded/features/categories/data/dataSource/categories_data.dart';
import 'package:iqded/features/categories/presentation/widget/category_grid.dart';
import 'package:iqded/features/categories/presentation/widget/drop_down_level.dart';
import 'package:iqded/features/quizPage/domain/entity/question_entity.dart';
import 'package:iqded/features/quizPage/presentation/bloc/questions_bloc.dart';
import 'package:iqded/features/quizPage/presentation/quiz_page.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int? selectedCategoryIndex;
  String? categoryString;
  String? selectedLevel;
  List<QuestionEntity>? questions;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsBloc, QuestionsState>(
      listener: (context, state) {
        if (state is QuestionsLoading) {
          showSnackBar(context, 'Loading your questions');
        }
        if (state is QuestionsFailure) {
          showSnackBar(context, state.error);
        }
        if (state is QuestionsSuccess) {
          questions = state.questions;
          if (questions!.isNotEmpty) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizPage(
                  quizCategory: categoryString!,
                  questions: questions!,
                ),
              ),
            );
          }
          showSnackBar(context, 'Questions fetched succesfully');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: AppColors.scaffoldBlack,
            elevation: 0,
            title: Text(
              AppStrings.selectCategory,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fixed: Dropdown and Titles
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: DropDownLevel(
                        selectedItem: selectedLevel,
                        onChanged: (value) {
                          selectedLevel = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      AppStrings.quizCategory,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.chooseTopic,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      sliver: CategoryGridSliver(
                        categories: categories,
                        selectedIndex: selectedCategoryIndex,
                        onCategorySelected: (index) {
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: AppStyleButton(
            icon: const Icon(
              Icons.play_arrow_rounded,
              size: 24,
              color: AppColors.textWhite,
            ),
            text: 'Start Playing',
            onPressed: () {
              if (selectedCategoryIndex != null && selectedLevel != null) {
                categoryString = categories[selectedCategoryIndex!].label;
                context.read<QuestionsBloc>().add(
                  QuestionsFetchEvent(
                    selectedLevel: selectedLevel!,
                    categoryString: categoryString!,
                  ),
                );
              } else if (selectedCategoryIndex == null ||
                  selectedLevel == null) {
                showSnackBar(context, 'Category or Level not selected');
              }
            },
            minSize: const Size(300, 50),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}
