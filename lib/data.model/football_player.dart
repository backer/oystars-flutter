import 'package:oystars_flutter_app/constants/strings.dart';

class FootballPlayer {
  final String name;
  num fantasyPoints;

  // passing
  int passingTouchdowns;
  int passingInterceptions;
  int passingPats;
  int passingYards;
  int passingCompletions;

  // receiving
  int receivingTouchdowns;
  int receivingPats;
  int receivingYards;
  int receivingReceptions;

  // defensive
  num defensiveSacks;
  num defensiveInterceptions;
  int defensiveTouchdowns;

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
        fantasyPoints = json[jsonFantasyPoints] ?? 0.0,
        passingTouchdowns = json[jsonPassingTouchdowns] ?? 0,
        passingInterceptions = json[jsonPassingInterceptions] ?? 0,
        passingPats = json[jsonPassingPats] ?? 0,
        passingYards = json[jsonPassingYards] ?? 0,
        passingCompletions = json[jsonPassingCompletions] ?? 0,
        receivingTouchdowns = json[jsonReceivingTouchdowns] ?? 0,
        receivingPats = json[jsonReceivingPats] ?? 0,
        receivingYards = json[jsonReceivingYards] ?? 0,
        receivingReceptions = json[jsonReceivingReceptions] ?? 0,
        defensiveSacks = json[jsonDefensiveSacks] ?? 0,
        defensiveInterceptions = json[jsonDefensiveInterceptions] ?? 0,
        defensiveTouchdowns = json[jsonDefensiveTouchdowns] ?? 0;

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
