enum CommunicationMethod { whats, call, message }

extension CommunicationMethodX on CommunicationMethod {
  String get name {
    switch (this) {
      case CommunicationMethod.whats:
        return 'whatsapp';
      case CommunicationMethod.call:
        return 'call';
      case CommunicationMethod.message:
        return 'chat';
    }
  }

  String get arabicName {
    switch (this) {
      case CommunicationMethod.message:
        return 'محادثة';

      case CommunicationMethod.whats:
        return 'واتس';
      case CommunicationMethod.call:
        return 'اتصال';
    }
  }
}
