// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'account_cubit.dart';

enum AccountStatus { initial, loading, success, error }

class AccountState extends Equatable {
  /// {@macro account}
  const AccountState({
    this.errorMessage = '',
    this.status = AccountStatus.initial,
  });

  /// A description for customProperty
  final String errorMessage;
  final AccountStatus status;

  @override
  List<Object> get props => [errorMessage, status];

  /// Creates a copy of the current AccountState with property changes
  AccountState copyWith({
    String? errorMessage,
    AccountStatus? status,
  }) {
    return AccountState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}