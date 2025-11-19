import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/no_connection_requests.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/cubit/my_connection_request_cubit.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/my_connection_request_item.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/request_skeleton.dart';

class MyConnectionRequestBody extends StatelessWidget {
  const MyConnectionRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyConnectionRequestCubit, MyConnectionRequestState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              if (state.status == MyConnectionRequestStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<MyConnectionRequestCubit>().init();
                  },
                ),
              if (state.status == MyConnectionRequestStatus.loading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10).r,
                  child: const RequestSkeleton(),
                ),
              if (state.status == MyConnectionRequestStatus.loaded &&
                  state.list.isEmpty)
                const NoConnectionRequests(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        ConnectionRequestItem(
                          connectionRequest: state.list[index],
                          onFavTap: (i) {
                            // context.read<MyConnectionRequestCubit>().toggleFav(
                            //       state.list[index].id,
                            //     );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
