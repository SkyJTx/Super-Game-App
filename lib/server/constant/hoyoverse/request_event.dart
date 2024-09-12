import 'package:sga/server/constant/hoyoverse/api_act_id.dart';
import 'package:sga/server/constant/hoyoverse/api_url.dart';

enum RequestEvent {
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

  const RequestEvent(this.actId, this.checkinUrl, this.infoUrl);

  final ApiActId actId;
  final CheckinUrl checkinUrl;
  final InfoUrl infoUrl;

  String get actIdValue => actId.actId;
  String get checkinUrlValue => checkinUrl.getUrl();
  String get infoUrlValue => infoUrl.getUrl(actIdValue);
}
