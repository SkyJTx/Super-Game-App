import 'package:sga/server/constant/hoyoverse/api_act_id.dart';
import 'package:sga/server/constant/hoyoverse/api_url.dart';

enum RequestEvent {
  honkaiImpact3rd(
    ApiActId.honkaiImpact3rd,
    InfoUrl.honkaiImpact3rd,
    CheckinUrl.honkaiImpact3rd,
  ),
  tearsOfThemis(
    ApiActId.tearsOfThemis,
    InfoUrl.tearsOfThemis,
    CheckinUrl.tearsOfThemis,
  ),
  genshinImpact(
    ApiActId.genshinImpact,
    InfoUrl.genshinImpact,
    CheckinUrl.genshinImpact,
  ),
  honkaiStarRail(
    ApiActId.honkaiStarRail,
    InfoUrl.honkaiStarRail,
    CheckinUrl.honkaiStarRail,
  ),
  zenlessZoneZero(
    ApiActId.zenlessZoneZero,
    InfoUrl.zenlessZoneZero,
    CheckinUrl.zenlessZoneZero,
  ),
  ;

  const RequestEvent(this.actId, this.checkinUrl, this.infoUrl);

  final ApiActId actId;
  final InfoUrl checkinUrl;
  final CheckinUrl infoUrl;

  String get actIdValue => actId.actId;
  String get checkinUrlValue => checkinUrl.getUrl(actIdValue);
  String get infoUrlValue => infoUrl.getUrl();
}
