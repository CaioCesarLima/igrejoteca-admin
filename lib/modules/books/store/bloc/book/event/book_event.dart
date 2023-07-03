
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';

abstract class BookEvent {}

class GetBook implements BookEvent {
  final String token;

  GetBook({required this.token});
}


class ReserveBook implements BookEvent {
  final String bookId;

  ReserveBook(this.bookId);
}

class SaveBarcodeBook implements BookEvent {
  final String isbn;

  SaveBarcodeBook(this.isbn);
}

class SaveBook implements BookEvent {
  final BookModel book;

  SaveBook(this.book);
}


