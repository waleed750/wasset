import 'package:flutter/material.dart';
import 'package:waseet/core/helpers/deep_link_helper.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/features/user/presentation/home_page/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/home_page_body.dart';

class HomePagePage extends StatefulWidget {
  const HomePagePage({super.key});
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const HomePagePage());
  }

  @override
  State<HomePagePage> createState() => _HomePagePageState();
}

class _HomePagePageState extends State<HomePagePage> {
  @override
  void initState() {
    super.initState();
    DeepLinkHelper.instance.onAppOpen();
    DeepLinkHelper.instance.listen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(
        homeRepository: context.read<HomeRepository>(),
      ),
      child: const Scaffold(
        body: HomePageView(),
      ),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return const HomePageBody();
  }
}
