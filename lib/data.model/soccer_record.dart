import 'package:oystars_flutter_app/constants/strings.dart';

class SoccerRecord {
  final String recordName;
  final String recordStat;
  final String recordType;
  // record holders is a map of record holder name to year/session of record
  // in the form of "{year}-s{session}"
  final Map<String, List<String>> recordHolders;

  SoccerRecord(
      this.recordName, this.recordStat, this.recordType, this.recordHolders);

  SoccerRecord.fromJson(Map<String, dynamic> json)
      : recordName = json[jsonRecordName],
        recordStat = json[jsonRecordStat],
        recordType = json[jsonRecordType],
        recordHolders = jsonMapToStringListMap(json[jsonRecordHolders]);

  Map<String, dynamic> toJson() => {
        jsonRecordName: recordName,
        jsonRecordStat: recordStat,
        jsonRecordType: recordType,
        jsonRecordHolders: recordHolders
      };

  static Map<String, List<String>> jsonMapToStringListMap(
      Map<String, dynamic> json) {
    Map<String, List<String>> stringListMap = {};
    for (String key in json.keys) {
      List<String> stringList = [];
      for (var item in json[key]) {
        stringList.add(item.toString());
      }
      stringListMap[key] = stringList;
    }

    return stringListMap;
  }
}
