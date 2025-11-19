enum ComplaintType { user, advertisement, alliance, communicationRequest }

extension ComplaintTypeX on ComplaintType {
  String get name {
    switch (this) {
      case ComplaintType.user:
        return 'user';
      case ComplaintType.advertisement:
        return 'advertisement';
      case ComplaintType.alliance:
        return 'alliance';
      case ComplaintType.communicationRequest:
        return 'communicationRequest';
    }
  }
}
