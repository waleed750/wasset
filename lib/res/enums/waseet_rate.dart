enum wassetRating { excellent, bad, intermediate }

extension wassetRatingX on wassetRating {
  String get name {
    switch (this) {
      case wassetRating.excellent:
        return 'excellent';

      case wassetRating.bad:
        return 'bad';
      case wassetRating.intermediate:
        return 'intermediate';
    }
  }

  String get arabicName {
    switch (this) {
      case wassetRating.excellent:
        return 'ممتاز';

      case wassetRating.bad:
        return 'سيئ';
      case wassetRating.intermediate:
        return 'متوسط';
    }
  }
}
