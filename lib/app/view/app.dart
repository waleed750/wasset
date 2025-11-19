import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/brokers/domain/repositories/communication_repository.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';
import 'package:waseet/features/tahalf/domain/repositories/tahalf_repository.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/domain/repositories/complaints_repository.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/features/user/presentation/splash/cubit/cubit.dart';
import 'package:waseet/res/firebase_notifications.dart';
import 'package:waseet/router/app_router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
    required HomeRepository homeRepository,
    required TahalfRepository tahalfRepository,
    required BrokerRepository brokerRepository,
    required AdRepository adRepository,
    required ChatRepository chatRepository,
    required ComplaintRepository complaintRepository,
    required CommunicationRepository communicationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _homeRepository = homeRepository,
        _tahalfRepository = tahalfRepository,
        _adRepository = adRepository,
        _brokerRepository = brokerRepository,
        _chatRepository = chatRepository,
        _complaintRepository = complaintRepository,
        _communicationRepository = communicationRepository;

  final AuthenticationRepository _authenticationRepository;
  final HomeRepository _homeRepository;
  final TahalfRepository _tahalfRepository;
  final BrokerRepository _brokerRepository;
  final AdRepository _adRepository;
  final ChatRepository _chatRepository;
  final ComplaintRepository _complaintRepository;
  final CommunicationRepository _communicationRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _homeRepository),
        RepositoryProvider.value(value: _tahalfRepository),
        RepositoryProvider.value(value: _adRepository),
        RepositoryProvider.value(value: _brokerRepository),
        RepositoryProvider.value(value: _chatRepository),
        RepositoryProvider.value(value: _complaintRepository),
        RepositoryProvider.value(value: _communicationRepository),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          authenticationRepository: _authenticationRepository,
        )..add(AppStarted()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    super.key,
  });

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
    FirebaseNotifications.onMessageStream.listen(handleNotification);
  }

  void handleNotification(Map<String, dynamic> message) {
    log('handleNotification in app : $message');
    if (message['type'] == 'nafath_verification') {
      context.read<AppBloc>().add(HandleNafathNotificationEvent(message));
      FirebaseNotifications.streamHandled();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.ibmPlexSansArabicTextTheme(),
            appBarTheme: const AppBarTheme(color: Colors.white),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF7432FF),
            ),
            scaffoldBackgroundColor: Colors.white,
          ),

          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: const Locale('ar', 'SA'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'SA'),
          ],
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
