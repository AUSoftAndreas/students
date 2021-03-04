# Nächste Schritte im Kalender-Projekt

Zunächst gilt es, sich einfach an die Art und Weise, wie man in VSCode schreibt, zu gewöhnen. Zum Beispiel daran, dass er, nachdem man ein Tag öffnete, einem automatisch das logischerweise später folgende schließende Tag schon hinschreibt, aber hinter die Cursor-Position, sodass man einfach weiter schreiben kann. Wenn man in diesem Moment `ENTER` drückt, dann erfolgt automatisch eine korrekte Einrückung. Man kann so auch gleich mehrere Tags öffnen und VSCode hilft einem dabei, dass man immer die schließenden Tags in der richtigen Reihenfolge vor sich her schiebt.

Produziert willentlich falsch eingerückten Code und Drückt (Shift + Alt + F) und alles ist wieder richtig eingerückt und auch ansonsten gut formatiert. Dieses "Auto Format" könnt Ihr in den Einstellungen von VSCode (File -> Preferences -> Settings) auch so einstellen, dass es immer automatisch passiert, wenn Ihr eine Datei speichert (Strg + S).

Wichtige Shortcuts ansonsten:
- (Alt + Pfeil auf/ab): Hiermit könnt Ihr eine Codezeile (oder einen ganzen Block) verschieben nach oben/unten.
- (Shift + Alt + Pfeil auf/ab): Hiermit könnt Ihr eine Codezeile (oder einen ganzen Block) kopieren und ihn ober/unterhalb einfügen.
- (Alt): Haltet die Taste gedrückt und klickt nacheinander auf drei Stellen im Code und tippt dann etwas -> Magic! :-)

## Weiter im HTML
Ihr hattet die Aufgabe, einen HTML-Code zu generieren, der auch einen Kalender anzeigt. Ich hab da mal ein Beispiel .... Bei den Sachen, die Ihr anders gemacht habt, versucht meine Lösung nachzuvollziehen... Sie muss nicht besser sein als Eure, nur für Euch nachvollziehbar.

```HTML
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    <th>Kw</th>
                    <th>Mo</th>
                    <th>Di</th>
                    <th>Mi</th>
                    <th>Do</th>
                    <th>Fr</th>
                    <th>Sa</th>
                    <th>So</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>5</td>
                    <td>1</td>
                    <td>2</td>
                    <td>3</td>
                    <td>4</td>
                    <td>5</td>
                    <td>6</td>
                    <td>7</td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>8</td>
                    <td>9</td>
                    <td>10</td>
                    <td>11</td>
                    <td>12</td>
                    <td>13</td>
                    <td>14</td>
                </tr>
                <tr>
                    <td>7</td>
                    <td>15</td>
                    <td>16</td>
                    <td>17</td>
                    <td>18</td>
                    <td>19</td>
                    <td>20</td>
                    <td>21</td>
                </tr>
                <tr>
                    <td>8</td>
                    <td>22</td>
                    <td>23</td>
                    <td>24</td>
                    <td>25</td>
                    <td>26</td>
                    <td>27</td>
                    <td>28</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="introtext">
        <p>
            Der 08.02.2021 ist ein Montag und zwar der zweite Montag im Monat 
            Februar des Jahres 2021. Dieser Monat hat 28 Tage. Der 08.02.2021 
            ist kein gesetzlicher Feiertag in Hessen. Der nächste gesetzliche 
            Feiertag ist der 02.04.2021 (Karfreitag).
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

</html>
```

Schaut Euch diese (oder Eure) Datei im Browser an und stellt fest: Das sieht 
immer noch doof aus, aber immerhin sind es Informationen. Das colspan-Attribut, 
das ich einmal verwende im Code, sagt "diese Zelle nimmt den Platz ein, den 
normalerweise X Zellen einnehmen". Dadurch erreiche ich, dass der Monat "Februar 
2021" über die ganze Kalenderblatt-Breite dargestellt wird.

## CSS

CSS-Dateien enthalten Informationen darüber, wie HTML-Inhalte dargestellt werden. 
Zuerst binden wir eine CSS-Datei ein. Das geschieht im Header Eurer HTML-Datei, 
zum Beispiel über eine Zeile wie diese:

`<link rel="stylesheet" type="text/css" href="style.css" />`

Wir sagen also dem Dokument, dass unter einem bestimmten Link / einer Adresse 
eine CSS-Datei liegt namens style.css (und da wir keine Verzeichnisinformationen 
dazu schreiben, ist die Datei am gleichen Ort zu suchen wie die HTML-Datei) und 
dass diese für unser Dokument als Stylesheet zu werten ist.

Nun erstellen wir auch im selben Verzeichnis eine Datei namens style.css und 
geben ihr für's erste den folgenden Inhalt.

```CSS
#seitenkopf {
    background: lime;
}

#kalenderblatt {
    background: palevioletred;
}

#introtext {
    background-color: powderblue;
}

#historie {
    background: goldenrod;
}
```

Wenn alle Bezeichnungen denen in unserer CSS-Datei den Bezeichnungen (hinter dem Schlüsselwort id) in der HTML-Datei entsprechen, dann habt Ihr beim nächsten Öffnen der HTML im Browser den Alptraum jedes Designers vor Euch. Zugleich erkennt Ihr aber, dass die Definitionen in der CSS Auswirkungen auf die Darstellung der Informationen haben. Eine ID bezeichnet ein Element im HTML **eindeutig**. Das heißt die gleiche ID sollte auch nur einmal pro Datei vergeben werden. Das # in der CSS-Datei heißt: "Wende bitte auf alle Elemente mit der ID ... die nachfolgenden Formatierungsoptionen an".

Machen wir nun eine sinnvolle Änderung. Die Kalenderwoche wollen wir kleiner als die anderen Kalendereinträge und kursiv darstellen. Dazu brauchen wir zwei Sachen:
- Einen Ankerpunkt im HTML, auf den die Regel zielen soll
- Eine Regel im CSS

### Ankerpunkte im HTML
CSS-Regeln können sich auf alles mögliche zielen. Sie können, wie gesehen, spezifisch auf ein einzelnes Element zielen, das über seine ID angesprochen wird. Sie können auch für bestimmte HTML-Tags gelten. Zum Beispiel:

```CSS
// Macht alle Texte innerhalb von <p></p> Tags fett.
p {
  font-weight: bold;
}

// Setzt für alle Text-Absätze (<p></p> innerhalb von <div></div> Containern die Schriftgröße auf 24 Pixel.
div p {
  font-size: 24px;
}

// Setzt die Schriftfarbe auf rot, aber nur für <p></p> Absätze in dem Div mit der ID Test
div#test p {
  color: red;
}
```

Für unsere Zwecke ist das alles noch nicht ideal, denn wir wollen weder ein bestimmtes Element, aber auch nicht alle Elemente eines bestimmten Typs (zum Beispiel alle Tabellenzellen mit dem Tag td) mit unserer Regel zur Kursivschreibung anpassen, sondern nur bestimmte Tabellenzellen: Diejenige, die informationen zur Kalenderwoche enthalten. Für sowas gibt es Klassen in HTML/CSS. Wir können jedem, also auch mehreren Elementen (im Gegensatz zur ID) eine (oder gar mehrere Klassen) zuweisen. Dafür passt Ihr Euren Code an - und zwar für jede Tabellenzelle, die eine Angabe zur Kalenderwoche enthält. Beispiel:

```HTML
<tr>
    <td class="kw">5</td>
    <td>1</td>
    (und so weiter)
```

Die Zelle mit der 5 ist eine Zelle, die sich auf die KW 5 bezieht. Die Zelle mit der 1 meint den 1. Februar 2021. Wir haben der Kalenderwochen-Zelle jetzt die Klasse "kw" zugewiesen, und das können wir mit allen anderen KW-Einträgen auch machen.

Und dann ergänzen wir unsere CSS-Datei beispielsweise um folgenden Eintrag:

```CSS
.kw {
    font-style: italic;
    font-size: smaller;
}
```

Dieser Eintrag sagt: "Für alle Elemente der Klasse kw gilt folgende Formatierung"

## Weiter in Eigenregie

Ihr habt alle Elemente in der Hand, auch wenn Ihr es noch nicht wisst, um die Seite hübsch zu gestalten. Ihr werdet viele CSS-Regeln recherchieren müssen, aber Ihr könnt alles tun. Zum Experimentieren hilft es ungemein, im Browser F12 zu drücken. Das geht bei den meisten Browsern. Dann seht Ihr einen Inspector. Fuchst Euch in die Bedienung ein, denn hier könnt Ihr CSS-Regeln testweise ändern und mit den Werten spielen .... Geht schneller als im Code zu schreiben und dann die Seite neu zu laden. Versucht es. :-)

Erste Anregungen:
- Samstage blau, Sonntage rot
- Hintergrundfarbe für den Kalender
- den aktuellen Tag besonders kenntlich machen

Es geht tatsächlich alles, auch das Verschieben der Bereiche. :-)