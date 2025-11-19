enum TahalfType {
  private,
  public,
}

extension TahalfTypeX on TahalfType {
  String get name {
    switch (this) {
      case TahalfType.private:
        return 'private';
      case TahalfType.public:
        return 'public';
    }
  }

  String get arName {
    switch (this) {
      case TahalfType.private:
        return 'خاص';
      case TahalfType.public:
        return 'عام';
    }
  }

  String get appBarName {
    switch (this) {
      case TahalfType.private:
        return 'التحف الخاصة';
      case TahalfType.public:
        return 'التحف العامة';
    }
  }

  String get createAppBarName {
    switch (this) {
      case TahalfType.private:
        return 'انشاء تحالف خاص';
      case TahalfType.public:
        return 'انشاء تحالف عام';
    }
  }
}
