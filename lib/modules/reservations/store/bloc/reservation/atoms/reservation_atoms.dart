import 'package:rx_notifier/rx_notifier.dart';

// atom
final counterState = RxNotifier<int>(0);

//action
final incrementCounter = RxNotifier(null);