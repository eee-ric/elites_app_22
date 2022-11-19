import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../explore_pages/sub_pages/research_innovation/internship/internship_page.dart';

class email_edit extends StatefulWidget {
  const email_edit({Key? key}) : super(key: key);

  @override
  State<email_edit> createState() => _email_editState();
}

class _email_editState extends State<email_edit> {
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              buildTextField(
                  title: 'To', controller: controllerTo, maxlines: 1),
              SizedBox(
                height: 20,
              ),
              buildTextField(
                maxlines: 1,
                title: 'Subject',
                controller: controllerSubject,
              ),
              SizedBox(
                height: 20,
              ),
              buildTextField(
                  title: 'Message', controller: controllerMessage, maxlines: 8),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      textStyle: GoogleFonts.secularOne(fontSize: 20)),
                  onPressed: () => launchEmail(
                        toEmail: controllerTo.text,
                        subject: controllerSubject.text,
                        message: controllerMessage.text,
                      ),
                  child: Text('send'.toUpperCase()))
            ],
          ),
        ),
      ),
    );
  }

  launchEmail(
      {required String toEmail,
      required String subject,
      required String message}) async {
    final Uri url = Uri.parse(
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}');
    open_browser_url(url: url, inApp: true);
  }

  void open_browser_url({required Uri url, required bool inApp}) async {
    if (await canLaunchUrl(url)) {
      await (launchUrl(url, mode: LaunchMode.externalApplication));
    }
  }
}

buildTextField(
        {required String title,
        required TextEditingController controller,
        required int maxlines}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.secularOne(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: controller,
          maxLines: maxlines,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        )
      ],
    );
