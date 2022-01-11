import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfApi {
  static PdfColor orangeAccent = PdfColor.fromHex('FFAB40FF');
  static PdfColor deepOrange = PdfColor.fromHex('FF5722FF');

  static Future<File> generateRecipePdfView(
      String category,
      String description,
      String difficulty,
      String image,
      String ingredientsAndAmount,
      String name,
      String origin,
      String persons,
      String shortDescription,
      String time) async {
    final pdf = pw.Document();
    List<String> ingredients =
        getIngredientListFromString(ingredientsAndAmount);
    List<String> steps = getStepsFromString(description);
    final ingredientsData =
        ingredients.map((ingredient) => [ingredient]).toList();
    final stepsData = steps.map((steps) => [steps]).toList();
    final pw.PageTheme pageTheme = await _myPageTheme(PdfPageFormat.a3);

    //Three lines beneath are needed to get the network image to pdf
    pw.RawImage rawImage;
    final provider = await flutterImageProvider(NetworkImage(image));
    rawImage = provider;

    pdf.addPage(pw.MultiPage(
        pageTheme: pageTheme,
        build: (context) => [
              pw.Center(
                  child: pw.ListView(children: [
                pw.Text(name,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 25)),
                pw.SizedBox(height: 20),
                pw.Text(shortDescription, style: const pw.TextStyle(fontSize: 15)),
                pw.SizedBox(height: 20),
                pw.Image(rawImage, width: 600, height: 400),
                pw.SizedBox(height: 20),
                pw.Row(children: [
                  // pw.Icon(Icons.access_time),
                  pw.Spacer(),
                  pw.Text('Zubereitungszeit: ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Text(time, style: const pw.TextStyle(fontSize: 15)),
                  pw.Spacer(),
                  pw.Text('Schwierigkeit: ',
                      style: pw.TextStyle(
                          fontSize: 15, fontWeight: pw.FontWeight.bold)),
                  pw.Text(difficulty, style: const pw.TextStyle(fontSize: 15)),
                  pw.Spacer(),
                ]),
                pw.SizedBox(height: 20),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('Zutaten: ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Builder(
                          builder: (context) => pw.Table.fromTextArray(
                              cellAlignment: pw.Alignment.center,
                              border: null,
                              data: ingredientsData)),
                      pw.SizedBox(height: 20),
                      pw.Text('Zubereitungsschritte: ',
                          style: pw.TextStyle(
                              fontSize: 15, fontWeight: pw.FontWeight.bold)),
                      pw.Builder(
                          builder: (context) => pw.Table.fromTextArray(
                              cellAlignment: pw.Alignment.center,
                              border: null,
                              data: stepsData)),
                    ]),
              ])),
            ]));

    return saveDocument(name: '$name.pdf', pdf: pdf);
  }

  static Future<pw.PageTheme> _myPageTheme(PdfPageFormat format) async {
    return pw.PageTheme(
      pageFormat: format.applyMargin(
          left: 2.0 * PdfPageFormat.cm,
          top: 4.0 * PdfPageFormat.cm,
          right: 2.0 * PdfPageFormat.cm,
          bottom: 2.0 * PdfPageFormat.cm),
      buildBackground: (pw.Context context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.CustomPaint(
            size: PdfPoint(format.width, format.height),
            painter: (PdfGraphics canvas, PdfPoint size) {
              context.canvas
                ..setColor(orangeAccent)
                ..moveTo(0, size.y)
                ..lineTo(0, size.y - 1100)
                ..lineTo(1100, size.y)
                ..fillPath()
                ..setColor(orangeAccent)
                ..setColor(deepOrange)
                ..moveTo(size.x, 0)
                ..lineTo(size.x - 1100, 0)
                ..lineTo(size.x, 1100)
                ..fillPath()
                ..setColor(deepOrange);
            },
          ),
        );
      },
    );
  }

  static Future<File> saveDocument({
    String name,
    pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static List<String> getIngredientListFromString(String string) {
    List<String> ingredients = string.split('/');
    for (int i = 0; i < ingredients.length; i++) {
      ingredients[i] = '- ' + ingredients.elementAt(i);
    }
    return ingredients;
  }

  static List<String> getStepsFromString(String string) {
    List<String> steps = string.split('/');
    for (int i = 0; i < steps.length; i++) {
      steps[i] = (i + 1).toString() + '.' + steps.elementAt(i);
    }
    return steps;
  }
}
