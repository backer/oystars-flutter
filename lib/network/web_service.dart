import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:oystars_flutter_app/data.model/soccer_player.dart';

const baseUrl = 'https://5c75f3ks0k.execute-api.us-east-1.amazonaws.com';
const soccerPath = '/soccer';
const playersPath = '/players';

Future<http.Response> fetchSoccerPlayers() {
  return http.get(Uri.parse('$baseUrl$soccerPath$playersPath'));
}

List<SoccerPlayer> decodeSoccerPlayers(http.Response response) {
  List<SoccerPlayer> players = [];

  try {
    var jsonArray = json.decode(response.body) as List;
    debugPrint('jsonArray is ${jsonArray.toString()}');
    players = jsonArray.map((e) => SoccerPlayer.fromJson(e)).toList();
  } catch (e) {
    debugPrint('Error decoding soccer players: ${e.toString()}');
  }

  return players;
}
