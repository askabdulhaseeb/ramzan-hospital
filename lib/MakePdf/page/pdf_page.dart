import 'dart:io';

import 'package:flutter/material.dart';

import '../api/pdf_api.dart';
import '../api/pdf_slip_api.dart';
import '../model/PatientInfo.dart';
import '../model/headingTitle.dart';
import '../widget/button_widget.dart';
import '../widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}
class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Make PDF'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Slip',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Slip PDF',
                  onClicked: () async {
                    final DateTime date = DateTime.now();
                    final DateTime dueDate = date.add(const Duration(days: 7));

                    final PDF invoice = PDF(
                      headingTitle: const HeadingTitle(
                        title: 'University of Lahore',
                        subTitle: 'TEACHING HOSPITAL',
                        consultation: 'HOSPITAL CONSULTATION',
                        slip : 'Presception Slip'
                      ),
                      
                      info: PatientInfo(
                        date: date,
                        dueDate: dueDate,
                        description: 'My description...',
                        number: '${DateTime.now().year}-9999',
                      ),
                      
                    );

                    final File pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
