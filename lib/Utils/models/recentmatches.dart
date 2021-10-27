// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.success,
    this.result,
  });

  int success;
  List<Result> result;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    success: json["success"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.eventKey,
    this.eventDateStart,
    this.eventDateStop,
    this.eventTime,
    this.eventHomeTeam,
    this.homeTeamKey,
    this.eventAwayTeam,
    this.awayTeamKey,
    this.eventServiceHome,
    this.eventServiceAway,
    this.eventHomeFinalResult,
    this.eventAwayFinalResult,
    this.eventHomeRr,
    this.eventAwayRr,
    this.eventStatus,
    this.eventStatusInfo,
    this.countryName,
    this.leagueName,
    this.leagueKey,
    this.leagueRound,
    this.leagueSeason,
    this.eventLive,
    this.eventHomeTeamLogo,
    this.eventAwayTeamLogo,
    this.scorecard,
    this.ballByBall,
    this.wickets,
    this.extra,
    this.lineups,
  });

  String eventKey;
  DateTime eventDateStart;
  DateTime eventDateStop;
  String eventTime;
  String eventHomeTeam;
  String homeTeamKey;
  String eventAwayTeam;
  String awayTeamKey;
  String eventServiceHome;
  String eventServiceAway;
  String eventHomeFinalResult;
  String eventAwayFinalResult;
  String eventHomeRr;
  String eventAwayRr;
  String eventStatus;
  dynamic eventStatusInfo;
  String countryName;
  String leagueName;
  String leagueKey;
  String leagueRound;
  String leagueSeason;
  String eventLive;
  String eventHomeTeamLogo;
  String eventAwayTeamLogo;
  List<dynamic> scorecard;
  List<dynamic> ballByBall;
  List<dynamic> wickets;
  List<dynamic> extra;
  Lineups lineups;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    eventKey: json["event_key"],
    eventDateStart: DateTime.parse(json["event_date_start"]),
    eventDateStop: DateTime.parse(json["event_date_stop"]),
    eventTime: json["event_time"],
    eventHomeTeam: json["event_home_team"],
    homeTeamKey: json["home_team_key"],
    eventAwayTeam: json["event_away_team"],
    awayTeamKey: json["away_team_key"],
    eventServiceHome: json["event_service_home"],
    eventServiceAway: json["event_service_away"],
    eventHomeFinalResult: json["event_home_final_result"],
    eventAwayFinalResult: json["event_away_final_result"],
    eventHomeRr: json["event_home_rr"],
    eventAwayRr: json["event_away_rr"],
    eventStatus: json["event_status"] == null ? null : json["event_status"],
    eventStatusInfo: json["event_status_info"],
    countryName: json["country_name"],
    leagueName: json["league_name"],
    leagueKey: json["league_key"],
    leagueRound: json["league_round"],
    leagueSeason: json["league_season"],
    eventLive: json["event_live"],
    eventHomeTeamLogo: json["event_home_team_logo"],
    eventAwayTeamLogo: json["event_away_team_logo"],
    scorecard: List<dynamic>.from(json["scorecard"].map((x) => x)),
    ballByBall: List<dynamic>.from(json["ball_by_ball"].map((x) => x)),
    wickets: List<dynamic>.from(json["wickets"].map((x) => x)),
    extra: List<dynamic>.from(json["extra"].map((x) => x)),
    lineups: Lineups.fromJson(json["lineups"]),
  );

  Map<String, dynamic> toJson() => {
    "event_key": eventKey,
    "event_date_start": "${eventDateStart.year.toString().padLeft(4, '0')}-${eventDateStart.month.toString().padLeft(2, '0')}-${eventDateStart.day.toString().padLeft(2, '0')}",
    "event_date_stop": "${eventDateStop.year.toString().padLeft(4, '0')}-${eventDateStop.month.toString().padLeft(2, '0')}-${eventDateStop.day.toString().padLeft(2, '0')}",
    "event_time": eventTime,
    "event_home_team": eventHomeTeam,
    "home_team_key": homeTeamKey,
    "event_away_team": eventAwayTeam,
    "away_team_key": awayTeamKey,
    "event_service_home": eventServiceHome,
    "event_service_away": eventServiceAway,
    "event_home_final_result": eventHomeFinalResult,
    "event_away_final_result": eventAwayFinalResult,
    "event_home_rr": eventHomeRr,
    "event_away_rr": eventAwayRr,
    "event_status": eventStatus == null ? null : eventStatus,
    "event_status_info": eventStatusInfo,
    "country_name": countryName,
    "league_name": leagueName,
    "league_key": leagueKey,
    "league_round": leagueRound,
    "league_season": leagueSeason,
    "event_live": eventLive,
    "event_home_team_logo": eventHomeTeamLogo,
    "event_away_team_logo": eventAwayTeamLogo,
    "scorecard": List<dynamic>.from(scorecard.map((x) => x)),
    "ball_by_ball": List<dynamic>.from(ballByBall.map((x) => x)),
    "wickets": List<dynamic>.from(wickets.map((x) => x)),
    "extra": List<dynamic>.from(extra.map((x) => x)),
    "lineups": lineups.toJson(),
  };
}

class Lineups {
  Lineups({
    this.homeTeam,
    this.awayTeam,
  });

  Team homeTeam;
  Team awayTeam;

  factory Lineups.fromJson(Map<String, dynamic> json) => Lineups(
    homeTeam: Team.fromJson(json["home_team"]),
    awayTeam: Team.fromJson(json["away_team"]),
  );

  Map<String, dynamic> toJson() => {
    "home_team": homeTeam.toJson(),
    "away_team": awayTeam.toJson(),
  };
}

class Team {
  Team({
    this.startingLineups,
    this.coaches,
  });

  List<dynamic> startingLineups;
  List<dynamic> coaches;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    startingLineups: List<dynamic>.from(json["starting_lineups"].map((x) => x)),
    coaches: List<dynamic>.from(json["coaches"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "starting_lineups": List<dynamic>.from(startingLineups.map((x) => x)),
    "coaches": List<dynamic>.from(coaches.map((x) => x)),
  };
}
