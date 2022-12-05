import 'dart:convert';

LeaderBoard leaderboardListFromJson(String str) => LeaderBoard.fromJson(json.decode(str));

String leaderboardListToJson(LeaderBoard data) => json.encode(data.toJson());

class LeaderBoard {
  LeaderBoard({
    required this.leaderBoardName,
    required this.leaderBoardYear,
    required this.leaderBoardScore,
    required this.leaderBoardSLNo,
  });

  String leaderBoardName;
  String leaderBoardYear;
  String leaderBoardScore;
  String leaderBoardSLNo;

  factory LeaderBoard.fromJson(Map<String, dynamic> json) => LeaderBoard(
    leaderBoardName: json["leader_board_name"],
    leaderBoardYear: json["leader_board_year"],
    leaderBoardScore: json["leader_board_score"],
    leaderBoardSLNo: json["leader_board_slNo"],
  );

  Map<String, dynamic> toJson() => {
    "leader_board_name": leaderBoardName,
    "leader_board_year": leaderBoardYear,
    "leader_board_score": leaderBoardScore,
    "leader_board_slNo": leaderBoardSLNo,
  };
}
