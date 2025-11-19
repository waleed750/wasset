import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/constants/constants.dart';

class ClientType extends StatelessWidget {
  const ClientType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final isWasset = state.isWasset;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15).r,
          child: Container(
            padding: const EdgeInsets.all(5).r,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F9FF),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(149, 0, 0, 0),
                  offset: Offset(.1, .1),
                ),
              ],
              borderRadius: BorderRadius.circular(150),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<AppBloc>().add(ChangeAccountTypeEvent());
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 2 / 5,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: !isWasset ? Constants.primaryColor : null,
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: Center(
                      child: Text(
                        'باحث عن عقار',
                        style: TextStyle(
                          color: !isWasset
                              ? Colors.white
                              : const Color(0xFF64748B),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AppBloc>().add(ChangeAccountTypeEvent());
                  },
                  child: Container(
                    width: (2.sw) / 5,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isWasset ? Constants.primaryColor : null,
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: Center(
                      child: Text(
                        'وسيط',
                        style: TextStyle(
                          color:
                              isWasset ? Colors.white : const Color(0xFF64748B),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
