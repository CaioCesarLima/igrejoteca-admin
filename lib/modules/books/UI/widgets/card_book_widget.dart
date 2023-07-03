import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_admin/core/theme/colors.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/books/UI/widgets/books_button.dart';
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/bloc/book_bloc.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/event/book_event.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/state/book_state.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_button.dart';
import 'package:logger/logger.dart';

class CardBookWidget extends StatefulWidget {
  final BookModel book;
  const CardBookWidget({Key? key, required this.book}) : super(key: key);

  @override
  State<CardBookWidget> createState() => _CardBookWidgetState();
}

class _CardBookWidgetState extends State<CardBookWidget> {
  late BookBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I<BookBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookBloc, BookState>(
      bloc: _bloc,
      listener: (context, state) {
        if(state is ReservedBookState){
          Logger().i(state);
        }
        if(state is ErrorReservedBookState){
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  child: widget.book.getPhotoBook(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    widget.book.title,
                    maxLines: 1,
                    style: const TextStyle(
                        color: AppColors.accentColor, fontSize: 16),
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.book.author,
                  style: const TextStyle(
                      color: AppColors.accentColor, fontSize: 12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, right: 20, bottom: 5),
                child: BooksButton(
                    label: "Informações",
                    backgroundColor: AppColors.primaryColor,
                    ontap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((context) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15, left: 24, right: 24),
                                        child: Text(
                                          widget.book.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: AppColors.accentColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: SizedBox(
                                          height: 150,
                                          child: widget.book.getPhotoBook(),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: Text(
                                          widget.book.author,
                                          style: const TextStyle(
                                              color: AppColors.accentColor,
                                              fontSize: 24),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Consts.khorintalPading + 15,
                                            vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Páginas: ${widget.book.pages}",
                                              style: const TextStyle(
                                                  color: AppColors.accentColor,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              "Categoria: ${widget.book.category}",
                                              style: const TextStyle(
                                                  color: AppColors.accentColor,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Consts.khorintalPading,
                                        vertical: 35),
                                    child: state is LoadingReservedBookState ?
                                    const Center(child: CircularProgressIndicator(),) 
                                    : AppButton(
                                        label: widget.book.status == "released" ? "Reservar" : "Reservado",
                                        backgroundColor:
                                            widget.book.status == "released"
                                                ? AppColors.primaryColor
                                                : Colors.grey,
                                        ontap: widget.book.status == "released"
                                            ? () {
                                              Navigator.pop(context);
                                              _bloc.add(ReserveBook(widget.book.id));
                                            }
                                            : () {}),
                                  )
                                ],
                              ),
                            );
                          }));
                    }),
              )
            ],
          ),
        );
      },
    );
  }
}
