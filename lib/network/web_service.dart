import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:oystars_flutter_app/data.model/soccer_player.dart';
import 'package:oystars_flutter_app/data.model/soccer_season.dart';

const baseUrl = 'https://5c75f3ks0k.execute-api.us-east-1.amazonaws.com';
const soccerPath = '/soccer';
const playersPath = '/players';
const seasonsPath = '/seasons';

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
