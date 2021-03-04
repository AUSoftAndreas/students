# Eile mit Weile
An dieser Stelle ist es nicht ratsam, direkt weiter zu hasten. Sowohl HTML, als auch CSS und Javascript sind ja für die meisten neu, und es sind gleich drei Sachen auf einmal. Stattdessem dreht sich dieser Teil des Tutorials eher um die Arbeitsweise generell.

## Indentation
Dieses englische Wort heißt einfach nur "Einrückung", also wenn ein Textabsatz am Anfang eingerückt ist, um Absatzwechsel besser kenntlich zu machen. Das steigert die Lesefreundlichkeit. Und ebenso ist es in (allen!) Programmiersprachen. Man vergleiche folgende HTML-Schnipsel:

```HTML
<body>
<div id="seitenkopf">
<h1>Mein Kalenderblatt: 
<span id="field1">(Datum deutsch)</span>
</h1>
</div>
<div id="introtext">
<p>
Der 08.02.2021 ist ein <span id="field2">(Wochentag)</span> und zwar 
der zweite Montag im Monat Februar des Jahres 2021. Dieser Monat hat 
28 Tage. Der 08.02.2021 ist kein gesetzlicher Feiertag in Hessen.
</p>
</div>
<div id="historie">
<p>
Historische Ereignisse am 08.02.
</p>
<ul>
<li>Vor 23 Jahren: Die Schwarzwaldklinik strahlt ihre 1000. Folge aus</li>
<li>Vor 40 Jahren: Ein Schrank fällt vom Dach in Wolfhagen</li>
<li>Vor 3020 Jahren: Ein Schnitzfehler auf einem sumerischen Abakus geht als 
erster Computerbug in die Geschichte ein.</li>
</ul>
</div>
</body>
```

und

```HTML
<body>
    <div id="seitenkopf">
        <h1>Mein Kalenderblatt: 
            <span id="field1">(Datum deutsch)</span>
        </h1>
    </div>
    <div id="introtext">
        <p>
            Der 08.02.2021 ist ein <span id="field2">(Wochentag)</span> und zwar 
            der zweite Montag im Monat Februar des Jahres 2021. Dieser Monat hat 
            28 Tage. Der 08.02.2021 ist kein gesetzlicher Feiertag in Hessen.
        </p>
    </div>
    <div id="historie">
        <p>
            Historische Ereignisse am 08.02.
        </p>
        <ul>
            <li>
                Vor 23 Jahren: Die Schwarzwaldklinik strahlt ihre 1000. Folge 
                aus.
            </li>
            <li>
                Vor 40 Jahren: Ein Schrank fällt vom Dach in Wolfhagen
            </li>
            <li>
                Vor 3020 Jahren: Ein Schnitzfehler auf einem sumerischen Abakus 
                geht als erster Computerbug in die Geschichte ein.
            </li>
        </ul>
    </div>
</body>
```

Im zweiten Bereich ist deutlich auf den ersten Blick erkennbar, dass beispielsweise **innerhalb** des Kasten (div) erst ein Textabsatz (p) erscheint und dann **nach** dem Textabsatz kommt eine ungeordnete Liste (ul), die wiederum 3 Listeneinträge (li) **enthält**. Im ersten Schnipsel muss man umständlich suchen, wenn man sich die Frage stellt, wann ein bestimmtes `div` wieder endet und dergleichen mehr.

Auch beim Schreiben selbst hilft das ungemein. Angenommen man hat ein schließendes Tag vergessen. Wenn der Text korrekt eingerückt ist, dann sieht man das sofort, weil man nicht auf der gleichen Einrückungsebene das schließende Element hat. Die IDE hilft da auch: Sie zeigt eine Verbindungslinie vom öffnenden zum schließenden Tag. Diese Linie muss oben und unten das öffnende / schließende Element berühren. Sie darf nicht unterbrochen werden von anderen Elementen (weil das ein Formfehler wäre ... ein Element kann beliebig viele "Tochterelemente" haben, also Elemente unterhalb von sich selbst, aber jedes Element hat genau ein, klar zu definierendes Mutterelement). Das gilt in HTML, aber ebenso auch für jeden Programmcode.

Wenn einem der Programmcode durch die Einrückungen zu weit nach rechts rutscht, sodass man kaum noch was Sinnvolles sieht, dann hat das einen oder mehrere dieser Gründe:
- Dein Monitor ist zu klein: 80 Zeichen darzustellen ist das absolute Minimum, ab 120 Zeichen kann man meines Erachtens vernünftig arbeiten.
- Deine Schriftgröße ist zu groß für den Monitor: Es mag sein, dass sie genau richtig oder noch zu klein für Deine Augen ist, aber sie ist zu groß für den Monitor. Große Monitore sind insbesondere bei nicht perfekten Augen wichtig. Da viele es nicht wissen: In modernen IDEs (und somit auch in VSCode) kannst Du den Text (bzw. alles) selbstverständlich zoomen. `Strg` + `+` oder `Strg` + `-`.
- Du hast zu komplexen Code: Wenn Du die dritte Fallunterscheidung in der Fallunterscheidung hast und die 3. Schleife in der Schleife, dann ist die Wahrscheinlichkeit recht hoch, dass man durch ein Ändern der Programmstruktur eine deutliche Vereinfachung erreicht, die dann zu weniger Einrückungen führt. Das beinhaltet das Auslagern von Code in Funktionen / Routinen / Methoden (was im Endeffekt alles das gleiche bezeichnet). Und wenn Du Dir angewöhnst, über solche komplexe Strukturen nachzudenken und sie, wenn es irgendwie geht, zu vereinfachen, dann ist das nicht nur schöner lesbar, sondern auch für Dich (oder andere) später leichter nachvollziehbar, wenn zum Beispiel Änderungen notwendig sind. Die Komplexität des Codes kann man sich in HTML nicht ganz aussuchen, weil es eben sein kann, dass man diese verschachtelten Inhalte hat - in allen anderen Sprachen schon. Auch in HTML gibt es aber Möglichkeiten zur Verflachung des Codes. Beispielsweise:
  - Angenommen Du hast ein Layout mit 3 Spalten und 4 Zeilen. Dann könntest Du den Code so schreiben, dass Du erst man ein `div` erstellst, dass die gesamte Seite umfasst (sowas nennt man oft einen Wrapper), dann die 3 Spalten (als `div`) öffnest und dann **innerhalb** dieser `div`-Elemente jeweils die Zeilen als neue `div`-Elemente platzierst. Das heißt, dass jeder tatsächliche Inhalt schonmal eine Mutter (Zeile), eine Großmutter (Spalte) und eine Uroma (Wrapper) hat, die jeweils nur dieser Struktur dienen.
  - Oder Du definierst das `body`-Element im CSS als grid (recherchiere "css grid") mit 3 Spalten und 4 Zeilen und platzierst dann **hintereinander** einfach die 12 `div`-Elemente, die im Grid platziert werden sollen. Jetzt hat jeder tatsächliche inhalt nur noch eine Mutter, das `div`, zu dem es nunmal gehört.
  - (Ja, natürlich gibt es noch andere Vorfahren, denn darüber hinaus gibt es dann ja noch den Body und das HTML-Root-Element (`<html>`). Allerdings gilt das ja in allen Fällen.)
- Und zuguter letzt kann man in den Einstellungen anpassen, wie viele Leerzeichen eine Einrückung sind. Wenn da gegenwärtig 4 eingestellt sind, könnt Ihr es auf zwei ändern. Das macht es **etwas** weniger übersichtlich, aber ist, wenn man sich dran gewöhnt ist, auch ganz okay, spart Euch aber einiges an Platz auf dem Monitor ein.

Es gibt tatsächlich für mich nichts störenderes als nicht ordentlich eingerückten Code. Oftmals hilft Euch die IDE bei der Arbeit. In VSCode beispielsweise formatiert die Tastenkombination `Shift`+ `Alt` + `f` Euren Code nach den für VSCode definierten Regeln. Nicht für jede Sprache ist das vorhanden. Weitere Sprachen kann man als Erweiterungen installieren. Mitunter gibt es auch alternative Formatierer als Erweiterungen. Außerdem könnt Ihr einstellen, dass VSCode jedes mal automatisch den Code formatiert, wenn Ihr die Datei speichert. Ich verrate Euch nicht wo Ihr das einstellen könnt ... **Stattdessen geht die Einstellungsmöglichkeiten alle mal durch.**

## Tastatur
Da heute ja jeder nur über Bildschirme wischt, sei an dieser Stelle mal gesagt, dass eine normalgroße Tastatur unerlässlich sein wird. Das muss kein Schnickschnack sein, für unter 20 Euro erhält man ja bereits eine gute Tastatur, die man dann ggf. auch an den Laptop oder das Pad anschließen kann. Das ist echt unerlässlich. Programmieren bedeutet Tippen. Größere Tasten bedeutet weniger Tippfehler. Mehr Tasten bedeuten mehr Möglichkeiten.

Generell muss man lernen, die Maus weniger und die Tasten mehr zu benutzen. Es gibt ein paar Tastatur-Funktionen, die man kennen sollte und die vielleicht nicht jedem geläufig sind:
- Wenn man `Shift` drückt, während man sich per Pfeiltasten bewegt (aber auch wenn man danach wohin clickt), dann markiert man damit Text. Das macht es beispielsweise schnell möglich, etwas auszuschneiden (`Strg`+ `x`), zu verschieben (ganze Zeile: `Alt` + `Pfeiltaste`), kopieren (`Strg` + `c` bzw. für ganze Zeile: `Shift` + `Alt` + `Pfeiltaste`, löschen (`Enf` oder `Rück`).
- Zum Anfang der Zeile springen: `Pos1`
- Einrücken: Am Anfang der Zeile: `Tab`
- Weniger einrücken: Am Anfang der Zeile `Shift` + `Tab`
- Cursor an mehreren Stellen im Code platzieren: `Alt` gedrückt halten und jede Stelle anclicken
- Wort markieren: Doppelclick (Okay, ist kein Tastaturkommando)
- Ganze Zeile markieren: Dreifachclick (dito)
- Ganze Zeile ein/auskommentieren (dazu gleich mehr): `Strg` + `#`

Zudem gibt es tolle weitere Tricks in VSCode:
- `Shift` + `Strg` + `Leerzeichen`: Eines der wichtigsten Kommandos überhaupt: Kommando-Palette ... Alle integrierten Befehle von VSCode.
- `Strg` + `Leerzeichen`: Vorschläge von VSCode zur gegenwärtigen Code-Stelle. Das ist das gleiche Menu, dass Euch sonst auch Vorschläge dazu macht, wie der Befehl, den Ihr gerade tippt, wohl weiter geht. Mitunter habt Ihr so aber schon die Möglichkeit, etwas auszuwählen, wo Ihr noch nichts getippt habt. Das ist insbesondere sinnvoll, wenn man eine komplexe Funtion mit benannten Parametern aufrust, wo man aber die Namen der Paramenter nicht genau kennt.
- Angenommen Ihr wollt an einer Stelle im Code arbeiten, aber müsst immer mal wieder an einer anderen Stelle nachschlagen, wie zum Beispiel die Variablen hießen:
  - Rechte Maustaste auf den Tab-Reiter (das Ding oberhalb des Codes, wo der Dateiname drin steht und das man klicken kann, wenn man zu diesem Code springen will) für die entsprechende Datei und "Split right" wählen (oder `Strg` + `^`) und dann hat man zwei Fenster zum gleichen Code. Ihr könnt eines auf die Nachschlagestelle einrichten und in dem anderen coden. Damit kann man auch erreichen, dass man eine Datei bearbeitet und gleichzeitig eine zweite sieht.
- Alle offenen Dateien schließen (und ggf. speichern) geht per Menu oder `Strg` + `k` + `w`     (`k` und `w` kann man nacheinander drücken)

Klickt Euch einfach mal durch die Menus und experimentiert. Neben jedem Menueintrag steht auch die Tastenkombination, die man stattdessen ausführen kann. Merkt Euch, was Ihr häufiger benutzt.

## Kommentare
In meinem Code in den vorigen Lektionen hatte ich massiv viel Kommentare eingebaut. Das war natürlich nur, weil es Euch das Verständnis des Codes erleichtern sollte. Aber auch ansonsten sind Kommentare ein wichtiges Mittel. Dabei ist das richtige Maß wichtig:
- Kommentiert keine Selbstverständlichkeiten aus Sicht eines Programmierers: `a++; //erhöht a um 1
- Kommentare sollen den Code lesbarer machen: Unterteilt den Code per Kommentar in Abschnitte, aber zerfasert den Code nicht.
- Kommentare sollen Euch hefen, wenn Ihr später den gleichen Code wieder anseht oder wenn ein anderer Fachmann den Code analysiert
- Keine Kommentare ist unschön, zu viele ist ebenso unschön
- Findet das richtige Maß: Mit der Zeit wird es weniger werden, weil Ihr mehr als selbstverständlich anseht .... Bremst Euch da bewusst und zwingt Euch zu einem Mindestmaß an Kommentierung.
- Auch wenn Ihr jetzt, wo Ihr in der Programmlogik steckt, vieles genau wisst (z.B. an welcher Stelle im Code berechne ich die Feiertage?), dann werdet Ihr Euch irgendwann neuen Problemen widmen und Ihr werdet die Logik dieses Codes vergessen. Und dann helfen die Kommentare Eures heutigen Ichs Eurem zukünftigen Ich, und das solltet Ihr immer im Auge haben.

## Debugging
Debugging ist der Prozes des Fehler-Suchens und -Bereinigens. Bei einer CSS oder HTML-Datei ist das ja relativ einfach: Man sieht sofort, wenn etwas nicht stimmt. Das fällt bei Code naturgemäß schwerer. Das Ergebnis ist nicht das erwartete, aber woran liegt das? Das ist von außen nicht immer einfach zu sehen. Fangen wir speziell mit Javascript an:

- Erste Stufe des Debuggings ist der Browser selbst, der Fehlermeldungen ausgibt.
- Per (je nach Browser) `Shift` + `Strg` + `i` oder `F12` oder Rechtsclick in den Browser und "Untersuchen" oder sonst irgendwie öffet Ihr den Inspector. Dort gibt es definitiv ein Tab namens "Konsole" (Console). Dort werden harte Fehlermeldungen ausgegen. Beispiel aus Firefox. Hier können wir beispielsweise sehen, dass ein Fehler in Zeile 17 unserer JS-Datei einen Fehler verursacht hat. Das erleichtert natürlich die Suche:
![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_debug_01.png)
- Es gibt auch die Möglichkeit, Eurerseits Text in die Konsole auszugeben. Wenn Ihr beispielsweise Zwischenergebnisse prüfen wollt, ob sie richtig sind, dann könnt Ihr im Code nach den jeweiligen Berechnungsschritten per `console.log(XXX)` etwas ausgeben, wobei XXX natürlich für das steht, was Ihr ausgeben wollt. Das kann ein Text sein, wenn Ihr beispielsweise prüfen wollt, ob der Code eine Fallunterscheidung auf der If-Seite oder der Else-Seite durchlaufen habt, dann gebt, je nachdem, unterschiedliche Meldungen aus. Oder gebt den Inhalt einer Variablen aus, damit Ihr sehen könnt, ob diese Variable zu dem Zeitpunkt den erwarteten Wert hatte.
- Und ....

### Die Luxus-Variante
Die konfortabelste Variante, Code auf Fehler hin zu untersuchen, ist VSCode selbst und die eingebauten Debugging-Tools. Kleines Problem allerdings: Das klappt so gut wie nie auf Anhieb (bei Flutter ja, aber bei Javascript selten). Wenn Ihr Glück habt, habt Ihr Glück. 

Also: Prinzipiell erstmal: Man kann das Debugging per VSCode starten per Menu:
![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_debug_03.png)

Relativ gut klappt es prinzipiell mit Chrome (mein Eindruck). Wenn die Standardvorgaben nicht klappen, dann müsst Ihr Euch in Eurem Project eine eigene Konfiguration einrichten per "Run" - "Add configuration" oder "Run - View configuration". Damit wird in Eurem Projekt ein Verzeichnis .vscode angelegt mit einer Datei "launch.json", in der die von Euch konfigurierten Debug-Möglichkeiten gespeichert werden. Mit dieser launch.json hab ich bei mir Edge und Firefox zum Laufen bekommen.

```JSON
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Microsoft Edge: This file",
            "request": "launch",
            "type": "pwa-msedge",
            "file": "${file}"
        },
        {
            "name": "Firefox: This file",
            "type": "firefox",
            "request": "launch",
            "reAttach": true,
            "file": "${file}"
        }
    ]
}
```

Da kann man experimentieren. Prinzipiell zu erwähnen ist, dass diese Konfiguration das File im Browser öffnen, das Ihr gerade im Editor anschaut. Mit anderen Worten: Ihr müsst die passende HTML-Datei angucken, dann auf Run & Debug klicken. Die Javascript-Datei für sich genommen bringt da nix.

Egal, sollte das irgendwann irgendwie laufen, dann gilt: In VSCode könnt Ihr Breakpoints in Eurem Code setzen. Das sind Punkte, an denen der Browser aufhören soll, den Code auszuführen und ab denen Ihr der Ausführung live zusehen wollt. Das Setzen geschieht durch Klick links von der entsprechenden Programmzeilen-Nummer, wodurch dann dort ein roter Punkt angezeigt wird.
![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_debug_02.png)

Wenn wir nun die entsprechende HTML debuggen, dann wird diese geladen und unser Javascript-Code wird eben **nicht** vollständig ausgeführt. Stattdessen erhalten wir einen Zustand wie diesen:

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_debug_04.png)

Wie man sieht: Der Code läuft noch, der Seiten-Lade-Indikator oben links bewegt sich. Die Ersetzungen in der Seite sind **noch nicht** vorgenommen. Die Debug-Box ist **noch nicht** gefüllt. Und im VSCode-Fenster sehen wir, dass die Code-Ausführung bei unserem ersten Breakpoint stoppte.

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender_debug_05.png)

Wenn wir links auf den Button "Run" gehen, dann sehen wir in dem linken Tab lauter Informationen zu unserem Code. Variablen, die im Umfeld verwendet wurden, auch noch nicht definierte Variablen (undefined). Wir sehen an dem gelben Bereich, in welcher Zeile wir gerade sind. Wir können mit dem Mauszeiger auf Objekte zeigen und uns deren gegenwärtigen Inhalt anzeigen lassen und oben rechts haben wir jetzt ein Bedienelement, was ein wenig wie die Bedienelemente an einem Videoplayer aussehen. Hiermit können wir uns jetzt bewegen:
- Der erste Button bedeutet "Mach weiter mit der Codeausführung bis zum nächsten Breakpoint" (bzw komplett, wenn es keine Breakpointe mehr gibt).
- Der zweite Button bedeutet "Mach weiter mit der nächsten Zeile"
- Der dritte Button bedeutet im Prinzip auch "Mach weiter mit der nächsten Zeile". Wenn die aktuelle Zeile aber Funktionen / Methoden etc. enthält, dann springen wir automatisch auch in **deren** Ausführung.
- Der vierte Button heißt, dass die Seite neu geladen wird, also alles von vorne beginnt.
- Der fünfte Button heißt, dass das Debugging und die Codeausführung beendet werden.

Mit diesem Tool lohnt sich das Spielen. Es ist unglaublich mächtig. Unten links kann man noch einstellen, welche Breakpoints gelten sollen. Hier werden die selbst definierten gelistet, aber es kann auch ausgewählt werden, ob Fehlermeldungen immer zum Anhalten führen sollen.

## Und nu?
Wenn Ihr den Code aus Lektion 3 selbst getippt habt oder aber wenn Ihr Eure ersten Gehversuche aufgrund der Aufgabenstellungen in Lektion 3 unternehmt, dann gibt es automatisch mehr als genug Anlässe zum Debuggen, denn Fehler gibt es immer.

Was Code angeht, den Ihr selbst entwickelt: Tut Euch selbst den Gefallen und fertigt Euch vor dem Schreiben mal eine Skizze an, was Ihr erreichen wollt und in welcher Reigenfolge etc. Wenn die Funktionalität in PSeudocode richtig beschrieben ist, dann ist das 75% der Miete.