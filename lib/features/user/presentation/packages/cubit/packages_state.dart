// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'packages_cubit.dart';

enum PackagesStatus { initial, loading, success, failure }

class PackagesState extends Equatable {
  const PackagesState({
    this.message = '',
    this.packages = const <PackagesEntity>[],
    this.status = PackagesStatus.initial,
    this.selectedPackage,
    this.paymentLink = '',
  });

  final String message;
  final List<PackagesEntity> packages;
  final PackagesStatus status;
  final PackagesEntity? selectedPackage;
  final String paymentLink;

  @override
  List<Object?> get props =>
      [message, packages, status, selectedPackage, paymentLink];

  PackagesState copyWith({
    String? message,
    List<PackagesEntity>? packages,
    PackagesStatus? status,
    PackagesEntity? selectedPackage,
    String? paymentLink,
  }) {
    return PackagesState(
      message: message ?? this.message,
      packages: packages ?? this.packages,
      status: status ?? this.status,
      selectedPackage: selectedPackage ?? this.selectedPackage,
      paymentLink: paymentLink ?? this.paymentLink,
    );
  }
}
