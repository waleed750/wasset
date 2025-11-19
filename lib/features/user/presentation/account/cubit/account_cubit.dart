import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const AccountState());

  /// A description for yourCustomFunction
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
