import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:igrejoteca_admin/core/theme/colors.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/books/data/models/book_model.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/bloc/book_bloc.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/event/book_event.dart';
import 'package:igrejoteca_admin/modules/books/store/bloc/book/state/book_state.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_button.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_main_widget.dart';
import 'package:igrejoteca_admin/shared/Widgets/custom_dialog.dart';
import 'package:logger/logger.dart';

class AddBook extends StatefulWidget {
  const AddBook({super.key});

  static const String route = '/add-book';

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  late BookBloc bookBloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    bookBloc = GetIt.I<BookBloc>();
    bookBloc.emit(EmptyBookState());
  }

  readIsbn() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      'white',
      'Cancel',
      false,
      ScanMode.BARCODE,
    );
    if (barcodeScanRes != '-1') {
      Logger().i(barcodeScanRes);
      bookBloc.add(SaveBarcodeBook(barcodeScanRes));
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) =>
              const CustomDialog(text: "Falha ao ler código"));
    }
  }

  saveBook() async {
    if (titleController.text.isNotEmpty &&
        subtitleController.text.isNotEmpty &&
        authorController.text.isNotEmpty &&
        pagesController.text.isNotEmpty &&
        categoryController.text.isNotEmpty) {
      bookBloc.add(
        SaveBook(
          BookModel(
              author: authorController.text,
              category: categoryController.text,
              id: "",
              pages: pagesController.text,
              photo: '',
              subtitle: subtitleController.text,
              title: titleController.text,
              status: ''),
        ),
      );
    }else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) =>
              const CustomDialog(text: "Preencha todos campos"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Livro"),
        actions: [
          TextButton.icon(
              onPressed: readIsbn,
              icon: const Icon(Icons.add),
              label: const Text('Add'))
        ],
      ),
      body: BlocConsumer<BookBloc, BookState>(
          bloc: bookBloc,
          listener: (context, state) {
            if (state is ErrorSavedBookState) {
              showDialog(
                  context: context,
                  builder: (context) =>
                      const CustomDialog(text: "Erro ao salvar pelo ISBN"));
            }
            if (state is SavedBookState) {
              showDialog(
                      context: context,
                      builder: (context) => const CustomDialog(
                          text: "Livro cadastrado com sucesso"))
                  .then((value) => {Navigator.pop(context)});
            }
          },
          builder: (context, state) {
            if (state is LoadingListBooksState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: AppTextMainWidget(text: "Cadastrar novo Livro"),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: Consts.khorintalPading),
                    child: AppTextMainWidget(text: "Título do Livro"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: AppTextFieldWidget(
                      controller: titleController,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: Consts.khorintalPading, top: 25),
                    child: AppTextMainWidget(text: "Subtítulo"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: AppTextFieldWidget(
                      controller: subtitleController,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: Consts.khorintalPading, top: 25),
                    child: AppTextMainWidget(text: "Nome do Autor"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: AppTextFieldWidget(
                      controller: authorController,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: Consts.khorintalPading, top: 25),
                    child: AppTextMainWidget(text: "Quantidade de páginas"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: AppTextFieldWidget(
                      controller: pagesController,
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: Consts.khorintalPading, top: 25),
                    child: AppTextMainWidget(text: "Categoria"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Consts.khorintalPading),
                    child: AppTextFieldWidget(
                      controller: categoryController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: AppButton(
                        label: "Salvar",
                        backgroundColor: AppColors.accentColor,
                        ontap: () {
                          saveBook();
                        }),
                  )
                ],
              ),
            );
          }),
    );
  }
}
