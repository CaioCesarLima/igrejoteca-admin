import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_admin/modules/books/data/repositories/book_repository.dart';
import 'package:igrejoteca_admin/modules/books/data/repositories/book_repository_impl.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/event/book_event.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/state/book_state.dart';
import 'package:result_dart/result_dart.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookRepository _bookRepository = BookBackendRepository();
  BookBloc() : super(EmptyBookState()) {
    on<GetBook>(_getListBooks);
    on<ReserveBook>(_reserveBook);
    on<SaveBarcodeBook>(_saveBarcodeBook);
    on<SaveBook>(_saveBook);
  }

  Future<void> _getListBooks(
    GetBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingListBooksState());
    Result<List<BookModel>, Exception> response =
        await _bookRepository.getAllBooks();

    response.fold((success) {
      emit(LoadedBookState(books: success));
    }, (failure) => emit(ErrorBookState()));
  }

  Future<void> _reserveBook(
    ReserveBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingReservedBookState());
    Result<bool, Exception> response =
        await _bookRepository.reserveBook(event.bookId);

    response.fold((success) {
      emit(ReservedBookState());
    }, (failure) => emit(ErrorReservedBookState()));
  }

  Future<void> _saveBarcodeBook(
    SaveBarcodeBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingListBooksState());
    Result<bool, Exception> response =
        await _bookRepository.saveIsbnBook(event.isbn);

    response.fold((success) {
      emit(SavedBookState());
    }, (failure) => emit(ErrorSavedBookState()));
  }

  Future<void> _saveBook(
    SaveBook event,
    Emitter<BookState> emit,
  ) async {
    emit(LoadingListBooksState());
    Result<bool, Exception> response = await _bookRepository.saveBook(
        event.book.title,
        event.book.subtitle,
        event.book.author,
        event.book.pages,
        event.book.category);

    response.fold((success) {
      emit(SavedBookState());
    }, (failure) => emit(ErrorSavedBookState()));
  }
}
