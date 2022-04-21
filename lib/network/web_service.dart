import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:oystars_flutter_app/data.model/soccer_award.dart';
import 'package:oystars_flutter_app/data.model/soccer_player.dart';
import 'package:oystars_flutter_app/data.model/soccer_record.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';

const baseUrl = 'https://5c75f3ks0k.execute-api.us-east-1.amazonaws.com';
const soccerPath = '/soccer';
const playersPath = '/players';
const seasonsPath = '/seasons';
const recoredsPath = '/records';
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

Future<List<SoccerRecord>> fetchSoccerRecords() {
  return http.get(Uri.parse('$baseUrl$soccerPath$recoredsPath')).then((value) {
    return decodeSoccerRecords(value);
  });
}

Future<List<SoccerAward>> fetchSoccerAwards() {
  return http.get(Uri.parse('$baseUrl$soccerPath$awardsPath')).then((value) {
    return decodeSoccerAwards(value);
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

List<SoccerRecord> decodeSoccerRecords(http.Response response) {
  List<SoccerRecord> records = [];
  try {
    var jsonArray = json.decode(response.body) as List;
    records = jsonArray.map((e) => SoccerRecord.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer records: ${e.toString()}');
  }

  return records;
}

List<SoccerAward> decodeSoccerAwards(http.Response response) {
  List<SoccerAward> awards = [];
  try {
    var jsonArray = json.decode(response.body) as List;
    awards = jsonArray.map((e) => SoccerAward.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer awards: ${e.toString()}');
  }

  return awards;
}
