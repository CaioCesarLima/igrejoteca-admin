
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class BookRepository{
  Future<Result<List<BookModel>, Exception>> getAllBooks();
  Future<Result<bool, Exception>> reserveBook(String bookId);
  Future<Result<bool, Exception>> saveIsbnBook(String isbn);
  Future<Result<bool, Exception>> saveBook(String title, String subtitle, String author, String pages, String category);
}