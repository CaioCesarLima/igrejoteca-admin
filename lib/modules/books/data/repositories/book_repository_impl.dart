import 'dart:convert';
import 'package:igrejoteca_admin/core/enviroments/enviroment.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_admin/modules/books/data/repositories/book_repository.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';
import 'package:http/http.dart' as http;

class BookBackendRepository implements BookRepository {
  @override
  Future<Result<List<BookModel>, Exception>> getAllBooks() async {
    try {
      Uri url = getBackendURL(path: "/api/books");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<BookModel> books = data.map((e) => BookModel.fromjson(e)).toList();

        return Result.success(books);
      } else {
        Logger().i(resp.statusCode);
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }

  @override
  Future<Result<bool, Exception>> reserveBook(String bookId) async {
    try {
      Uri url = getBackendURL(path: "/api/reserves");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url,
          headers: headers, body: json.encode({"book_id": bookId}));

      if (resp.statusCode == 200) {
        return Result.success(true);
      } else {
        return Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool, Exception>> saveIsbnBook(String isbn) async {
    try {
      Uri url = getBackendURL(path: "/api/isbn-book");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url,
          headers: headers, body: json.encode({"isbn": isbn}));

      if (resp.statusCode == 201) {
        return Result.success(true);
      } else {
        return Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool, Exception>> saveBook(String title, String subtitle,
      String author, String pages, String category) async {
    try {
      Uri url = getBackendURL(path: "/api/books");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url,
          headers: headers,
          body: json.encode({
            "book": {
              "title": title,
              "subtitle": subtitle,
              "autor": author,
              "pages": pages,
              "category": category
            }
          }));

      if (resp.statusCode == 201) {
        return Result.success(true);
      } else {
        return Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }
  }
}
