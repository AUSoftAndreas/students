# Vorgehensweise im Kalender-Projekt
Das Kalenderprojekt soll jeder Teilnehmer eigenverantwortlich entwickeln. Es ist unser Einstieg in HTML, CSS und Javascript.

Und da diese Kombination von Sprachen ziemlich typisch ist, lohnt es sich, hier ein bisschen die Grundlagen zu studieren und am Beispiel sich etwas selbst zu erarbeiten.

## Teil 1: HTML
HTML ist die Standard-Sprache für das WWW, genauer gesagt für den **Inhalt** von Webseiten. Warum die Fettschreibung? Weil es bei HTML nicht (oder kaum) darum geht, wie diese Inhalte präsentiert werden. Es geht nur darum, was diese Inhalte sind. Eine pure HTML-Seite ist deswegen sehr, sehr schlicht. Aber sie enthält eben schon alle Inhalte die eine HTML-Seite enthät. An einem Beispiel mal verdeutlicht:

Das ist die Webseite spiegel.de, wie wir sie kennen bzw. wie sie aussieht, wenn wir sie aufrufen:
![](https://raw.githubusercontent.com/AUSoftAndreas/students/dev/wiki/kalender/spiegel_mit_css.PNG)

Und das ist der HTML-Teil alleine:
![](https://raw.githubusercontent.com/AUSoftAndreas/students/dev/wiki/kalender/spiegel_ohne_css1.PNG)
![](https://raw.githubusercontent.com/AUSoftAndreas/students/dev/wiki/kalender/spiegel_ohne_css2.PNG)

Man erkennt, dass es da gewisse Unterschiede gibt.

Das, was Webseiten hübsch macht, ist also eher nicht im HTML zu verorten. Aber: Jeder Inhalt muss im HTML stehen und kann dann mit anderen Methoden schöner werden.

### Wie estelle ich die erste HTML-Datei
Im Prinzip: Im Explorer an eine beliebige Stelle navigieren, dort dann rechte Maustause, neue Textdatei erstellen und dafür sorgen, dass die Dateiendung html ist, nicht txt. Mag sein, dass in Euren Windows-Einstellungen deaktiviert ist, dass Ihr die Dateiendung ändern könnt. Das müsst Ihr deaktivieren (Google hilft) .....

.... oder Ihr geht direkt in VSCode, erstellt dort ein neues Projekt (=neuer Ordner) und dann könnt ihr auch dort per Click einfach eine neue Datei erstellen und sie zum Beispiel einfach index.html nennen (index.html ist der Standard-Dateiname .... die Datei wird geöffnet, wenn Ihr eine Datei nicht direkt mit Namen ansteuert. www.spiegel.de beispielsweise öffnet die Datei index.html auf dem Webserver spiegel.de).

Und dann schreibt Ihr Eure ersten Zeilen, die ungefähr so aussehen könnten:

```HTML
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kalender vom 08.02.2021</title>
</head>

<body>
    <h1>Mein Kalenderblatt: 08.02.2021</h1>
    <p>Das ist mein erster Text</p>
</body>

</html>
```

Wenn Ihr einfach im Explorer diese Datei öffnet ... oder sie in einem Browser direkt öffnet oder auch aus VSCode heraus per Run/Debug (ggf. muss man da noch ein bisserl konfigurieren), dann erhaltet Ihr ungefähr das folgende Resultat im Browser Eurer Wahl:

![](https://raw.githubusercontent.com/AUSoftAndreas/students/dev/wiki/kalender/kalender_01.PNG)

Versucht zu verstehen, wie Euer Code zusammenhängt mit der Ausgabe. Der Code besteht aus ein paar Meta-Informationen, die uns zum Beispiel sagen:
- Die Seite hat Inhalt in deutscher Sprache.
- und ist in UTF-8 (siehe Programmierung-Präsentation) codiert.
- Sie ist nicht irgendwie verzerrt darzustellen, sondern 1:1 in der Größe und so breit, wie das Gerät breit ist.
- Der Titel ist "Kalender vom 08.02.2021" und diese Zeile findet Ihr wieder im Namen des Tabs, in dem die Seite im Browser dargestellt ist.
- Im eigentlichen Anzeigebereich (body) sehen wir eine Überschrift (h1 = header der Kategorie 1) namens "Mein Kalenderblatt: 08.02.2021"
- und danach einen Textabsatz (p = paragraph) mit "Das ist mein erster Text". 
Und all das findet sich auf der Seite wieder.

Jetzt bauen wir den Code noch etwas aus:
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
        <p>Hier fehlt noch ein Kalenderblatt</p>
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
                aus
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

Schaut Euch auch dieses Ergebnis im Browser an. Im Code könnt Ihr sehen, dass wir mit den `<div></div>` Tags etwas Ordnung in das Ganze gebracht haben. Wir haben sozusagen Abschnitte, die erstmal nix weiter als unsichtbare Kästen / Container sind, geschaffen. Das hilft uns später, wenn wir die Bereiche anders darstellen wollen.

Diese Grundstruktur, dass etwas mit einem öffnenden Tag, zB `<div>` oder `<p>` oder `<ul>` geöffnet wird und dann eben so lange gilt, bis es mit `</div>` oder `</p>` oder `</ul>` wieder geschlossen wird, ist in ganz vielen beschreibenden Bereichen ähnlich. Ihr findet das wieder in XML, aber auch in Flutter werden wir auf ähnliche Strukturen stoßen. Ein HTML-Dokument ist immer eine Art Baumstruktur. Gewöhnt Euch auch an diese Form der Einrückung. Wenn wir mit einem Tag etwas öffnen, egal was, dann ist jede Zeile danach um einen Tab weiter eingerückt (Tabs sind dann, je nach IDE, 2 oder 4 Leerzeichen). Schließen wir es wieder, dann erfolgt das Schließen wieder auf der gleichen Eben wie das Öffnen und alles danach ist auch auf der gleichen Ebene. Auf diese Weise können wir zum Beispiel leicht sehen, wenn wir etwas geöffnet haben, aber vergessen haben, es auch wieder zu schließen.

Das konsequente Arbeiten und Verstehen der Einrückungen ist essentiell auch für viele echte Programmiersprachen (HTML hat ja keine Programm-Ablauflogik, sondern stellt nur etwas dar, deswegen kann sie nicht als rechte Programmiersprache gelten).

Recherchiert selbständig die Tags, die Ihr noch nicht kanntet, also zum Beispiel `<ul>` und `<li>`.

Eure erste Aufgabe ist nun, etwas zu basteln, was in etwa so aussieht (minus alles optische, es geht ja nur um den Inhalt, also die Informationen):

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/kalender/kalender-februar-2021.png)

Das dann bitte einbauen in den Bereich, der dafür in unserem Code vorgesehen war .... Hinweis: Dafür könnt Ihr beispielsweise eine Tabelle in HTML benutzen, die unter anderem die Tags `<table>`, `<tr>` und `<td>` verwendet. Experimentiert einfach damit. :-)

Hier im Wiki sind auch Links zu nützlichen HTML-Ressourcen.