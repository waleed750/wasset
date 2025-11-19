import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'policies_and_provisions_state.dart';

class PoliciesAndProvisionsCubit extends Cubit<PoliciesAndProvisionsState> {
  PoliciesAndProvisionsCubit() : super(const PoliciesAndProvisionsInitial());

  /// A description for yourCustomFunction
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
