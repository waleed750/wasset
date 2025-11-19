import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/cubit/cubit.dart';
import 'package:waseet/features/tahalf/presentation/update_tahalf/cubit/update_tahalf_cubit.dart';
import 'package:waseet/features/tahalf/presentation/update_tahalf/widgets/update_tahalf_body.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/helper_method.dart';

class UpdateTahalfPage extends StatelessWidget {
  const UpdateTahalfPage({
    super.key,
    required this.tahalf,
  });

  final TahalfEntity tahalf;

  /// The static route for CreateTahalfPage
  static Route<dynamic> route(TahalfEntity tahalf) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => UpdateTahalfPage(
        tahalf: tahalf,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTahalfCubit(
        homeRepository: context.read<HomeRepository>(),
        tahalfRepository: context.read<TahalfRepository>(),
        tahalf: tahalf,
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'تعديل التحالف'),
        body: UpdateTahalfView(),
      ),
    );
  }
}

class UpdateTahalfView extends StatelessWidget {
  const UpdateTahalfView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTahalfCubit, UpdateTahalfState>(
      listener: (context, state) {
        if (state.status == UpdateTahalfStatus.error) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage,
            type: SnackBarType.error,
          );
        }

        if (state.status == UpdateTahalfStatus.success) {
          HelperMethod.showSnackBar(
            context,
            'تم تعديل التحالف بنجاح',
            type: SnackBarType.success,
          );

          Navigator.of(context).pop();
        }
      },
      child:  UpdateTahalfBody(),
    );
  }
}
