
import 'package:flutter/material.dart';
import 'package:igrejoteca_admin/modules/notifications/UI/notifications_page.dart';

class NotificationRoutes {
  static const String notification = NotificationsPage.route;

  static final Map<String, WidgetBuilder> routes = {
    notification: (context) => const NotificationsPage(),
  };
}