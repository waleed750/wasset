part of 'contact_request_cubit.dart';

/// {@template contact_request}
/// ContactRequestState description
/// {@endtemplate}
class ContactRequestState extends Equatable {
  /// {@macro contact_request}
  const ContactRequestState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current ContactRequestState with property changes
  ContactRequestState copyWith({
    String? customProperty,
  }) {
    return ContactRequestState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template contact_request_initial}
/// The initial state of ContactRequestState
/// {@endtemplate}
class ContactRequestInitial extends ContactRequestState {
  /// {@macro contact_request_initial}
  const ContactRequestInitial() : super();
}
