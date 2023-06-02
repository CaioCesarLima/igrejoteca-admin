
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class BookRepository{
  Future<Result<List<BookModel>, Exception>> getAllBooks();
  Future<Result<bool, Exception>> reserveBook(String bookId);
}