import 'dart:convert';

FundingList fundingListFromJson(String str) =>
    FundingList.fromJson(json.decode(str));

String fundingListToJson(FundingList data) => json.encode(data.toJson());

class FundingList {
  FundingList({
    required this.fundingTitle,
    required this.fundingAmount,
    required this.fundingYear,
    required this.fundingAgency,
  });

  String fundingTitle;
  String fundingAmount;
  String fundingYear;
  String fundingAgency;

  factory FundingList.fromJson(Map<String, dynamic> json) => FundingList(
        fundingTitle: json["funding_title"],
        fundingAmount: json["funding_amount"],
        fundingYear: json["funding_year"],
        fundingAgency: json["funding_agency"],
      );

  Map<String, dynamic> toJson() => {
        "funding_title": fundingTitle,
        "funding_year": fundingYear,
        "funding_amount": fundingAmount,
        "funding_agency": fundingAgency,
      };
}
