import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:igrejoteca_admin/core/theme/colors.dart';
import 'package:igrejoteca_admin/modules/notifications/data/notification_repository.dart';
import 'package:igrejoteca_admin/modules/notifications/data/notification_repository_impl.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_button.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_field_widget.dart';
import 'package:igrejoteca_admin/shared/Widgets/app_text_main_widget.dart';
import 'package:igrejoteca_admin/shared/Widgets/custom_dialog.dart';
import 'package:result_dart/result_dart.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  static const String route = '/notification';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isLoading = false;
  final TextEditingController _notificationControlller =
      TextEditingController();
  final TextEditingController _notificationTitle = TextEditingController();
  final NotificationRepository repository = NotificationRepositoryImpl();

  Future<bool> send_notification() async {
    Result<bool, Exception> result = await repository.sendNotifcation(
        message: _notificationControlller.text, title: _notificationTitle.text);
    bool response = false;
    result.fold((success) => response = true, (failure) => response = false);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: AppTextMainWidget(text: "Enviar Notificação"),
              ),
              const SizedBox(
                height: 25,
              ),
              const AppTextMainWidget(text: "Título da mensagem:"),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: AppTextFieldWidget(controller: _notificationTitle),
              ),
              const SizedBox(
                height: 25,
              ),
              const AppTextMainWidget(text: "Sua Mensagem:"),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: AppTextFieldWidget(controller: _notificationControlller),
              ),
              AppButton(
                  loading: isLoading,
                  label: "Enviar",
                  backgroundColor: AppColors.accentColor,
                  ontap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    FocusScope.of(context).unfocus();
                    if (_notificationControlller.text.isNotEmpty &&
                        _notificationTitle.text.isNotEmpty) {
                      await send_notification().then((value) {
                        if (value) {
                          showDialog(
                            context: context,
                            builder: (context) => const CustomDialog(
                                text: 'Notificação disparada com scesso'),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const CustomDialog(
                                text: 'Falha ao disparar notificação'),
                          );
                        }
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            const CustomDialog(text: 'Preencha todos campos'),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
