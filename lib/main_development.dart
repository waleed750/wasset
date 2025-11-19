import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waseet/app/app.dart';
import 'package:waseet/bootstrap.dart';
import 'package:waseet/features/advertisement/data/datasources/ad_datasource.dart';
import 'package:waseet/features/advertisement/data/repositories/ad_repository_impl.dart';
import 'package:waseet/features/brokers/data/datasources/broker_data_source.dart';
import 'package:waseet/features/brokers/data/datasources/communication_data_source.dart';
import 'package:waseet/features/brokers/data/repositories/brokers_repository_impl.dart';
import 'package:waseet/features/brokers/data/repositories/communication_repository_impl.dart';
import 'package:waseet/features/chat/data/datasources/chat_datasource_impl.dart';
import 'package:waseet/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:waseet/features/tahalf/data/datasources/tahalf_data_source.dart';
import 'package:waseet/features/tahalf/data/repositories/tahalf_repository_impl.dart';
import 'package:waseet/features/user/data/datasources/authentication_data_source.dart';
import 'package:waseet/features/user/data/datasources/complaint_data_source.dart';
import 'package:waseet/features/user/data/datasources/home_data_source.dart';
import 'package:waseet/features/user/data/repositories/authentication_repository_impl.dart';
import 'package:waseet/features/user/data/repositories/complaints_repository_impl.dart';
import 'package:waseet/features/user/data/repositories/home_repository_impl.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await wassetSharedPreferences.init();

  final apiService = ApiService();

  // authentication depedencies
  final authenticationDataSource =
      AuthenticationDataSource(apiService: apiService);
  final authenticationRepository = AuthenticationRepositoryImpl(
    dataSource: authenticationDataSource,
  );

  // home depedencies
  final homeDataSource = HomeDataSource(apiService: apiService);
  final HomeRepository homeRepository =
      HomeRepositoryImpl(homeDataSource: homeDataSource);

  // tahalf depedencies
  final tahalfDataSource = TahalfDataSource(apiService: apiService);
  final tahalfRepository = TahalfRepositoryImpl(dataSource: tahalfDataSource);

  // ads depedencies
  final adDataSource = AdDatasource(apiService: apiService);
  final adRepository = AdRepositoryImpl(adDatasource: adDataSource);

  //kingdom brokers
  final brokerDataSource = BrokerDataSource(apiService: apiService);
  final brokersRepository = BrokerRepositoryImpl(dataSource: brokerDataSource);

  // chat depedencies
  final chatDataSource = ChatDataSoruceImpl(
    apiServices: apiService,
  );
  final chatRepository = ChatRepositoryImpl(chatDataSource: chatDataSource);

  // chat depedencies
  final complaintDataSource = ComplaintDataSource(apiService: apiService);
  final complaintRepository =
      ComplaintRepositoryImpl(complaintDataSource: complaintDataSource);
  // communication depedencies
  final communicationDataSource =
      CommunicationDataSource(apiService: apiService);
  final communicationRepository =
      CommunicationRepositoryImpl(dataSource: communicationDataSource);
//Complaint
  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
      homeRepository: homeRepository,
      tahalfRepository: tahalfRepository,
      adRepository: adRepository,
      brokerRepository: brokersRepository,
      chatRepository: chatRepository,
      complaintRepository: complaintRepository,
      communicationRepository: communicationRepository,
    ),
  );
}
