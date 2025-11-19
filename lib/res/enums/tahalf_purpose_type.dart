enum TahalfPurposeType { sale, rent, investment }

extension TahalfPurposeTypeX on TahalfPurposeType {
  String get name {
    switch (this) {
      case TahalfPurposeType.sale:
        return 'buy';

      case TahalfPurposeType.rent:
        return 'rent';
      case TahalfPurposeType.investment:
        return 'investment';
    }
  }

  String get arabicName {
    switch (this) {
      case TahalfPurposeType.sale:
        return 'بيع';

      case TahalfPurposeType.rent:
        return 'ايجار';
      case TahalfPurposeType.investment:
        return 'استثمار';
    }
  }
}
