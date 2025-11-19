// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/cubit/cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/cubit/tahalfat_cubit.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/joined_tahalfat_body.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/my_tahalfat_body.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/widgets/tahalfat_body.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class TahalfatPage extends StatelessWidget {
  const TahalfatPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const TahalfatPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TahalfatCubit(
        complaintRepository: context.read<ComplaintRepository>(),
        myID: context.read<AppBloc>().state.user!.id,
        tahalfRepository: context.read<TahalfRepository>(),
        homeRepository: context.read<HomeRepository>(),
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: Text(
              'تحالف الوسطاء',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Color(0xFf8282DD),
              labelColor: Constants.primaryColor,
              unselectedLabelColor: Color(0xFFADB5BD),
              tabs: [
                Tab(
                  text: 'تحالف الوسطاء',
                ),
                Tab(
                  text: 'تحالفاتي',
                ),
                Tab(
                  text: 'تحالفات منضم لها',
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [TahalfatView(), MyTahalfatView(), JoinedTahalfatView()],
          ),
          floatingActionButton: ExpandableFab(
            initialOpen: 0,
            distance: 112,
            children: [
              BlocBuilder<TahalfatCubit, TahalfatState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      final m = context.read<TahalfatCubit>();
                      await context.pushNamed(
                        Screens.createTahalf.name,
                        extra: TahalfType.public,
                      );
                      m.updateScreen();
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25).r,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                              0,
                              1,
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            Constants.tahalf_3am,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text(
                            'تحالف عام 50 وسيط ',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<TahalfatCubit, TahalfatState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () async {
                      final m = context.read<TahalfatCubit>();
                      await context.pushNamed(
                        Screens.createTahalf.name,
                        extra: TahalfType.private,
                      );
                      m.updateScreen();
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25).r,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                              0,
                              1,
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          SvgPicture.asset(
                            Constants.tahalf_5as,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const Text(
                            'تحالف خاص 5 وسطاء ',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTahalfatView extends StatelessWidget {
  const MyTahalfatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TahalfatCubit, TahalfatState>(
      listener: (context, state) {
        if (state.status == TahalfatStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            'جاري الحذف ....',
          );
        }
        if (state.status == TahalfatStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == TahalfatStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.success,
          );
        }
      },
      child: const MyTahalfatBody(),
    );
  }
}

class TahalfatView extends StatelessWidget {
  const TahalfatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TahalfatCubit, TahalfatState>(
      listener: (context, state) {
        if (state.status == TahalfatStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            'جاري تقديم الشكوى ....',
          );
        }
        if (state.status == TahalfatStatus.attachLoading) {
          HelperMethod.showSnackBar(
            context,
            'جاري الانضمام ....',
          );
        }
        if (state.status == TahalfatStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == TahalfatStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.success,
          );
        }
      },
      child: const TahalfatBody(),
    );
  }
}

class JoinedTahalfatView extends StatelessWidget {
  const JoinedTahalfatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TahalfatCubit, TahalfatState>(
      listener: (context, state) {
        if (state.status == TahalfatStatus.processLoading) {
          HelperMethod.showSnackBar(
            context,
            'جاري الخروج ....',
          );
        }
        if (state.status == TahalfatStatus.processFailure) {
          HelperMethod.showSnackBar(
            context,
            state.processMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == TahalfatStatus.processSuccess) {
          HelperMethod.showSnackBar(
            context,
            'تم الخروج من التحالف بنجاح',
            type: SnackBarType.success,
          );
        }
      },
      child: const JoinedTahalfatBody(),
    );
  }
}

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    required this.initialOpen,
    required this.distance,
    required this.children,
  });

  final int initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  _ExpandableFabState createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late CurvedAnimation _curve;

  bool _open = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _expandAnimation = Tween<double>(begin: 0, end: 1).animate(_curve);

    _open = false;
    _controller.value = 1;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _buildTapToCloseFab() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      shape: const CircleBorder(),
      heroTag: 'tap-to-close',
      onPressed: _toggle,
      tooltip: 'Close',
      child: const Icon(Icons.close),
    );
  }

  Widget _buildTapToOpenFab() {
    return FloatingActionButton(
      backgroundColor: AppColors.primaryColor,
      shape: const CircleBorder(),
      heroTag: 'tap-to-open',
      onPressed: _toggle,
      tooltip: 'Open',
      child: const Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      if (_open) _buildTapToCloseFab() else _buildTapToOpenFab(),
      if (_open) ...widget.children,
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: children.reversed
          .map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 16).r,
              child: child,
            ),
          )
          .toList(),
    );
  }
}
