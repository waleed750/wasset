import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/cubit/cubit.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/widgets/create_tahalf_body.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/helper_method.dart';

class CreateTahalfPage extends StatelessWidget {
  /// {@macro create_tahalf_page}
  const CreateTahalfPage({super.key, required this.tahalfType});

  final TahalfType tahalfType;

  static Route<dynamic> route(TahalfType tahalfType) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => CreateTahalfPage(
        tahalfType: tahalfType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTahalfCubit(
        homeRepository: context.read<HomeRepository>(),
        tahalfRepository: context.read<TahalfRepository>(),
        tahalfType: tahalfType,
      ),
      child: Scaffold(
        appBar: WassetAppBar(title: tahalfType.createAppBarName),
        body: const CreateTahalfView(),
      ),
    );
  }
}

class CreateTahalfView extends StatelessWidget {
  const CreateTahalfView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTahalfCubit, CreateTahalfState>(
      listener: (context, state) {
        if (state.status == CreateTahalfStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage.isNotEmpty ? state.errorMessage : 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }

        if (state.status == CreateTahalfStatus.success) {
          HelperMethod.showSnackBar(
            context,
            'تم انشاء التحالف بنجاح',
            type: SnackBarType.success,
          );
          Navigator.of(context).pop();
        }
      },
      child: const CreateTahalfBody(),
    );
  }
}
