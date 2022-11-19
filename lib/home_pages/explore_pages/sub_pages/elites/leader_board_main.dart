import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../main_home/leader_board_list.dart';

class leader_board_main extends StatefulWidget {
  const leader_board_main({Key? key}) : super(key: key);

  @override
  State<leader_board_main> createState() => _leader_board_mainState();
}

class _leader_board_mainState extends State<leader_board_main> {
  List<LeaderBoard> listLeaderBoard = [];

  @override
  void initState() {
    fetchDataLeadeerBoard();
    super.initState();
  }

  fetchDataLeadeerBoard() async {
    var ListRecord =
        await FirebaseFirestore.instance.collection('leaderboard_list').get();
    mapListRecord(ListRecord);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var finalList = ListRecord.docs
        .map((leaderboardListFromJson) => LeaderBoard(
              leaderBoardName: leaderboardListFromJson['leader_board_name'],
              leaderBoardYear: leaderboardListFromJson['leader_board_year'],
              leaderBoardScore: leaderboardListFromJson['leader_board_score'],
              leaderBoardSLNo: leaderboardListFromJson['leader_board_slNo'],
            ))
        .toList();
    setState(() {
      listLeaderBoard = finalList;
    });
  }

  final blue = const  Color.fromRGBO(46, 49, 146, 38);
  final blueBg = const Color.fromRGBO(149, 157, 244, 77);
  final yellow = const Color.fromRGBO(253,185,19, 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: listLeaderBoard.length,
          itemBuilder: (BuildContext context, int index) {
            //onTAP FOR INDEX ITEMS
            var ColorFB = Colors.transparent;
            if (index == 0) {
              ColorFB = yellow;
            } else {
              ColorFB = Colors.transparent;
            }
            return Container(
              decoration: BoxDecoration(color: ColorFB),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: [
                    TableRow(
                        children: [
                      Text(
                        listLeaderBoard[index].leaderBoardSLNo,
                        style: GoogleFonts.secularOne(fontSize: 16),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        listLeaderBoard[index].leaderBoardName,
                        style: GoogleFonts.secularOne(fontSize: 16),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        listLeaderBoard[index].leaderBoardYear,
                        style: GoogleFonts.secularOne(fontSize: 16),
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        listLeaderBoard[index].leaderBoardScore,
                        style: GoogleFonts.secularOne(fontSize: 16),
                        overflow: TextOverflow.fade,
                      ),
                    ])
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
