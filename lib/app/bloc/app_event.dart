part of 'app_bloc.dart';

class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AppEvent {}

class AppLoggedIn extends AppEvent {
  const AppLoggedIn(this.user);

  final WassetUser user;

  @override
  List<Object> get props => [user];
}

class AppLoggedOut extends AppEvent {}

class ChangeAccountStateEvent extends AppEvent {}

class ChangeAccountTypeEvent extends AppEvent {}

class UpdateAccountProfileEvent extends AppEvent {
  const UpdateAccountProfileEvent(this.user);

  final WassetUser user;

  @override
  List<Object> get props => [user];
}

class RequestNafathAuthenticationEvent extends AppEvent {
  const RequestNafathAuthenticationEvent(this.nationalId, {this.onRequestDone, this.onException});

  final String nationalId;
  final void Function(String)? onRequestDone;
  final void Function(String)? onException;


  @override
  List<Object> get props => [nationalId];
}

class HandleNafathNotificationEvent extends AppEvent {
  const HandleNafathNotificationEvent(this.data);

  final Map<String, dynamic> data;

  @override
  List<Object> get props => [data];
}

class GetAccountProfileEvent extends AppEvent {}