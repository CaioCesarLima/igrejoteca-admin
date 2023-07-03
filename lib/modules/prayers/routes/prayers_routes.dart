
import 'package:flutter/material.dart';

import '../UI/pages/prayers_page.dart';

class PrayersRoutes {
  static const String prayers = PrayersPage.route;

  static final Map<String, WidgetBuilder> routes = {
    prayers: (context) => const PrayersPage(),
  };
}