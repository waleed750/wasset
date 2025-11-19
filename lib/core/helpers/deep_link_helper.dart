import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:waseet/router/app_router.dart';
import 'package:waseet/router/screens.dart';

enum DeepLinkType {
  ad,
  personalOffice,
}

class DeepLinkHelper {
  DeepLinkHelper._() {
    init();
  }
  static DeepLinkHelper instance = DeepLinkHelper._();

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  void init() {
    _appLinks = AppLinks();
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  void onAppOpen() {
    _appLinks.getInitialLink().then((Uri? uri) {
      if (uri != null) {
        print('Received deep link on app open: $uri');
      }
    });
  }

  void shareAd(int adId) {
    final uri = Uri.parse(
      'wasset://morph.wasset.sa?type=${DeepLinkType.ad.name}&id=$adId',
    );
    Share.share(uri.toString());
  }

  void sharePersonalOffice(int personalOfficeId) {
    final uri = Uri.parse(
      'wasset://morph.wasset.sa?type=${DeepLinkType.personalOffice.name}&id=$personalOfficeId',
    );
    Share.share(uri.toString());
  }

  void navigateToDeepLink(GoRouter router, Uri uri) {
    final type = uri.queryParameters['type'];
    final id = uri.queryParameters['id'];

    switch (type) {
      case 'ad':
        router.pushNamed(Screens.adDetails.name, queryParameters: {'id': id});
        break;
      case 'personalOffice':
        router.pushNamed(
          Screens.myPersonalOffice.name,
          extra: {
            'brokerId': id,
          },
        );
        break;
      default:
        break;
    }
  }

  void listen() {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      print('Received deep link: $uri');
      navigateToDeepLink(AppRouter.router, uri);
    });
  }
}
