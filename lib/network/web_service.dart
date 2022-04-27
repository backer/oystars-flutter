import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:oystars_flutter_app/data.model/award.dart';
import 'package:oystars_flutter_app/data.model/football_season.dart';
import 'package:oystars_flutter_app/data.model/soccer_player.dart';
import 'package:oystars_flutter_app/data.model/record.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';

const baseUrl = 'https://5c75f3ks0k.execute-api.us-east-1.amazonaws.com';
const soccerPath = '/soccer';
const footballPath = '/football';
const playersPath = '/players';
const seasonsPath = '/seasons';
const recordsPath = '/records';
const awardsPath = '/awards';

Future<List<SoccerPlayer>> fetchSoccerPlayers() {
  return http.get(Uri.parse('$baseUrl$soccerPath$playersPath')).then((value) {
    return decodeSoccerPlayers(value);
  });
}

Future<List<SoccerSeason>> fetchSoccerSeasons() {
  return http.get(Uri.parse('$baseUrl$soccerPath$seasonsPath')).then((value) {
    return decodeSoccerSeasons(value);
  });
}

Future<List<FootballSeason>> fetchFootballSeasons() {
  return http.get(Uri.parse('$baseUrl$footballPath$seasonsPath')).then((value) {
    return decodeFootballSeasons(value);
  });
}

Future<List<Record>> fetchSoccerRecords() {
  return http.get(Uri.parse('$baseUrl$soccerPath$recordsPath')).then((value) {
    return decodeRecords(value);
  });
}

Future<List<Record>> fetchFootballRecords() {
  return http.get(Uri.parse('$baseUrl$footballPath$recordsPath')).then((value) {
    return decodeRecords(value);
  });
}

Future<List<Award>> fetchSoccerAwards() {
  return http.get(Uri.parse('$baseUrl$soccerPath$awardsPath')).then((value) {
    return decodeAwards(value);
  });
}

Future<List<Award>> fetchFootballAwards() {
  return http.get(Uri.parse('$baseUrl$footballPath$awardsPath')).then((value) {
    return decodeAwards(value);
  });
}

List<SoccerPlayer> decodeSoccerPlayers(http.Response response) {
  List<SoccerPlayer> players = [];

  try {
    var jsonArray = json.decode(response.body) as List;
    players = jsonArray.map((e) => SoccerPlayer.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer players: ${e.toString()}');
  }

  return players;
}

List<SoccerSeason> decodeSoccerSeasons(http.Response response) {
  List<SoccerSeason> seasons = [];

  try {
    var jsonArray = json.decode(response.body) as List;
    seasons = jsonArray.map((e) => SoccerSeason.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer seasons: ${e.toString()}');
  }

  return seasons;
}

List<FootballSeason> decodeFootballSeasons(http.Response response) {
  List<FootballSeason> seasons = [];

  try {
    var jsonArray = json.decode(response.body) as List;
    seasons = jsonArray.map((e) => FootballSeason.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding football seasons: ${e.toString()}');
  }

  return seasons;
}

List<Record> decodeRecords(http.Response response) {
  List<Record> records = [];
  try {
    var jsonArray = json.decode(response.body) as List;
    records = jsonArray.map((e) => Record.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer records: ${e.toString()}');
  }

  return records;
}

List<Award> decodeAwards(http.Response response) {
  List<Award> awards = [];
  try {
    var jsonArray = json.decode(response.body) as List;
    awards = jsonArray.map((e) => Award.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer awards: ${e.toString()}');
  }

  return awards;
}
