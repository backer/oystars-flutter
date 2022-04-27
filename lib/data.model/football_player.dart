import 'package:oystars_flutter_app/constants/strings.dart';

class FootballPlayer {
  final String name;
  final double fantasyPoints;

  // passing
  final int passingTouchdowns;
  final int passingInterceptions;
  final int passingPats;
  final int passingYards;
  final int passingCompletions;

  // receiving
  final int receivingTouchdowns;
  final int receivingPats;
  final int receivingYards;
  final int receivingReceptions;

  // defensive
  final int defensiveSacks;
  final int defensiveInterceptions;
  final int defensiveTouchdowns;

  FootballPlayer(
      this.name,
      this.fantasyPoints,
      this.passingTouchdowns,
      this.passingInterceptions,
      this.passingPats,
      this.passingYards,
      this.passingCompletions,
      this.receivingTouchdowns,
      this.receivingPats,
      this.receivingYards,
      this.receivingReceptions,
      this.defensiveSacks,
      this.defensiveInterceptions,
      this.defensiveTouchdowns);

  FootballPlayer.fromJson(Map<String, dynamic> json)
      : name = json[jsonName],
        fantasyPoints = json[jsonFantasyPoints],
        passingTouchdowns = json[jsonPassingTouchdowns],
        passingInterceptions = json[jsonPassingInterceptions],
        passingPats = json[jsonPassingPats],
        passingYards = json[jsonPassingYards],
        passingCompletions = json[jsonPassingCompletions],
        receivingTouchdowns = json[jsonReceivingTouchdowns],
        receivingPats = json[jsonReceivingPats],
        receivingYards = json[jsonReceivingYards],
        receivingReceptions = json[jsonReceivingReceptions],
        defensiveSacks = json[jsonDefensiveSacks],
        defensiveInterceptions = json[jsonDefensiveInterceptions],
        defensiveTouchdowns = json[jsonDefensiveTouchdowns];

  Map<String, dynamic> toJson() => {
        jsonName: name,
        jsonFantasyPoints: fantasyPoints,
        jsonPassingTouchdowns: passingTouchdowns,
        jsonPassingInterceptions: passingInterceptions,
        jsonPassingPats: passingPats,
        jsonPassingYards: passingYards,
        jsonPassingCompletions: passingCompletions,
        jsonReceivingTouchdowns: receivingTouchdowns,
        jsonReceivingPats: receivingPats,
        jsonReceivingYards: receivingYards,
        jsonReceivingReceptions: receivingReceptions,
        jsonDefensiveSacks: defensiveSacks,
        jsonDefensiveInterceptions: defensiveInterceptions,
        jsonDefensiveTouchdowns: defensiveTouchdowns
      };
}
