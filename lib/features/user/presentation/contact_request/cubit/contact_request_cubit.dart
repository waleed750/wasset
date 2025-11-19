import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'contact_request_state.dart';

class ContactRequestCubit extends Cubit<ContactRequestState> {
  ContactRequestCubit() : super(const ContactRequestInitial());

  /// A description for yourCustomFunction
  FutureOr<void> yourCustomFunction() {
    // TODO: Add Logic
  }
}
