import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:feed_me/constants/styles/colors.dart';
import 'package:feed_me/constants/styles/text_style.dart';
import 'package:flutter/material.dart';

class Impressum extends StatelessWidget {
  const Impressum({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [basicColor, deepOrange])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text("Impressum",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: openSansFontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: (Container(
                  width: size.width * 0.95,
                  height: size.height * 0.8,
                  child: FadeInUp(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: const AutoSizeText(
                        'Angaben gem. § 5 TMG:\n'
                        '\nCodeSeed UG.\n'
                        'Tobias, Neidhardt und Maximilian, Drescher\nZum Rosenberg 2\n97334, Sommerach\n'
                        '\nKontaktaufnahme:\n'
                        'E-Mail: codeseed.wue@gmail.com\n'
                        '\nUmsatzsteuer-ID\n'
                        '\nUmsatzsteuer-Identifikationsnummer gem. § 27 a Umsatzsteuergesetz:\n'
                        'DE XXX XXX XXX\n'
                        '\nHaftungsausschluss – Disclaimer:\n'
                        'Haftung für Inhalte Alle Inhalte unseres Internetauftritts wurden mit größter Sorgfalt und nach bestem Gewissen erstellt. Für die Richtigkeit, Vollständigkeit und Aktualität der Inhalte können wir jedoch keine Gewähr übernehmen. Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen. Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt.'
                        'Eine diesbezügliche Haftung ist jedoch erst ab dem Zeitpunkt der Kenntniserlangung einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden von den o.g. Rechtsverletzungen werden wir diese Inhalte unverzüglich entfernen.\n'
                        '\nUrheberrecht:\n'
                        'Die auf unserer Webseite veröffentlichen Inhalte und Werke unterliegen dem deutschen Urheberrecht (http://www.gesetze-im-internet.de/bundesrecht/urhg/gesamt.pdf) . Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der Verwertung des geistigen Eigentums in ideeller und materieller Sicht des Urhebers außerhalb der Grenzen des Urheberrechtes bedürfen der vorherigen schriftlichen Zustimmung des jeweiligen Urhebers i.S.d. Urhebergesetzes (http://www.gesetze-im-internet.de/bundesrecht/urhg/gesamt.pdf ). Downloads und Kopien dieser Seite sind nur für den privaten und nicht kommerziellen Gebrauch erlaubt. Sind die Inhalte auf unserer Webseite nicht von uns erstellt wurden, sind die Urheberrechte Dritter zu beachten. Die Inhalte Dritter werden als solche kenntlich gemacht. Sollten Sie trotzdem auf eine Urheberrechtsverletzung aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Inhalte unverzüglich entfernen.',
                        stepGranularity: 1.0,
                        style: TextStyle(
                            fontFamily: openSansFontFamily, fontSize: 18)),
                  ),
                )),
              ),
            )));
  }
}
