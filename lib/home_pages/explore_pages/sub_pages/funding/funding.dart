//
//funding_list   =   funding_title
//                   funding_amount
//                   funding_year
//                   funding_agency
//
//

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
        .map((fundingListFromJson) => FundingList(
            fundingTitle: fundingListFromJson['funding_title'],
            fundingAmount: fundingListFromJson['funding_amount'],
            fundingYear: fundingListFromJson['funding_year'],
            fundingAgency: fundingListFromJson['funding_agency']))
        .toList();
    setState(() {
      listFundingItems = final_list;
    });
  }

  final logoRed = const Color.fromRGBO(103, 0, 1, 20);
  final CardBG = const Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funding'),
        backgroundColor: const Color.fromRGBO(103, 0, 1, 20),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listFundingItems.length,
        itemBuilder: (BuildContext context, int index) {
          FundingList fundingList = listFundingItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Container(
              decoration: BoxDecoration(
                  color: logoRed,
                  borderRadius: borderRadius,
                  boxShadow: [BoxShadow(color: logoRed, blurRadius: 10)]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      listFundingItems[index].fundingTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: borderRadius, color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Table(
                        children: [
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Amount',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listFundingItems[index].fundingAmount),
                                ],
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Year',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10,left: 10,top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listFundingItems[index].fundingYear),
                                ],
                              ),
                            )
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Agency',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(listFundingItems[index].fundingAgency),
                                ],
                              ),
                            )
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
