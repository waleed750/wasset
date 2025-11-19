import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/features/brokers/presentation/connection_request/connection_request.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/connection_with_client.dart';
import 'package:waseet/features/brokers/presentation/connection_request/widgets/no_connection_requests.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/my_connection_request_item.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/widgets/request_skeleton.dart';

class AllConnectionRequestsViewBody extends StatelessWidget {
  const AllConnectionRequestsViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionRequestCubit, ConnectionRequestState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              if (state.status == ConnectionRequestStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<ConnectionRequestCubit>().init();
                  },
                ),
              if (state.status == ConnectionRequestStatus.loading)
                const RequestSkeleton(),
              if (state.status == ConnectionRequestStatus.loaded &&
                  state.list.isEmpty)
                const NoConnectionRequests(),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ConnectionRequestItem(
                      connectionRequest: state.list[index],
                      onFavTap: (id) {
                        if (state.list.any(
                          (element) => element.id == id && element.isFav,
                        )) {
                          context
                              .read<ConnectionRequestCubit>()
                              .removeFavRequest(
                                id,
                              );
                        } else {
                          context.read<ConnectionRequestCubit>().addFavRequest(
                                id,
                              );
                        }
                      },
                      onCallTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ConnectionWithClient(
                            name: state.list[index].createdBy.name!,
                            number: state.list[index].createdBy.phone!,
                            image: state.list[index].createdBy.profileImage,
                            connectionRequest: state.list[index],
                          ),
                        );
                      },
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
