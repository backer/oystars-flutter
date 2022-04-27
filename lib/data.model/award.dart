import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award_winner.dart';

class Award {
  final String award;
  final String description;
  final List<AwardWinner> winners;

  Award(this.award, this.description, this.winners);

  Award.fromJson(Map<String, dynamic> json)
      : award = json[jsonAward],
        description = json[jsonDescription],
        winners = winnersFromJson(json[jsonWinners]);

  Map<String, dynamic> toJson() => {
        jsonAward: award,
        jsonDescription: description,
        jsonWinners: winnersToJson()
      };

  static List<AwardWinner> winnersFromJson(List<dynamic> jsonArray) {
    List<AwardWinner> awardWinners = [];

    for (var json in jsonArray) {
      awardWinners.add(AwardWinner.fromJson(json));
    }

    return awardWinners;
  }

  List<Map<String, dynamic>> winnersToJson() {
    List<Map<String, dynamic>> jsonArray = [];

    for (var winner in winners) {
      jsonArray.add(winner.toJson());
    }
    return jsonArray;
  }
}
