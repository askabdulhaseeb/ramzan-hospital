import 'dart:io';
import '../api/pdf_api.dart';
import '../model/invoice.dart';
import '../model/headingTitle.dart';
import '../utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(PDF invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice),
        Divider(),
        medicineSpace(invoice)
        // SizedBox(height: 3 * PdfPageFormat.cm),
        // buildTitle(invoice),
        // buildInvoice(invoice),
        // buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget medicineSpace(
    PDF invoice,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 35),
            child: medicineLeftSpace(),
          ),
          Container(height: 450, child: VerticalDivider(thickness: 2)),
          medicineRightSpace(),
        ],
      );
  static Widget patientInfo_1(InvoiceInfo info) {
    final titles = <String>[
      'Father/Husband:',
      'Contact:',
      'CNIC:',
      'Address:'
          'Patient Type:'
          'Consultant: '
    ];
    final data = <String>[
      'Amin',
      '0316-7631138',
      'N/A',
      'N/A',
      'General',
      'N/A'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return   Container(
      width: 200,
      child: Row(
        children: [
          Expanded(child: Text(title,)),
          Text(value, ),
        ],
      ),
    );
        // buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget medicineRightSpace() {
    final titles = <String>[
      'Presenting Complaint',
      'History:',
      'Examination:',
      'Provisional Diagnosis:',
      'Treatment:',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];

        return Padding(
            padding: EdgeInsets.only(top: 10),
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
    final titles = <String>[
      'Vitals',
      'Pulse:',
      'BP:',
      'Temperature:',
      'Saturation:',
      'Investigations: ',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];

        return Padding(
            padding: pw.EdgeInsets.only(top: 10),
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
        children: [
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Hello World"),
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
            children: [
              patientInfo_1(invoice.info),
              patientInfo_2(invoice.info),
              Column(children: <Widget>[
                Text('Token No', style: TextStyle(fontSize: 15)),
                Text('32',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              ])
            ],
          ),
        ],
      );

  

  static Widget patientInfo_2(InvoiceInfo info) {
    
    final titles = <String>[
      'Reg Date & Time:',
      'Visit Date & Time::',
      'Visit No:',
      'Invoice No:'
          'Fee:'
          'Department: '
    ];
    final data = <String>[
      '14 August',
       '14 August',

      // Utils.formatDate(info.date),
      // Utils.formatDate(info.date),
      '188069',
      '177973',
      '100.0',
      'Opthalmology'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return 
        Container(
      width: 200,
      child: Row(
        children: [
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(headingTitle.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.subTitle, style: TextStyle(fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.consultation, style: TextStyle(fontSize: 17)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(headingTitle.slip, style: TextStyle(fontSize: 17)),
        ],
      );

  

  static Widget buildFooter(PDF invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Row(children: <Widget>[
            Expanded(child:  
                Text('14 August'),
            ),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Column(
                children:<Widget>[
                Text("_ _ _ _ _ _ _ _ _ _ _ _ ",style: pw.TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),

                Text("Doctor's Name & Signature"),
                ])
           ])
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  // static buildText({
  //   required String title,
  //   required String value,
  //   double width = double.infinity,
  //   TextStyle? titleStyle,
  //   bool unite = false,
  // }) {
  //   final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

  //   return Container(
  //     width: width,
  //     child: Row(
  //       children: [
  //         Expanded(child: Text(title, style: style)),
  //         Text(value, style: unite ? style : null),
  //       ],
  //     ),
  //   );
  // }
}
