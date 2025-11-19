enum BrokerType { wasset, office }

extension BrokerTypeX on BrokerType {
  String get name {
    switch (this) {
      case BrokerType.wasset:
        return 'wasset';

      case BrokerType.office:
        return 'office';
    }
  }

  String get arabicName {
    switch (this) {
      case BrokerType.wasset:
        return 'وسيط';

      case BrokerType.office:
        return 'مكتب';
    }
  }
}

extension s on String {
  BrokerType get toBrokerType {
    switch (this) {
      case 'office':
        return BrokerType.office;
      case 'wasset':
        return BrokerType.wasset;
      default:
        return BrokerType.wasset;
    }
  }
}
