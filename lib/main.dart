
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_admin/core/injector/injector.dart';
import 'package:igrejoteca_admin/core/theme/theme_data.dart';
import 'package:igrejoteca_admin/modules/reservations/store/bloc/reservation/reducers/reservation_reducer.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'core/router/router.dart' as router;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final getIt = GetIt.instance;
  getIt.registerSingleton<ReservationReducer>(ReservationReducer());
  getIt.registerSingleton<router.Router>(router.Router(getIt));

  // LocalNotificationHelper().init();
  // FirebaseMessagingService().initialize();
  setupLocator();
  runApp(const RxRoot(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerApp = GetIt.instance.get<router.Router>();

    return MaterialApp(
      title: 'Igrejoteca Admin',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.lightTheme(),
      initialRoute: routerApp.initialRoute,
      onGenerateRoute: routerApp.onGenerateRoute,
    );
  }
}
