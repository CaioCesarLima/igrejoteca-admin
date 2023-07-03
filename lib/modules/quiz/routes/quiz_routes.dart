
import 'package:flutter/material.dart';

import '../UI/pages/quiz_page.dart';

class QuizRoutes {
  static const String quiz = QuizPage.route;

  static final Map<String, WidgetBuilder> routes = {
    quiz: (context) => const QuizPage(),
  };
}