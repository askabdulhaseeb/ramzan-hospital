import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../api/pdf_api.dart';
import '../model/heading_title.dart';
import '../model/patient_info.dart';

class PdfInvoiceApi {
  static Future<File> generate(PDF invoice) async {
    final pw.Document pdf = Document();
    pdf.addPage(MultiPage(
      build: (pw.Context context) => <pw.Widget>[
        buildHeader(invoice),
        Divider(),
        medicineSpace(invoice)
      ],
      footer: (Context context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget medicineSpace(
    PDF invoice,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: medicineLeftSpace(),
          ),
          Container(height: 450, child: VerticalDivider(thickness: 2)),
          medicineRightSpace(),
        ],
      );
  static Widget patientInfo_1(PatientInfo info) {
    final List<String> titles = <String>[
      'Father/Husband:',
      'Contact:',
      'CNIC:',
      // ignore: no_adjacent_strings_in_list
      'Address:'
        // ignore: missing_whitespace_between_adjacent_strings
        'Patient Type:'
          'Consultant: '
    ];
    final List<String> data = <String>[
      'Amin',
      '0316-7631138',
      'N/A',
      'N/A',
      'General',
      'N/A'
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: always_specify_types
      children: List.generate(titles.length, (int index) {
        final String title = titles[index];
        final String value = data[index];

        return   Container(
      width: 200,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title,)),
          Text(value, ),
        ],
      ),
    );
      }),
    );
  }

  static Widget medicineRightSpace() {
    final List<String> titles = <String>[
      'Presenting Complaint',
      'History:',
      'Examination:',
      'Provisional Diagnosis:',
      'Treatment:',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: always_specify_types
      children: List.generate(titles.length, (int index) {
        final String title = titles[index];

        return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )));
      }),
    );
  }

  static Widget medicineLeftSpace() {
    final List<String> titles = <String>[
      'Vitals',
      'Pulse:',
      'BP:',
      'Temperature:',
      'Saturation:',
      'Investigations: ',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: always_specify_types
      children: List.generate(titles.length, (int index) {
        final String title = titles[index];

        return Padding(
            padding: const pw.EdgeInsets.only(top: 10),
            child: Text(title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                )));
      }),
    );
  }
  static Widget buildHeader(PDF invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Hello World'),
              buildPdfPage(invoice.headingTitle),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: invoice.info.number,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              patientInfo_1(invoice.info),
              patientInfo_2(invoice.info),
              Column(children: <Widget>[
                Text('Token No', style: const TextStyle(fontSize: 15)),
                Text('32',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              ])
            ],
          ),
        ],
      );
  static Widget patientInfo_2(PatientInfo info) {
    
    final List<String> titles = <String>[
      'Reg Date & Time:',
      'Visit Date & Time::',
      'Visit No:',
      // ignore: no_adjacent_strings_in_list
      'Invoice No:'
          'Fee:'
          'Department: '
    ];
    final List<String> data = <String>[
      '14 August',
       '14 August',
      '188069',
      '177973',
      '100.0',
      'Opthalmology'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: always_specify_types
      children: List.generate(titles.length, (int index) {
        final String title = titles[index];
        final String value = data[index];

        return 
        Container(
      width: 200,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(title,)),
          Text(value, ),
        ],
      ),
    );
        // buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildPdfPage(HeadingTitle headingTitle) => Column(
        children: <Widget>[
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(headingTitle.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.subTitle, style: const TextStyle(fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.consultation, style: const TextStyle(fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.slip, style: const TextStyle(fontSize: 17)),
        ],
      );

  

  static Widget buildFooter(PDF invoice) => Column(
        children: <Widget>[
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(children: <Widget>[
            Expanded(child:  
                Text('14 August'),
            ),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Column(
                children:<Widget>[
                // ignore: lines_longer_than_80_chars
                Text('_ _ _ _ _ _ _ _ _ _ _ _ ',style: pw.TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),

                Text("Doctor's Name & Signature"),
                ])
           ])
        ],
      );

  static pw.Row buildSimpleText({
    required String title,
    required String value,
  }) {
    final pw.TextStyle style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: <Widget>[
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }
}
