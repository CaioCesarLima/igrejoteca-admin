
import 'package:flutter/material.dart';

import '../UI/pages/clubs_page.dart';

class ClubsRoutes {
  static const String clubs = ClubsPage.route;

  static final Map<String, WidgetBuilder> routes = {
    clubs: (context) => const ClubsPage(),
  };
}