import 'package:sga/server/constant/hoyoverse/api_act_id.dart';
import 'package:sga/server/constant/hoyoverse/api_url.dart';

enum HoYoverseGame {
  honkaiImpact3rd(
    ApiActId.honkaiImpact3rd,
    CheckinUrl.honkaiImpact3rd,
    InfoUrl.honkaiImpact3rd,
  ),
  tearsOfThemis(
    ApiActId.tearsOfThemis,
    CheckinUrl.tearsOfThemis,
    InfoUrl.tearsOfThemis,
  ),
  genshinImpact(
    ApiActId.genshinImpact,
    CheckinUrl.genshinImpact,
    InfoUrl.genshinImpact,
  ),
  honkaiStarRail(
    ApiActId.honkaiStarRail,
    CheckinUrl.honkaiStarRail,
    InfoUrl.honkaiStarRail,
  ),
  zenlessZoneZero(
    ApiActId.zenlessZoneZero,
    CheckinUrl.zenlessZoneZero,
    InfoUrl.zenlessZoneZero,
  ),
  ;

  const HoYoverseGame(this.dailyLoginActId, this.checkinUrl, this.infoUrl);

  final ApiActId dailyLoginActId;
  final CheckinUrl checkinUrl;
  final InfoUrl infoUrl;

  String get dailyLoginActIdValue => dailyLoginActId.actId;
  String get checkinUrlValue => checkinUrl.getUrl();
  String get infoUrlValue => infoUrl.getUrl(dailyLoginActIdValue);

  @override
  String toString() {
    switch (this) {
      case HoYoverseGame.honkaiImpact3rd:
        return 'Honkai Impact 3rd';
      case HoYoverseGame.tearsOfThemis:
        return 'Tears of Themis';
      case HoYoverseGame.genshinImpact:
        return 'Genshin Impact';
      case HoYoverseGame.honkaiStarRail:
        return 'Honkai Star Rail';
      case HoYoverseGame.zenlessZoneZero:
        return 'Zenless Zone Zero';
    }
  }
}
