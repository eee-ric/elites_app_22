import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'facilities_list.dart';

class route_for_facilities extends StatelessWidget {
  final FacilitiesList facilitiesList;
  final logoRed = Color.fromRGBO(103, 0, 1, 20);
  final CardBG = Color.fromRGBO(242, 240, 197, 86);
  final borderRadius = BorderRadius.circular(25);

  route_for_facilities(this.facilitiesList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(facilitiesList.facilitiesFrontTitle),
        backgroundColor: Color.fromRGBO(103, 0, 1, 20),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CachedNetworkImage(
              imageUrl: facilitiesList.facilitiesFrontImage,
              imageBuilder: (context, imageProvider) => Container(

                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(facilitiesList.facilitiesDetailText,textAlign: TextAlign.center,style: GoogleFonts.josefinSans(
    color: logoRed, fontSize: 24
            ),),
          )
        ],
      ),
    );
  }
}
