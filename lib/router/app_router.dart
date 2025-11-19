import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/app/view/main_layout.dart';
import 'package:waseet/features/advertisement/domain/entities/ad_entity.dart';
import 'package:waseet/features/advertisement/presentation/ad_details/view/ad_details_page.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/advertisement/presentation/advertisements/view/advertisements_page.dart';
import 'package:waseet/features/advertisement/presentation/my_ads/view/my_ads_page.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/presentation/add_connection_request/add_connection_request.dart';
import 'package:waseet/features/brokers/presentation/connection_request/view/connection_request_page.dart';
import 'package:waseet/features/brokers/presentation/connection_request/view/my_fav_connection_request_page.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/golden_brokers.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/view/kingdom_broker_page.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/view/my_broker_page.dart';
import 'package:waseet/features/brokers/presentation/my_connection_request/view/my_connection_request_page.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/view/my_personal_office_page.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/update_connection_request.dart';
import 'package:waseet/features/chat/presentation/chat/view/chat_page.dart';
import 'package:waseet/features/chat/presentation/chat_list/view/chat_list_page.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/view/create_tahalf_page.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/view/tahalfat_page.dart';
import 'package:waseet/features/tahalf/presentation/update_tahalf/update_tahalf.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/presentation/about_us/about_us.dart';
import 'package:waseet/features/user/presentation/account/account.dart';
import 'package:waseet/features/user/presentation/complaint/view/complaint_page.dart';
import 'package:waseet/features/user/presentation/login/login.dart';
import 'package:waseet/features/user/presentation/notifications/notifications.dart';
import 'package:waseet/features/user/presentation/packages/packages.dart';
import 'package:waseet/features/user/presentation/packages/view/card_details_page.dart';
import 'package:waseet/features/user/presentation/packages/view/payment_page.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/view/policies_and_provisions_page.dart';
import 'package:waseet/features/user/presentation/profile_info/view/profile_info_page.dart';
import 'package:waseet/features/user/presentation/register/register.dart';
import 'package:waseet/features/user/presentation/splash/view/splash_page.dart';
import 'package:waseet/features/user/presentation/subscriptions/subscriptions.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/router/screens.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: Screens.register.name,
        path: Screens.register.path,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        name: Screens.home.name,
        path: Screens.home.path,
        builder: (context, state) => const MainLayout(),
      ),
      GoRoute(
        name: Screens.login.name,
        path: Screens.login.path,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: Screens.profileInfo.name,
        path: Screens.profileInfo.path,
        builder: (context, state) => const ProfileInfoPage(),
      ),
      GoRoute(
        name: Screens.account.name,
        path: Screens.account.path,
        builder: (context, state) => const AccountPage(),
      ),
      GoRoute(
        name: Screens.notifications.name,
        path: Screens.notifications.path,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        name: Screens.addNewAd.name,
        path: Screens.addNewAd.path,
        builder: (context, state) {
          return const AddNewAdPage();
        },
      ),
      GoRoute(
        name: Screens.tahalfat.name,
        path: Screens.tahalfat.path,
        builder: (context, state) {
          return const TahalfatPage();
        },
      ),
      GoRoute(
        name: Screens.createTahalf.name,
        path: Screens.createTahalf.path,
        builder: (context, state) {
          final tahalfType = state.extra! as TahalfType;
          return CreateTahalfPage(
            tahalfType: tahalfType,
          );
        },
      ),
      GoRoute(
        name: Screens.updateTahalf.name,
        path: Screens.updateTahalf.path,
        builder: (context, state) {
          final tahalf = state.extra! as TahalfEntity;
          return UpdateTahalfPage(
            tahalf: tahalf,
          );
        },
      ),
      GoRoute(
        name: Screens.kingdomBroker.name,
        path: Screens.kingdomBroker.path,
        builder: (context, state) {
          final city = state.extra as CitiesEntity?;
          return KingdomBrokerPage(
            city: city,
          );
        },
      ),
      GoRoute(
        name: Screens.myPersonalOffice.name,
        path: Screens.myPersonalOffice.path,
        builder: (context, state) {
          final extra = state.extra as Map?;
          final brokerId = extra?['brokerId'] as int?;
          return MyPersonalOfficePage(
            userId: brokerId,
          );
        },
      ),
      GoRoute(
        name: Screens.chat.name,
        path: '${Screens.chat.path}:chatId/:chatType',
        builder: (context, state) {
          final chatId = state.pathParameters['chatId'] ?? '';
          final chatType = state.pathParameters['chatType'] ?? '';
          final queryParameters = state.uri.queryParameters['name'];
          return ChatPage(
            chatId: chatId,
            chatType: chatType,
            name: queryParameters,
          );
        },
      ),
      GoRoute(
        name: Screens.chatList.name,
        path: Screens.chatList.path,
        builder: (context, state) {
          return const ChatListPage();
        },
      ),
      GoRoute(
        name: Screens.myAds.name,
        path: Screens.myAds.path,
        builder: (context, state) {
          return const MyAdsPage();
        },
      ),
      GoRoute(
        name: Screens.goldenBrokers.name,
        path: Screens.goldenBrokers.path,
        builder: (context, state) {
          return const GoldenBrokersPage();
        },
      ),
      GoRoute(
        name: Screens.advertisements.name,
        path: Screens.advertisements.path,
        builder: (context, state) {
          return const AdvertisementsPage();
        },
      ),
      GoRoute(
        name: Screens.subscriptions.name,
        path: Screens.subscriptions.path,
        builder: (context, state) {
          return const SubscriptionsPage();
        },
      ),
      GoRoute(
        name: Screens.complaint.name,
        path: Screens.complaint.path,
        builder: (context, state) {
          return const ComplaintPage();
        },
      ),
      GoRoute(
        name: Screens.packages.name,
        path: Screens.packages.path,
        builder: (context, state) => const PackagesPage(),
      ),
      GoRoute(
        name: Screens.payment.name,
        path: Screens.payment.path,
        builder: (context, state) {
          final package = state.extra as PackagesCubit?;
          return PaymentPage(
            cubit: package,
          );
        },
      ),
      GoRoute(
        name: Screens.cardDetails.name,
        path: Screens.cardDetails.path,
        builder: (context, state) {
          final cubit = state.extra! as PackagesCubit;
          return CardDetailsPage(
            cubit: cubit,
          );
        },
      ),
      GoRoute(
        name: Screens.adDetails.name,
        path: Screens.adDetails.path,
        builder: (context, state) {
          final adId = state.extra as AdEntity?;
          final id = state.uri.queryParameters['id'];

          return AdDetailsPage(
            ad: adId,
            adId: int.tryParse(id ?? ''),
          );
        },
      ),
      GoRoute(
        name: Screens.connectionRequests.name,
        path: Screens.connectionRequests.path,
        builder: (context, state) {
          return const ConnectionRequestPage();
        },
      ),
      GoRoute(
        name: Screens.myFavConnectionRequests.name,
        path: Screens.myFavConnectionRequests.path,
        builder: (context, state) {
          return const MyFavConnectionRequestPage();
        },
      ),
      GoRoute(
        name: Screens.addConnectionRequests.name,
        path: Screens.addConnectionRequests.path,
        builder: (context, state) {
          return const AddConnectionRequestPage();
        },
      ),
      GoRoute(
        name: Screens.updateConnectionRequest.name,
        path: Screens.updateConnectionRequest.path,
        builder: (context, state) {
          final request = state.extra! as ConnectionRequestEntity;
          return UpdateConnectionRequestPage(
            request: request,
          );
        },
      ),
      GoRoute(
        name: Screens.myConnectionRequests.name,
        path: Screens.myConnectionRequests.path,
        builder: (context, state) {
          return const MyConnectionRequestPage();
        },
      ),
      GoRoute(
        name: Screens.aboutUs.name,
        path: Screens.aboutUs.path,
        builder: (context, state) {
          return const AboutUs();
        },
      ),
      GoRoute(
        name: Screens.policiesAndProvisions.name,
        path: Screens.policiesAndProvisions.path,
        builder: (context, state) {
          return const PoliciesAndProvisionsPage();
        },
      ),
      GoRoute(
        name: Screens.myBroker.name,
        path: Screens.myBroker.path,
        builder: (context, state) {
          return const MyBrokerPage();
        },
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated =
          context.read<AppBloc>().state.status == AppStatus.authenticated;
      final isLoginScreen = state.path == Screens.login.path;
      final isRegisterScreen = state.path == Screens.register.path;

      if (isAuthenticated) {
        if (isLoginScreen || isRegisterScreen) {
          return Screens.home.path;
        }
      }

      return null;
    },
  );
}
