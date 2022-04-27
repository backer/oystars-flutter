import 'package:oystars_flutter_app/constants/strings.dart';
import 'package:oystars_flutter_app/data.model/award_winner.dart';

class SoccerAward {
  final String award;
  final String description;
  final List<SoccerAwardWinner> winners;

  SoccerAward(this.award, this.description, this.winners);

  SoccerAward.fromJson(Map<String, dynamic> json)
      : award = json[jsonAward],
        description = json[jsonDescription],
        winners = winnersFromJson(json[jsonWinners]);

  Map<String, dynamic> toJson() => {
        jsonAward: award,
        jsonDescription: description,
        jsonWinners: winnersToJson()
      };

  static List<SoccerAwardWinner> winnersFromJson(List<dynamic> jsonArray) {
    List<SoccerAwardWinner> awardWinners = [];

    for (var json in jsonArray) {
      awardWinners.add(SoccerAwardWinner.fromJson(json));
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
