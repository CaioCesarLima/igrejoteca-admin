import 'package:flutter/material.dart';
import 'package:igrejoteca_admin/modules/books/UI/pages/home_books_page.dart';


class BookRoutes {
  static const String homeBooks = HomeBooksPage.route;

  static final Map<String, WidgetBuilder> routes = {
    homeBooks: (context) => const HomeBooksPage(),
  };
}