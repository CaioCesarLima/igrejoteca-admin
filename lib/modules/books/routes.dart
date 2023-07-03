import 'package:flutter/material.dart';
import 'package:igrejoteca_admin/modules/books/UI/pages/add_book/add_book.dart';
import 'package:igrejoteca_admin/modules/books/UI/pages/home_books_page.dart';


class BookRoutes {
  static const String homeBooks = HomeBooksPage.route;
  static const String addBook = AddBook.route;

  static final Map<String, WidgetBuilder> routes = {
    homeBooks: (context) => const HomeBooksPage(),
    addBook:(context) => const AddBook(),
  };
}