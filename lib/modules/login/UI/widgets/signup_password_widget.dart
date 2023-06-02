import 'package:flutter/material.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_main_widget.dart';

class SignupPasswordWidget extends StatelessWidget {
  final TextEditingController controller;
  const SignupPasswordWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AppTextMainWidget(text: "Agora escolha uma senha segura"),
        AppTextFieldWidget(controller: controller, obscure: true,)

      ],
    );
  }
}