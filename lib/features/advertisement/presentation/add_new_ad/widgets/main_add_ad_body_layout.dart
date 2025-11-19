import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/common_widgets/single_child_scroll_view_column.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/add_new_ad_cubit.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/progress_indicator_section.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';

class MainAddAdBodyLayout extends StatefulWidget {
  const MainAddAdBodyLayout({super.key, required this.pages});

  final List<Widget> pages;

  @override
  State<MainAddAdBodyLayout> createState() => _MainAddAdBodyLayoutState();
}

class _MainAddAdBodyLayoutState extends State<MainAddAdBodyLayout> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollViewColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ProgressIndicatorSection(
              progress: currentIndex / (widget.pages.length - 1) * 100,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: widget.pages[currentIndex],
            ),
            const SizedBox(height: 20),
            BlocBuilder<AddNewAdCubit, AddNewAdState>(
              builder: (context, state) {
                return Row(
                  children: [
                    if (currentIndex > 0) ...[
                      WassetButton(
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        text: 'السابق',
                        onTap: () {
                          setState(() {
                            currentIndex--;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                    ],
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: WassetButton(
                          backgroundColor:
                              state.status == AddNewAdStatus.submitting
                                  ? Colors.grey
                                  : null,
                          text: currentIndex < widget.pages.length - 1
                              ? 'التالي'
                              : 'إضافة الاعلان',
                          onTap: state.status == AddNewAdStatus.submitting
                              ? null
                              : () {
                                  if (currentIndex < widget.pages.length - 1) {
                                    setState(() {
                                      currentIndex++;
                                    });
                                  } else {
                                    context.read<AddNewAdCubit>().addNewAd();
                                  }
                                },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
