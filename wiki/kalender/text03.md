# Vorbei mit Optik

Es ist wichtig, dass Ihr Euch Zeit nehmt an dieser Stelle und wirklich so lange an Eurem Kalender bastelt, bis Ihr recht zufrieden mit dem Resultat seid. Man kann sich immer etwas Neues vornehmen und das dann gezielt umsetzen, wenn man danach googelt. Kleine Herausforderungen wären:

* Der heutige Tag soll besonders markiert sein, zum Beispiel durch eine andere Hintergrundfarbe
* Samstage und Sonntage sollen anders aussehen
* Jeder Tag soll in einem Kästchen dargestellt sein
* Die Elemente (Kalenderblatt, Info, Historie) stehen nicht mehr lieblos untereinander, sondern jedes hat seine eigene Position am Bildschirm (Google Begriff: "CSS grid", einfach inspirieren lassen).

Der wesentliche Lerneffekt an dieser Stelle sollte sein: Es geht alles in CSS. Theoretisch kann man auch Animationen einbauen oder den Kalender als halbtransparente Folie **über** die Historie legen. Das müsst Ihr alles im Detail nicht kennen, aber Euch muss bewusst sein, wie umfangreich die Layout-Möglichkeiten im Web und (aus Konkurrenzgründen dann unmittelbar auch) überall sind.

## Zwischenstand

Ihr habt jetzt eine optisch passable Seite für diesen Tag, bei mir der 08.02.2021. Bei mir sieht das Ganze folgendermaßen aus. Man beachte, dass ich mir schon einen Bereich "debug" eingebaut habe, den ich später brauchen werde und den ich mehr oder weniger rot eingefärbt habe. Den würde ich wieder rausnehmen, wenn wir die Seite veröffentlichen (würden).

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_02.png)

Ihr sollt meinen Code nicht kopieren, aber erreicht habe ich das mit folgender HTML:

```
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="step3.css" />
    <title>Kalender vom 08.02.2021</title>
</head>

<body>
    <div id="seitenkopf">
        <h1>Mein Kalenderblatt: 08.02.2021</h1>
    </div>
    <div id="kalenderblatt">
        <table>
            <thead>
                <tr>
                    <th colspan="8">Februar 2021</th>
                </tr>
                <tr>
                    <th class="kw">Kw</th>
                    <th class="mo">Mo</th>
                    <th class="di">Di</th>
                    <th class="mi">Mi</th>
                    <th class="do">Do</th>
                    <th class="fr">Fr</th>
                    <th class="sa">Sa</th>
                    <th class="so">So</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="kw">5</td>
                    <td class="mo">1</td>
                    <td class="di">2</td>
                    <td class="mi">3</td>
                    <td class="do">4</td>
                    <td class="fr">5</td>
                    <td class="sa">6</td>
                    <td class="so">7</td>
                </tr>
                <tr>
                    <td class="kw">6</td>
                    <td class="mo heute">8</td>
                    <td class="di">9</td>
                    <td class="mi">10</td>
                    <td class="do">11</td>
                    <td class="fr">12</td>
                    <td class="sa">13</td>
                    <td class="so">14</td>
                </tr>
                <tr>
                    <td class="kw">7</td>
                    <td class="mo">15</td>
                    <td class="di">16</td>
                    <td class="mi">17</td>
                    <td class="do">18</td>
                    <td class="fr">19</td>
                    <td class="sa">20</td>
                    <td class="so">21</td>
                </tr>
                <tr>
                    <td class="kw">8</td>
                    <td class="mo">22</td>
                    <td class="di">23</td>
                    <td class="mi">24</td>
                    <td class="do">25</td>
                    <td class="fr">26</td>
                    <td class="sa">27</td>
                    <td class="so">28</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="introtext">
        <p>
            Der 08.02.2021 ist ein Montag und zwar der zweite Montag im Monat Februar des Jahres 2021. Dieser Monat hat 28 Tage. Der 08.02.2021 ist kein gesetzlicher Feiertag in Hessen. Der nächste gesetzliche Feiertag ist der 02.04.2021 (Karfreitag).
        </p>
    </div>
    <div id="debug">
        (Test)
    </div>
    <div id="historie">
        <p>
            Historische Ereignisse am 08.02.
        </p>
        <ul>
            <li>Vor 23 Jahren: Die Schwarzwaldklinik strahlt ihre 1000. Folge aus</li>
            <li>Vor 40 Jahren: Ein Schrank fällt vom Dach in Wolfhagen</li>
            <li>Vor 3020 Jahren: Ein Schnitzfehler auf einem sumerischen Abakus geht als erster Computerbug in die Geschichte ein.</li>
        </ul>
    </div>
</body>
</html>
```

und mit folgender CSS:
```
/*==============================================================================
// BODY: Grundlegender Aufbau des Grids                                       //
==============================================================================*/

body {
    display: grid;
    grid-template-columns: 1fr 2fr;
    /*Im Verhältnis 1:2 wird der Bildschirm aufgeteilt*/
    margin: 0;
}


/*==============================================================================
// SEITENKOPF                                                                 //
==============================================================================*/

#seitenkopf {
    padding: 1em;
    text-align: center;
    background: darkblue;
    color: white;
    grid-column-start: 1;
    grid-column-end: 3;
    /*Seitenkopf geht über beide Spalten*/
}

#seitenkopf h1 {
    margin: 0;
    padding: 0;
}


/*==============================================================================
// INTROTEXT UND HISTORIE                                                     //
==============================================================================*/

#introtext,
#historie {
    padding: 1em;
    grid-column-start: 2;
    /*Historie und Introtxt sind hingegen nur rechts in der Spalte zuhause*/
    grid-column-end: 3;
    margin: 1em;
    font-size: 1.3em;
    padding: 1em;
}


/*==============================================================================
// KALENDERBLATT                                                              //
==============================================================================*/

#kalenderblatt {
    border-bottom: 1px solid darkblue;
    /*Border unten um das gesamte Feld*/
    border-right: 1px solid darkblue;
    /*Border rechts um das gesamte Feld*/
}

#kalenderblatt table {
    margin: 25px auto;
    /*Oben und unten 25 Punkte Abstand zu allem (zu den Grenzen des DIVs), links und rechts auto = zentriert*/
    border-right: 1px solid darkblue;
    /*Border rechts um gesamte Tabelle*/
    border-bottom: 1px solid darkblue;
    /*Border unten an gesamter Tabelle*/
    /*Die Border nach links und oben ziehen wir in den einzelnen Zellen*/
    border-spacing: inherit;
}

#kalenderblatt table th {
    border-top: 1px solid darkblue;
    /* Jede th-Zelle bekommt oben / links eine Border*/
    border-left: 1px solid darkblue;
}

#kalenderblatt table td {
    background: white;
    text-align: center;
    padding: 0.25em;
    /*Bisserl Platz um den Inhalt der einzelnen Zellen (Datumswerte)*/
    border-top: 1px solid darkblue;
    /*Jede td-Zelle erhält eine linke und obere Border, auf diese Weise ergibt sich dann das Gitternetz*/
    border-left: 1px solid darkblue;
    cursor: pointer;
    /*Mauszeiger verändert Form, wenn wir über die Tabellenzellen fahren, um anzuzeigen, dass man hier sinnvollerweise klicken kann*/
}

#kalenderblatt td:hover {
    background: yellow;
    /*Hintergrund gelb, wenn man mit der Maus drüber fährt*/
}

#kalenderblatt td.heute {
    background: pink;
    /*Der heutige Tag wird markiert*/
}

#kalenderblatt td.heute:hover {
    background: yellow;
    /*Der heutige Tag wird auch gelb beim Drüberfahren*/
}

#kalenderblatt td.sa {
    color: darkblue;
    /*Samstage sind blau dargestellt*/
}

#kalenderblatt td.so {
    color: red;
    /*Sonnage sind rot dargestellt*/
}

#kalenderblatt td.kw {
    font-style: italic;
    /*Kw-Angaben kleiner und in Kursivschrift*/
    font-size: 0.9rem;
    cursor: unset;
    /*Kw kann man nicht klicken, also Cursor anders*/
    color: grey;
}

#kalenderblatt td.kw:hover {
    background: unset;
    /*Nix passiert, wenn man über KW hovert*/
}


/*==============================================================================
// DEBUG                                                                      //
==============================================================================*/

#debug {
    background: lightcoral;
    border-right: 1px solid darkblue;
    border-bottom: 1px solid darkblue;
}
```

Wie gesagt, Ihr sollt den Text nicht kopieren und es ist cool, wenn Eure Ergebnisse gar schöner sind. Mir hat es an der Stelle gereicht. Eine wichtige Anregung sind lediglich die Kommentare, die ich (insbesondere in der CSS) gemacht habe. In jeder Sprache gibt es Kommentarzeichen, die bestimmte Bereiche "auskommentieren". Das heißt, dass dort nicht nach Befehlen gesucht wird und soher auch keine Fehler auftreten, wenn man egal was hinein schreibt. Das dient vor allem Euch und den Leuten, die mit Eurem Code arbeiten müssen, als Hilfe. Hier habe ich, um Euch zu helfen, exzessiv kommentiert. In echt wäre das weniger, aber diese simplen Ordnungs-Kommentare, wie ich sie mit den Zwischenüberschriften in der CSS gemacht habe, helfen mir massiv bei der Übersicht. Gerade CSS-Dateien verkommen ohne jede Ordnung zu einem großen Chaos, da es irgendwann tausende kleiner Einzelvorschriften sind, ohne echten Zusammenhang.

```
HTML
<!-- Kommentar bis zu -->

CSS
/* Kommentar bis zu */

Dart/Flutter
// Kommentar bis zum Ende der Zeile
/* Kommentar bis zu */

(mit den "Kommentar bis zu" kann man dann auch mehrzeilige Kommentare machen)
```

## Ein Problem
Die Chance ist recht hoch, dass Ihr, wenn Ihr die Seite heute aufruft, nicht das aktuelle Kalenderblatt seht, sondern das von gestern, vorgestern, letzter Woche oder einem komplett aus Eurer Sicht zufälligen Datum der Vergangenheit. Was, wenn wir aber immer das **heutige** Kalenderblatt zeigen wollen?

Eine Herangehensweise wäre, einfach eine Datei für jedes Datum in den nächsten 20 Jahren anzulegen. :-)

Die andere Herangehensweise ist, dass wir dem Computer beibringen müssen, alle Inhalte auf den heutigen Tag anzupassen. Und dafür nutzen wir nun Javascript. Javascript ist eine Programmiersprache (und ja, die erste, mit der wir uns nun befassen, weil HTML/CSS nur Inhalte bzw. Layout beschreiben). Sie wird vor allem im WWW benutzt (aber auch für Apps etc.). Visual Studio Code, mit dem Ihr arbeitet, ist zum Beispiel auch auf Javascript-Basis programmiert. Im WWW-Bereich ist die Besonderheit, dass Javascipt-Code zusammen mit der HTML-Seite an den Besucher einer Webseite (Client) versendet wird und dass dessen Browser dann den Javascipt-Code ausführt. Er wird dann auf dem Client-Rechner interpretiert, also in Maschinensprache übersetzt. Daher ist Javascript nicht sonderlich performant, aber moderne Maschinen sind auch so schnell, dass das nicht ins Gewicht fällt. Im WWW-Bereich entlastet es sozusagen den Server, weil der Client die Berechnungen durchführt, nicht der Server.

Ähnlich wie bei der CSS-Einbindung müssen wir auch unserer HTML die Javascript-Datei mitgeben, also das Javascript einbinden in unseren HTML-File. Sowohl bei CSS als auch bei Javascript wäre es auch möglich, den Code **direkt in der HTML-Datei** unterzubringen. Man müsste CSS-Code nur in `<style></style>`-Tags verpacken und den Javascript-Teil in `<script></script>`-Tags. Aber aus Übersichtlichkeitsgründen trenne ich das in der Regel, erstelle also eine neue Javascript-Datei in unserem Projekt. Damit Javascript erkannt wird, sollte sie die Dateierweitung .js haben. In meinem Beispiel ist es "step4.js" (und ansonsten gibt es "step4.html" und "step4.css").

`<script language="javascript" type="text/javascript" src="step4.js"></script>`

Diese Zeile fügte ich in meine HTML-Datei im HEAD irgendwo hinzu. Die Position ist übrigens eigentlich egal. Bei umfangreichen Webseiten mit viel Suchmaschinenoptimierungen werden JS-Dateien immer sehr am Ende des HTML eingefügt, damit die Inhalte schonmal geladen sind, bevor die JS geladen wird. Aus Übersichtlichkeitsgründen packen wir es nach oben.

Packt mal als erstes in Eure Javascript-Datei nur eine Zeile: `alert('Javascript funktioniert!');`

Wenn Ihr beim nächsten Laden Eurer Seite ein entsprechendes Fenster angezeigt bekommt, dann hat die Verknüpfung von HTML und JS geklappt.

## Grundstock für Eure Arbeit

Folgende JS können wir als Grundstock nutzen:
```
// Hier sagen wir dem Browser nur, dass erm nachdem die Seite vollständig geladen
// wurde, die Funktion main(ohne Argumente) aufrufen soll.
window.onload = function() {
    main();
};

function main() {
    // Grund-Daten
    var strDebug = "";
    var datToday = new Date();
    strDebug += "datToday: " + datToday.toDateString() + "<br/>"; // Ausgabe
    var datTodayGerman = getDateGerman(datToday);
    strDebug += "datTodayGerman: " + datTodayGerman + "<br/>"; // Ausgabe

    // Wochentag
    var weekday = datToday.getDay(); // ergibt den Tag der Woche als Zahl (von 0 = Sonntag bis 6 = Samstag)
    strDebug += "weekday: " + weekday + "<br/>"; // Ausgabe
    var weekdayGerman = getWeekdayGerman(weekday);
    strDebug += "weekdayGerman: " + weekdayGerman + "<br/>";

    // Ausgabe in das elDebug
    var elDebug = document.getElementById("debug");
    if (elDebug != null) {
        elDebug.innerHTML = strDebug;
    } else {
        console.log("Debug-Element nicht gefunden.");
    }
}

function getDateGerman(date) {
    day = date.getDate();
    month = date.getMonth();
    month = month + 1; // Warum auch immer ... Javascript speichert Monate 0-basiert, also 0 = Januar, 11 = Dezember, daher hier Korrektur + 1
    year = date.getFullYear();
    // Man beachte: Man könnte hier nachfolgend nach dem if {} benutzen, aber da es sich nur um EINE nachfolgende Anweisung handelt, geht es auch so
    if (String(day).length == 1) day = "0" + day;
    // Nachfolgend alternativ MIT Klammern
    if (String(month).length == 1) {
        month = "0" + month;
    }
    dateGerman = day + "." + month + "." + year;
    return dateGerman;
}

function getWeekdayGerman(weekdayIndex) {
    if (weekdayIndex == 0) {
        return "Sonntag";
    } else if (weekdayIndex == 1) {
        return "Montag";
    } else if (weekdayIndex == 2) {
        return "Dienstag";
    } else if (weekdayIndex == 3) {
        return "Mittwoch";
    } else if (weekdayIndex == 4) {
        return "Donnerstag";
    } else if (weekdayIndex == 5) {
        return "Freitag";
    } else if (weekdayIndex == 6) {
        return "Samstag";
    }
}
```

Voraussetzung dafür, dass der Code funktioniert, ist, dass Ihr auch einen div-Bereich mit der id "debug" in Eurem HTML-Code habt. Bei mir war es der rote Bereich. Macht Euch das irgendwie so, dass das gegeben und erkennbar ist.

Und nun versucht, den Code nachzuvollziehen. Ich mach das jetzt quasi zeilenweise:

* In der window.onload Zeile sagen wir dem Browser, dass er warten soll, bis alles geladen wurde und dann soll er die Funktion main() aufrufen. Auf diese Weise haben wir uns einen klaren Einstiegspunkt kreiert.
* Dann wird die function main() definiert. Alles, was innerhalb ihrer öffnenden und schließenden Klammer liegt, gehört zur Funktion. Ihr seht es daran und an den Einrückungen. Die Funktion main akzeptiert keine Argumente (daher `()`).
* Zuerst wird in einer Variablen strDebug ein leerer String (Zeichenkette) gespeichert. Javascript-Variablen haben keinen klaren Typ und daher müssen wir nichts festlegen wie int, String, etc. in anderen Sprachen. Der leere String dient nur dazu, dass die Variable nicht den typischen Initialisierungswert `null` beinhaltet, der ansonsten in Zukunft immer für Zusatsatzaufwand sorgen würde, weil ich z.B. beim Verketten von Strings immer erst prüfen müsste, ob die Variable nicht null enthälz.
* In datToday speichern wir das heutige Datum (samt Uhrzeit etc.).
* Wir fügen dem strDebug-String jetzt "datToday: " hinzu und dann dem Wert von datToday als String und am Ende noch ein `<br/>`, was einfach einen Zeilenumbruch in HTML darstellt. Sprich: Was auch immer wieder später hinzufügen, steht eine Zeile tiefer. Wir wollen das später alles ausgeben und dann helfen die Umbrüche beim Lesen.
* Dann definieren wir eine Variable datTodayGerman und weisen ihr das Ergebnis der Funktion getDateGerman, bezogen auf das mitgegebene Argument datToday zu. Sprich: Da gibt es eine Funktion und die gibt es einen deutsch formatierten Datum-String zurück. Sprich aus '2020/11/3" wird 03.11.2020. Die Funktion getDateGerman ist natürlich keine mitgelieferte JS-Funktion, sondern eine, die wir uns selbst geschrieben haben und **zu der wir noch kommen werden**.
* Auch den Inhalt von datTodayGerman (also den Rückgabewert der Funktion getDateGerman) hängen wir an strDebug an. Kurz gesagt: strDebug nutzen wir, um uns alles, was wir berechnen, mal anzeigen zu lassen, sodass wir sehen, wenn an irgendeinem Punkt ein Fehler vorliegt.
* Dann speichern wir in die Variable weekday den Rückgabewert der Methode (das ist eine Funktion, die zu einer Klasse gehört - hier der Datumsklasse). Mit anderen Worten: getDay() kann man auf jedes Datum anwenden, um dessen Wochentag zu ermitteln. Diese Funktion ist von Javascript mitgeliefert, mussten wir also nicht selbst schreiben. Der weekday ist dann aber eine Zahl, beginnend bei 0 = Sonntag und gehend bis 6 = Samstag.
* Dann kreieren wir eine Variable weekdayGerman und speichern in diese den Rückgabewert der Funktion getWeekdayGerman, bezogen auf den berechneten weekday. Mit anderen Worten: Wir wollen hier aus der Information "3" dann eben die Information "Mittwoch" berechnen. Dafür gibt es keine JS-Funktion. Auch diese Funktion müssen wir daher selbst schreiben. **Und darauf kommen wir auch zurück.**
* Auch das Ergebnis wird an strDebug angehanden.
* Nun finden wir in dem document (das ist die HTML-Seite, die im Browser angezeigt wird) das Element mit der id "debug". Dieses Element (das ist in meinem Code das gesamte DIV, das uns auf der Seite rot dargestellt wird) speichern wir in die Variable elDebug.
* Wir prüfen, ob wir es wirklich gefunden haben: Wenn ja, dann ist elDebug **nicht null**.
* Wenn wir also dieses DIV gefunden haben, packen wir den gesamten Inhalt von strDebug (also alle unsere gesammelten Debug-Texte) dort hinein. Das .innerHTML eines Elements ist der gesamte HTML-Code innerhalb dieses Elements. Zurückkommend zu meinem HTML-Code:
```
    <div id="debug">
        Test
    </div>
```
* In dem Fall ist der Inhalt von dem Element mit der id "debug" eben "Test". Dieser Inhalt wird nun **ersetzt** mit dem Inhalt von strDebug. Daher wird uns, wenn alles klappt, das auch angezeigt, weil es nun **direkt im HTML-Code steht**.
* Wenn wir keine id "debug" gefunden haben, geben wir eine Konsolenmeldung aus. Konsolenmeldungen sieht man übrigens nur, wenn man im Browser den Inspector öffnet (F12 oder Shift+Strg+I oder Rechtsclick irgendwo ins HTML und "Untersuchen"). Dann im Inspektor die Konsole auswählen, dann sehen wir eventuelle Meldungen hier. Wir könnten auch `alert("Nichts gefunden")` stattdessen benutzen und dann wäre es ein Popup-Fenster stattdessen.

Das war die void main(). Kommen wir nun zu den beiden Spezialfunktionen, die wir uns gebaut haben:

### getDateGerman(date)
Die Funktion erwartet ein Datum als Parameter (das steht nirgendwo, aber so ist sie geschrieben. Würde man sie mit einem String füttern als Argument, gäbe es wohl einen Fehler).
* Dann extrahiert die Funktion aus dem Datum date den Tag, den Monat und das Jahr. Javascript hat die seltsame Eigenheit, dass Monate 0-basiert (0 = Januar bis 11 = Dezember) behandelt werden, Tage aber beispielsweise nicht. Das korrigieren wir, indem wir beim Monat 1 addieren.
* Dann prüfen wir, ob der Tag, umgewandelt zu einem String (also aus `1` wird `"1"`) eine Länge von genau einem Zeichen hat. Das ist dann der Fall, wenn unser Datum der erste bis neunte eines Monats ist. Wenn dem so ist, dann verketten wir "0" und die Monatszahl. Ansonsten ist es eben die Monatszahl. Im Hintergrund wandelt Javascript, das ja keine feste Typen kennt, eine Zahl automatisch zu einem String um, wenn wir Strings verketten.
* Das selbe passiert dann mit dem Monat.
* Dann bauen wir alles zusammen: (Ggf. mit vorangestellter 0)Tag.(Ggf. mit vorangestellter 0)Monat.Jahr
* Das ist dann der Rückgabewert, den wir per return zurückgeben an die Stelle, wo die Funktion aufgerufen wurde.
* Und so wurde aus dem Datum, das wir gerade haben, ein deutsch formatiertes Datum.

### getWeekdayGerman(weekdayIndex)
* Als Weekday-Index erhaten wir eine Zahl zwischen 0 (Sonntag) und 6 (Samstag).
* Jetzt erfolgt eine Fallunterscheidung. Je nachdem, welcher Wert uns geliefert wurde, geben wir einen String mit dem passenden Wochennamen zurück.

## Und JETZT dynamisieren wir Infos auf der Webseite
Guckt Euch die Webseite an. Ihr werdet sehen, dass, wenn alles richtig läuft, im Debug-Kasten korrekte Informationen zum heutigen Tag stehen. Dummerweise steht auf Eurer Seite ansonsten immer noch der alte Krempel. Schaut Euch im Inspektor an, was im Debug-Kasten steht: Dort steht das, was wir im Javascript reingeschrieben haben. Nicht mehr das, was laut HTML da stand. Folglich ist unsere Aufgabe, an anderen Stellen einen ähnlichen Effekt zu erzielen: Wir wollen die Altinformationen ersetzen durch neue Informationen. Damit das gelingen kann, müssen unsere Bereiche, wo zu aktualisierende Informationen stehen, auch per id direkt ansprechbar sein. Dafür ändere ich meinen HTML-Code an zuerst einmal zwei Stellen.

```
    <div id="seitenkopf">
        <h1>Mein Kalenderblatt: <span id="field1">(Datum deutsch)</span></h1>
    </div>
```
Statt einem Datum steht dort nun ein `<span></span>`-Element. Span ist ein HTML-Element, das für sich genommen gar nix tut. Es definiert halt einen Bereich in einem Text. Man könnte dann per CSS dafür sorgen, dass alle `<span class="bold">`-Bereiche fett geschrieben sind. Für sowas ist das eigentlich gut. Uns dient es dazu, die Bereiche zu markieren, deren Inhalte wir verändert wollen, denn nun haben diese Bereiche einen eindeutigen Bezeichner, die id "field1" in diesem Fall. Der Text "(Datum deutsch)" dient mir nur als Gedächtnisstütze, welche Info da rein soll - er wird ja eh überschrieben.

```
    <div id="introtext">
        <p>
            Der 08.02.2021 ist ein <span id="field2">(Wochentag)</span> und zwar der zweite Montag im Monat Februar des Jahres 2021. Dieser Monat hat 28 Tage. Der 08.02.2021 ist kein gesetzlicher Feiertag in Hessen. Der nächste gesetzliche Feiertag ist
            der 02.04.2021 (Karfreitag).
        </p>
    </div>
```
Das ist meine zweite Ersetzung. Die span mit der id "field2" (wir erinnern uns: IDs müssen eindeutig sein). Wir brauchen also einmal den korrekt formatierten Wochentag und einmal das deutsch formatierte Datum, um die Ersetzungen vornehmen zu können. Und wie der Zufall es will: Beide Informationen liegen uns ja in unserem JS-Code schon vor. Wir ergänzen unsere JS-Datei um ein paar Zeilen und erhalten unsere main-Funktion. **Wohlgemerkt: Alle anderen Teile der JS-Datei bleiben unverändert)

```
function main() {
    // Grund-Daten
    var strDebug = "";
    var datToday = new Date();
    strDebug += "datToday: " + datToday.toDateString() + "<br/>"; // Ausgabe
    var datTodayGerman = getDateGerman(datToday);
    strDebug += "datTodayGerman: " + datTodayGerman + "<br/>"; // Ausgabe

    // Wochentag
    var weekday = datToday.getDay(); // ergibt den Tag der Woche als Zahl (von 0 = Sonntag bis 6 = Samstag)
    strDebug += "weekday: " + weekday + "<br/>"; // Ausgabe
    var weekdayGerman = getWeekdayGerman(weekday);
    strDebug += "weekdayGerman: " + weekdayGerman + "<br/>";

    // Wir füllen die Informationen in den HTML-Code
    document.getElementById("field1").innerHTML = datTodayGerman;
    document.getElementById("field2").innerHTML = weekdayGerman;

    // Ausgabe in das elDebug
    var elDebug = document.getElementById("debug");
    if (elDebug != null) {
        elDebug.innerHTML = strDebug;
    } else {
        console.log("Debug-Element nicht gefunden.");
    }
}
```

Neu sind dabei nur die folgenden Zeilen:
```
    // Wir füllen die Informationen in den HTML-Code
    document.getElementById("field1").innerHTML = datTodayGerman;
    document.getElementById("field2").innerHTML = weekdayGerman;
```
An die beiden Stellen im Code werden also unsere berechneten Werte geschrieben und wenn alles gut geht, dann sind diese beiden Stellen der Seite nun aktualisiert.

### Kurzer Tipp zwischendurch
Um mir die Übersicht zu erleichtern, hab ich mir noch folgende CSS-Regel eingerichtet:
```
span {
    background: lightcoral;
}
```
Auf diese Weise sehe ich, welche Spans ich schon eingerichtet habe und welche nicht.

## Was nun?
Jetzt könnt Ihr Euch eine Weile mit der Aktualisierung der Seite beschäftigen. Bezogen auf meinen Webseiteninhalt gilt:
* Das deutsch formatierte Datum kommt noch dreimal (inkl. Historie) im Text vor. Kein Problem, denn ich hab schon den Inhalt, der da stehen will. Es müssen nur die spans definiert und die Ersetzungen vorgenommen werden.
* Den Wochentagnamen hab ich nochmal im Text stehen. Selbe Problemlage. Ich hab schon alles, was ich brauche.
* Ich brauch das Jahr einfach so, ohne Zusatz an einer Stelle. Wir haben aber schon an anderer Stelle mal das Jahr aus einem Datum extrahiert, ist also relativ einfach.
* Dann brauchen wir an einer Stelle den Klarnamen des Monats (z.B. "Februar"). Nun gut .. Wir haben an einer Stelle schonmal den Monat aus einem Datum extrahiert. Und aus dieser Zahl muss dann ein String mit dem Monatsnamen werden, was ziemlich ähnlich der Problemstellung bei dem Wochentagsnamen ist.... An der Vorgehensweise kann man sich orientieren.
* Dann brauchen wir die Information der wievielte Wochentag seiner Art das in dem Monat ist. Tipp: Wenn man weiß, um den wievielten Tag des Monats es sich handelt, dann kann man auch das herausfinden mit einer if/else-Konstruktion. Man muss sich nur vorher darüber Gedanken machen, wann ein gegebener Tag in einem gegebenen Monat der 1/2/3/4/5. seiner Art ist.
* Dann muss ich an einer Stelle wissen, wieviele Tage der Monat hat. Ich skizziere hier eine Lösung, deren Details Ihr dann herausfinden müsst: Der einfachste Weg, das herauszufinden, ist:
  * Ihr konstruiert ein neues Datum und zwar den Ersten des Monats, also mit dem gleichen Monat und Jahr wie unser Datum plus als Tagesangabe eben eine 1.
  * Ihr berechnet ein neues Datum als "Monatserster + 1 Monat" .... Dafür gibt es fertige Funktionen in Javascript, mit denen ihr zu einem Datum einen Zeitraum wie "1 Jahr" oder "1 Monat" addieren könnt, glaub ich. Bin zu faul, das zu recherchieren. Falls nicht, dann konstruiert Ihr eben ein neues Datum, für das gilt: Tag = 1, Monat = alter Monat + 1 (oder 1, falls alter Monat 12 war), Jahr = altes Jahr, außer alter Monat war 12.
  * Und von diesem Datum, also dem Ersten des **Folgemonats** zieht ihr 1 Tag ab! Der Tag-Anteil dieses neuen Datums ist dann die Info, wie viele Tage der aktuelle Monat hat.

Schon tatsächlich relativ fortgeschritten ist dann die Frage, wie man herausfinden kann, ob heute ein Feiertag ist. Mein erster Tipp wäre: Startet mit den fixen Feiertagen: Man kann relativ einfach prüfen, ob wir den 01.01., 01.05., 03.10., 25.12., 26.12. haben.

Viel Spaß