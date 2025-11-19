import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/presentation/splash/cubit/cubit.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({
    super.key,
  });

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final isBusy = state.isBusy;
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 1,
          ).r,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(92, 158, 158, 158)),
            borderRadius: BorderRadius.circular(30).r,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<AppBloc>().add(ChangeAccountStateEvent());
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isBusy ? null : Colors.green,
                  ),
                  child: FittedBox(
                    child: Text(
                      'متصل',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: isBusy ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<AppBloc>().add(ChangeAccountStateEvent());
                },
                child: Container(
                  padding: const EdgeInsets.all(7).r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isBusy ? Colors.red : null,
                  ),
                  child: FittedBox(
                    child: Text(
                      'مشغول',
                      style: TextStyle(
                        fontSize: 8.sp,
                        color: isBusy ? Colors.white : Colors.black,
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
  }
}
