import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_admin/shared/data/models/user_model.dart';
class ReservationModel {
  final String id;
  final BookModel book;
  final UserModel user;

  ReservationModel({required this.id, required this.book, required this.user});

  factory ReservationModel.fromjson(Map<String, dynamic> json){
    final String id = json['id'];
    final BookModel book = BookModel.fromjson(json['book']);
    final UserModel user = UserModel.fromJson(json['user']);

    return ReservationModel(id: id, book: book, user: user,);
  }
}