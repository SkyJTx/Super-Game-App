enum Info {
  honkaiImpact3rd("https://sg-hk4e-api.hoyolab.com/event/sol/info?act_id="),
  tearsOfThemis("https://sg-public-api.hoyolab.com/event/luna/os/info?act_id="),
  genshinImpact("https://sg-public-api.hoyolab.com/event/mani/info?act_id="),
  honkaiStarRail("https://sg-public-api.hoyolab.com/event/luna/os/info?act_id="),
  zenlessZoneZero("https://sg-act-nap-api.hoyolab.com/event/luna/zzz/os/info?act_id="),
  ;

  const Info(
    this.baseUrl,
  );

  final String baseUrl;

  String getUrl(String actId) {
    return '$baseUrl$actId';
  }
}

enum Checkin {
  honkaiImpact3rd("https://sg-hk4e-api.hoyolab.com/event/sol/sign?lang=en-us"),
  tearsOfThemis("https://sg-public-api.hoyolab.com/event/luna/os/sign"),
  genshinImpact("https://sg-public-api.hoyolab.com/event/mani/sign"),
  honkaiStarRail("https://sg-public-api.hoyolab.com/event/luna/os/sign"),
  zenlessZoneZero("https://sg-act-nap-api.hoyolab.com/event/luna/zzz/os/sign"),
  ;

  const Checkin(
    this.baseUrl,
  );

  final String baseUrl;

  String getUrl() {
    return baseUrl;
  }
}
