// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/about_real_state_type.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/ad_photos_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/contact_info_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/gurntess_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/main_add_ad_body_layout.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/payment_method_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/real_state_details_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/review_ad_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/widgets/select_location_page.dart';

/// {@template add_new_ad_body}
/// Body of the AddNewAdPage.
///
/// Add what it does
/// {@endtemplate}
class AddNewAdBody extends StatelessWidget {
  /// {@macro add_new_ad_body}
  const AddNewAdBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainAddAdBodyLayout(
      pages: [
        AboutRealStateType(),
        SelectLocationPage(),
        RealStateDetailsPage(),
        GurntessPage(),
        PaymentMethodPage(),
        ContactInfoPage(),
        AdPhotosPage(),
        ReviewAdPage(),
      ],
    );
  }
}
