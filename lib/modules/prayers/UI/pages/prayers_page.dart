import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../shared/Widgets/custom_drawer.dart';
import '../widgets/prayers_body_widget.dart';
import '../widgets/testemonials_body_widget.dart';
import '../widgets/user_prayers_body_widget.dart';

class PrayersPage extends StatefulWidget {
  const PrayersPage({super.key});

  static const String route = "/prayers";

  @override
  State<PrayersPage> createState() => _PrayersPageState();
}

class _PrayersPageState extends State<PrayersPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.lightBlueColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Orações"),
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
            indicatorColor: AppColors.primaryColor,
            unselectedLabelColor: AppColors.primaryColor,
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Orações",
              ),
              Tab(
                text: "Meus Pedidos",
              ),
              Tab(
                text: "Testemunhos",
              ),
            ],
          ),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: const [
            PrayersWidget(),
            UserPrayersWidget(),
            TestemonialsWidget(),
          ],
        ));
  }
}

