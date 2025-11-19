import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/ad_details/ad_details.dart';
import 'package:waseet/features/user/presentation/account/widgets/account_list_item.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/cubit/policies_and_provisions_cubit.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/widgets/privacy_terms.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/widgets/terms_of_use.dart';

class PoliciesAndProvisionsBody extends StatelessWidget {
  const PoliciesAndProvisionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PoliciesAndProvisionsCubit, PoliciesAndProvisionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            elevation: 0,
            title: const Text(
              'السياسات والاحكام',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AccountListItem(
                  text: 'شروط الخصوصية ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyTerms(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                AccountListItem(
                  text: 'شروط استخدام المنصة ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsOfUse(),
                      ),
                    );
                  },
                ),
                // const SizedBox(
                //   height: 15,
                // ),
                // AccountListItem(
                //   text: 'سياسة الملكية الفكرية ',
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) =>
                //             const IntellectualPropertyPolicy(),
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
