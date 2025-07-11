import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:iqded/core/database/hive_boxes.dart';
import 'package:iqded/features/quizPage/data/dataSources/questions_local_data_source.dart';
import 'package:iqded/features/quizPage/data/dataSources/questions_remote_data_source.dart';
import 'package:iqded/features/quizPage/data/models/question_model.dart';
import 'package:iqded/features/quizPage/data/models/questions_model.dart';
import 'package:iqded/features/quizPage/data/repositories/questions_repository_impl.dart';
import 'package:iqded/features/quizPage/domain/repositories/questions_repository.dart';
import 'package:iqded/features/quizPage/domain/usecases/fetch_quesitions.dart';
import 'package:iqded/features/quizPage/presentation/bloc/questions_bloc.dart';
import 'package:iqded/firebase_options.dart';

final serviceLocator = GetIt.instance;


Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();

  Hive.registerAdapter(QuestionModelAdapter());
  Hive.registerAdapter(QuestionsModelAdapter());
  await Hive.openBox<QuestionsModel>(quizBox);

  final questionsBox = await Hive.openBox<QuestionsModel>('quizzes');
  serviceLocator.registerLazySingleton<Box<QuestionsModel>>(() => questionsBox);

  serviceLocator.registerLazySingleton(() => Connectivity());

  _initQuestions();
}


void _initQuestions() {
  // --- Core Service ---
  serviceLocator.registerLazySingleton<FirebaseAI>(() => FirebaseAI.googleAI());

  // --- Data Layer ---
  serviceLocator.registerLazySingleton<QuestionsRemoteDataSource>(
    () => QuestionsRemoteDataSourceImpl(firebaseAI: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<QuestionsLocalDataSource>(() => QuestionsLocalDataSourceImpl(questionsBox: serviceLocator()));
  serviceLocator.registerLazySingleton<QuestionsRepository>(
    () => QuestionsRepositoryImpl(questionsRemoteDataSource: serviceLocator(), questionsLocalDataSource: serviceLocator(), connectivity: serviceLocator()),
  );

  // --- Domain Layer ---
  serviceLocator.registerLazySingleton<FetchQuestions>(
    () => FetchQuestions(questionRepository: serviceLocator()),
  );

  // --- Presentation Layer ---
  serviceLocator.registerFactory<QuestionsBloc>(
    () => QuestionsBloc(serviceLocator()),
  );
}
