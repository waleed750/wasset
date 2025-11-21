import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'dart:io';

import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/domain/entities/request/add_ad_request.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/res/helper_method.dart';

/// A simple pre-wizard page to search an existing ad by advertiserId and license number
class AdvertiserCheckPage extends StatefulWidget {
  const AdvertiserCheckPage({super.key});

  @override
  State<AdvertiserCheckPage> createState() => _AdvertiserCheckPageState();
}

class _AdvertiserCheckPageState extends State<AdvertiserCheckPage> {
  final _formKey = GlobalKey<FormState>();
  final _advertiserController = TextEditingController();
  final _licenseController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _advertiserController.dispose();
    _licenseController.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final advertiserId = _advertiserController.text.trim();
    final license = _licenseController.text.trim();
    if (advertiserId.isEmpty || license.isEmpty) {
      HelperMethod.showSnackBar(context, 'الحقول مطلوبة', type: SnackBarType.error);
      return;
    }
    if (!RegExp(r'^\d{6,}$').hasMatch(advertiserId) || !RegExp(r'^\d{6,}$').hasMatch(license)) {
      // be flexible but prefer numeric IDs
      // allow proceed but show warning
    }
    setState(() => _submitting = true);
    final repo = context.read<AdRepository>();
    final res = await repo.getAdByAdvertiserAndLicense(advertiserId, license);
    setState(() => _submitting = false);
    if (res is ResourceSuccess<AdEntity?>) {
      final ad = res.data;
      if (ad != null) {
        // navigate to preview
        Navigator.of(context).push(MaterialPageRoute<Widget>(
          builder: (_) => AdvertisementPreviewPage(ad: ad),
        ),);
        return;
      }
      HelperMethod.showSnackBar(context, 'لم يتم العثور على إعلان', type: SnackBarType.error);
      return;
    }

  final message = (res as ResourceError).message;
    HelperMethod.showSnackBar(context, message ?? 'حدث خطأ', type: SnackBarType.error);
  }

  // validation is done inline before calling API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WassetAppBar(title: 'البحث عن الإعلان'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  WassetTextField(
                    title: 'رقم الهوية',
                    hintText: 'أدخل رقم الهوية',
                    keyboardType: TextInputType.number,
                    controller: _advertiserController,
                    onChanged: (_) {},
                  ),
                  const SizedBox(height: 12),
                  WassetTextField(
                    title: 'رقم الترخيص',
                    hintText: 'أدخل رقم الترخيص',
                    keyboardType: TextInputType.number,
                    controller: _licenseController,
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _submitting ? null : _search,
                child: _submitting
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('التالي'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvertisementPreviewPage extends StatelessWidget {
  const AdvertisementPreviewPage({super.key, required this.ad});

  final AdEntity ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WassetAppBar(title: 'معاينة الإعلان'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('المدينة: \\${ad.city?.name ?? ''}'),
            const SizedBox(height: 8),
            Text('الحي: \\${ad.neighborhood?.name ?? ''}'),
            const SizedBox(height: 8),
            Text('نوع الإعلان: \\${ad.typeOfAdvertisement ?? ''}'),
            const SizedBox(height: 8),
            Text('نوع العقار: \\${ad.typeOfAdvertisementExtra ?? ''}'),
            const SizedBox(height: 8),
            Text('المساحة: \\${ad.landSpace ?? ''}'),
            const SizedBox(height: 8),
            Text('السعر: \\${ad.price ?? ''}'),
            const SizedBox(height: 8),
            Text('طريقة الدفع: \\${ad.paymentMethod ?? ''}'),
            const SizedBox(height: 8),
            Text('طريقة التواصل: \\${ad.communicationMethod ?? ''}'),
            const SizedBox(height: 12),
            if ((ad.images ?? []).isNotEmpty) ...[
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ad.images?.length ?? 0,
                  itemBuilder: (_, i) {
                    final url = ad.images![i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.network(url, width: 120, height: 120, fit: BoxFit.cover),
                    );
                  },
                ),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
          // reuse existing create ad usecase / repo method
          // Build AddAdRequest from ad entity where possible and call createAd
          final repo = context.read<AdRepository>();
          // The AddAdRequest requires many fields; use defaults where missing.
          final request = AddAdRequest.empty.copyWith(
          advertiserName: ad.advertiserName ?? '',
          advertisingLicenseNumber:
            ad.advertisingLicenseNumber ?? 0,
          cityId: ad.city?.id ?? AddAdRequest.empty.cityId,
          neighborhoodId:
            ad.neighborhood?.id ?? AddAdRequest.empty.neighborhoodId,
          price: ad.price ?? AddAdRequest.empty.price,
          paymentMethod: ad.paymentMethod ?? AddAdRequest.empty.paymentMethod,
          communicationMethod:
            ad.communicationMethod ?? AddAdRequest.empty.communicationMethod,
          typeOfAdvertisement:
            ad.typeOfAdvertisement ?? AddAdRequest.empty.typeOfAdvertisement,
          typeOfAdvertisementExtra:
            ad.typeOfAdvertisementExtra ?? AddAdRequest.empty.typeOfAdvertisementExtra,
          landSpace: ad.landSpace ?? AddAdRequest.empty.landSpace,
          images: <File>[],
          );

                  HelperMethod.showSnackBar(context, 'جاري النشر...');
                  final res = await repo.createAd(request);
                  if (res is ResourceSuccess) {
                    HelperMethod.showSnackBar(context, 'تم النشر بنجاح', type: SnackBarType.success);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    final msg = (res as ResourceError).message;
                    HelperMethod.showSnackBar(context, msg ?? 'خطأ في النشر', type: SnackBarType.error);
                  }
                },
                child: const Text('تأكيد ونشر الإعلان'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
