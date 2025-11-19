enum Screens {
  home,
  login,
  register,
  splash,
  profileInfo,
  account,
  notifications,
  addNewAd,
  createTahalf,
  updateTahalf,
  tahalfat,
  kingdomBroker,
  myBroker,
  tahalfDetails,
  myPersonalOffice,
  myClients,
  myClientRequest,
  chat,
  chatList,
  myAds,
  goldenBrokers,
  advertisements,
  subscriptions,
  packages,
  payment,
  cardDetails,
  adDetails,
  connectionRequests,
  addConnectionRequests,
  updateConnectionRequest,
  myConnectionRequests,
  myFavConnectionRequests,
  aboutUs,
  complaint,
  policiesAndProvisions,
}

extension ScreenName on Screens {
  // replace first uppercase letter with space and lowercase letter after first one (e.g. 'loginWithGoogle' -> 'login with google')
  String get name {
    final name = toString().split('.').last;
    return name
        .replaceAllMapped(
          RegExp('([A-Z])'),
          (match) => ' ${match.group(0)!.toLowerCase()}',
        )
        .trim();
  }

  String convertToPath(String input) {
    return '/${input.replaceFirstMapped(
      RegExp('[A-Z]'),
      (match) => '-${match.group(0)!.toLowerCase()}',
    )}';
  }

  String get path {
    return convertToPath(toString().split('.').last);
  }
}
