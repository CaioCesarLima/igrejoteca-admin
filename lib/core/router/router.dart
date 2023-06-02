import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_admin/modules/books/routes.dart';
import 'package:igrejoteca_admin/modules/clubs/routes/clubs_routes.dart';
import 'package:igrejoteca_admin/modules/emprestimos/routes/emprestimos_routes.dart';
import 'package:igrejoteca_admin/modules/login/UI/pages/initial_page.dart';
import 'package:igrejoteca_admin/modules/login/routes/routes.dart';
import 'package:igrejoteca_admin/modules/prayers/routes/prayers_routes.dart';
import 'package:igrejoteca_admin/modules/quiz/routes/quiz_routes.dart';
import 'package:igrejoteca_admin/modules/reservations/routes/reservation_routes.dart';

class Router {
  final GetIt getIt;

  Router(this.getIt);

  String get initialRoute {
    return InitialPage.route;
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      ...BookRoutes.routes,
      ...LoginRoutes.routes,
      ...ReservationRoutes.routes,
      ...EmprestimoRoutes.routes,
      ...PrayersRoutes.routes,
      ...QuizRoutes.routes,
      ...ClubsRoutes.routes
    };
    final builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(builder: (context) => builder(context));
    } else {
      // Tratar o caso em que a rota não foi encontrada.
      return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
