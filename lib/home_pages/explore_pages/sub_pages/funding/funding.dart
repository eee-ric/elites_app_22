import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'funding_list.dart';

class funding_page extends StatefulWidget {
  const funding_page({Key? key}) : super(key: key);

  @override
  State<funding_page> createState() => _funding_pageState();
}

class _funding_pageState extends State<funding_page> {
  List<FundingList> listFundingItems = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var ListRecordFunding =
    await FirebaseFirestore.instance.collection('funding_list').get();
    mapListRecord(ListRecordFunding);
  }

  mapListRecord(QuerySnapshot<Map<String, dynamic>> ListRecord) {
    var final_list = ListRecord.docs
        .map((fundingListFromJson) =>
        FundingList(
            fundingTitle: fundingListFromJson['funding_title'],
            fundingAmount: fundingListFromJson['funding_amount'],
            fundingYear: fundingListFromJson['funding_year'],
            fundingAgency: fundingListFromJson['funding_agency']))
        .toList();
    setState(() {
      listFundingItems = final_list;
    });
  }

  final logoRed = Color.fromRGBO(103, 0, 1, 20);
  final CardBG = Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Funding'),
        backgroundColor: Color.fromRGBO(103, 0, 1, 20),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {},


      ),
    )
    ,
    );
  }
}
