enum InfoUrl {
  honkaiImpact3rd("https://sg-public-api.hoyolab.com/event/mani/info?act_id="),
  tearsOfThemis("https://sg-public-api.hoyolab.com/event/luna/os/info?act_id="),
  genshinImpact("https://sg-hk4e-api.hoyolab.com/event/sol/info?act_id="),
  honkaiStarRail("https://sg-public-api.hoyolab.com/event/luna/os/info?act_id="),
  zenlessZoneZero("https://sg-act-nap-api.hoyolab.com/event/luna/zzz/os/info?act_id="),
  ;

  const InfoUrl(
    this.baseUrl,
  );

  final String baseUrl;

  String getUrl(String actId) {
    return '$baseUrl$actId';
  }
}

enum CheckinUrl {
  honkaiImpact3rd("https://sg-public-api.hoyolab.com/event/mani/sign?lang=en-us"),
  tearsOfThemis("https://sg-public-api.hoyolab.com/event/luna/os/sign"),
  genshinImpact("https://sg-hk4e-api.hoyolab.com/event/sol/sign"),
  honkaiStarRail("https://sg-public-api.hoyolab.com/event/luna/os/sign"),
  zenlessZoneZero("https://sg-act-nap-api.hoyolab.com/event/luna/zzz/os/sign"),
  ;

  const CheckinUrl(
    this.baseUrl,
  );

  final String baseUrl;

  String getUrl() {
    return baseUrl;
  }
}
