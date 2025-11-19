import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/widgets/kingdom_broker_body.dart';
import 'package:waseet/features/user/presentation/complaint/cubit/complaint_cubit.dart';
import 'package:waseet/features/user/presentation/complaint/widgets/complaint_card.dart';

class ComplaintViewBody extends StatelessWidget {
  const ComplaintViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplaintCubit, ComplaintState>(
      builder: (context, state) {
        return BlocBuilder<ComplaintCubit, ComplaintState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  const CustomAppbar(title: 'البلاغات'),
                  if (state.status == ComplaintStatus.error)
                    ErrorPage(
                      onTap: () {
                        context.read<ComplaintCubit>().init();
                      },
                    ),
                  if (state.status == ComplaintStatus.loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: BrokerSkeleton(),
                    ),
                  if (state.status == ComplaintStatus.loaded &&
                      state.complaints.isEmpty)
                    SizedBox(
                      height: 400.h,
                      child: Center(
                        child: Text(
                          'لا يوجد بلاغات',
                          style: TextStyle(
                            color: Constants.primaryColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          state.complaints.length,
                          (index) => ComplaintCard(
                            complaint: state.complaints[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
