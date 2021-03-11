# Einleitung

*Hin und wieder wurde geäußert, dass Cheatsheets / Vokabellisten für Programmiersprachen 
gewünscht werden, also quasi eine Übersicht über die wichtigen Befehle.*

## Missverständnisse

Dieser Wunsch hat ein paar richtige Grundlagen, ist aber zum Teil auch Ausdruck eines 
Missverständnisses, und ich möchte daher mal eine sehr allgemeine, sprachunabhängige 
Einführung in die Programmierung angehen. Zum Zeil wird sich das überschneiden mit der 
Einführung in die objektorientierte Programmierung, aber es ist wohl nötig, ein 
gewisses Verständnis für Programmierung zu gewinnen bzw. für dieses zu werben.

#### Missverständnis 1: Eine Programmiersprache ist keine Sprache

Um in normalen Gesprächen als deutschsprechend ohne Einschränkung durchzugehen, braucht 
man einen Wortschatz von rund 10.000 Worten, so habe ich mal gehört. In manchen Sprachen 
ist es mehr, in manchen etwas weniger. In der Programmierung würde ich das mal pro Sprache 
auf 100 schätzen, eher weniger.

Natürlich wird man erst mal erschlagen, wenn man Programmcode sieht. Nehmen wir ein 
kleines Beispiel (JS):

```
let datum = new Date();
console.log('Das Datum ' + (datum.getDate() < 10 ? '0' : '') + datum.getDate() + '.' + (datum.getMonth() < 9 ? '0' : '') + (datum.getMonth() + 1) + '.' + datum.getFullYear() + ' liegt ' + datum.getTime() + ' ms hinter dem 01.01.1970'.);
```

Diese zwei Zeilen enthalten genau genommen exakt 2 Befehle. Der eine lautet `let`, der andere lautet `new`. 
Was ist der ganze kryptische Rest? Nun die erste Zeile definiert eine Variable datum (das tut das Keyword `let`). 
Wir haben schon besprochen, dass Variablen Werte speichern. In dem Fall speichern sie ein Objekt. Objekte 
werden in vielen Programmiersprachen mit dem Keyword `new` erstellt. Das heißt es gibt eine sogenannte Klasse, 
das ist quasi der Bauplan für ein Objekt und diese Klasse heißt `Date`. Anhand dieses Bauplans wird also ein 
neues Date-Objekt konstruiert. Aus der [Dokumentation dieser Klasse](https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/Date) ergibt sich, dass eine Konstruktion dieses Objektes ohne weitere Angaben automatisch zu einem Date-Objekt 
führt, dass die aktuelle Systemzeit des ausführenden Rechners als Basis hat.

Und ansonsten führen wir nur diverse Methoden dieses Objektes aus. Das heißt wir nutzen die Funktionalität, die 
ein Date-Objekt eben so mit sich bringt. Diese auswendig zu lernen, ist tatsächlich nicht zielführend. Wie 
ich öfter schon sagte, geht es einfach darum, dass man ein Gefühl dafür entwickelt, was so ein Objekt "doch 
bestimmt können muss" und dann gezielt danach zu suchen, wobei es insbesondere zwei Quellen gibt, die hilfreich sind:

- Gebt nach den oberen Zeilen `datum.` in VSCode ein und Ihr seht eine Auflistung vorgeschlagener Code-Ergänzungen. 
Diese Ergänzungen werden gewonnen, indem VSCode die Klasse Date ausliest und sämtliche Methoden auflistet, welche 
die Klasse für sich anbietet.
- Oder lest die [offizielle Dokumentation](https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/Date) der Klasse durch. 
Wenn Ihr weiter nach unten scrollt, sehr Ihr unter der Überschrift "JavaScript Date Instanzen" alle Methoden, welche die 
Klasse anbietet samt Beschreibung, was sie können.

Desto weiter ihr voran schreitet, desto wahrscheinlicher ist es, dass die Klassen, die ihr benutzt, nicht die 
paar fest in JS verdrahteten sind, sondern aus irgendwelchen Bibliotheken zusammengetragene oder gar von Euch selbst 
geschriebene Klassen, deren Dokumentation Ihr auch verfasst habt. Defacto ist ein Teil unserer Einstiegsübungen 
sogar, genau diese Dokumentationen zu verfassen, auch wenn wir das zumeist kurz halten.

Deswegen war meine erste Google-Suche "construct current date javascript". Ich wusste, dass von da an, wenn 
ich mal so ein Datumsobjekt in der Hand habe, alles andere sich automatisch ergibt. Anstatt also die gebräuchlichsten 
Methoden auswendig zu lernen, was sich wahrscheinlich eh nicht festlegen lässt, gewöhnt Euch an den Gedanken, 
mit öffentlichen Dokumentationen umzugehen oder auch die Beschreibungen durchzugehen, welche Euch die IDE 
zu jedem Befehl ausspuckt.

#### Missverständnis 2: Die Sprache beherrscht besser, wer mehr Befehle / Methoden kennt

Dem ist tatsächlich nicht so. Vor dem Kalenderprojekt war in meinem aktiven Javascript-Repertoire nicht genug 
vorhanden, um den Kalender zu basteln. Ich habe schon das System gebastelt, mit dem alle unsere Kantinen 
ihren Zutaten-Nachschub in der Zentrale bestellen - komplett auf Javascript-Basis, aber dafür musste ich nicht 
Javascript beherrschen, sondern "nur" die Logik, mit der man in jeder Programmiersprache etwas erreichen kann. 
Ihr könnt jeden Befehl auswendig kennen und trotzdem nichts erreichen.

Wie gesagt, es geht zuerst darum, ein Gefühl dafür zu entwickeln, was eine bestimmte Klasse bzw. ein Objekt 
einer bestimmten Klasse bestimmt können muss - und dann nach Quellen dafür zu suchen. Ein Beispiel: Denkt 
Euch einen String. Wir haben gelernt, dass ein String einfach eine Reihe von Buchstaben und Zahlen ist, die 
üblicherweise in Anführungszeichen im Code verwendet werden. Dieser ganze Artikel ist aus Sicht der 
Github-Plattform ganz sicherlich ein String. Was könnte man mit Strings alles machen?

- Einen String aus einem Code erstellen (zum Beispiel ASCII-Code)
- Ein bestimmtes Zeichen in einem String suchen
- Ein bestimmtes Zeichen anhand seines Charcodes im String suchen
- Mehrere Strings zu einem String verbinden
- Fragen, ob der String mit bestimmten Zeichen anfängt oder aufhört
- Fragen, ob der String einen anderen String (also eine Folge von Zeichen) enthält
- Die Position ermitteln, an der ein String innerhalb dieses Strings zum ersten/letzten mal vorkommt (also zum Beispiel "ihr" in "Hallo, ihr Minions")
- Vorkommen eines bestimmten Strings innerhalb des Strings durch einen anderen String ersetzen
- Einen neuen String herausschneiden aus einem String
- Einen bestimmten Abschnitt (zum Beispiel Zeichen 4 - 20) aus dem String extrahieren
- Den String komplett in Großbuchstaben oder Kleinbuchstaben umwandeln
- Führende oder nachfolgende Leerzeichen abschneiden (aus " x " wird "x")
- Aus einem String mit Trennzeichen beliebiger Art eine Sammlung aus neuen Strings basteln (als aus "1, 2, 3" wird "1", "2" und "3")

Und all das kann das String-Objekt. Und was es nicht kann, kann man anhand dieser Methoden 
dann selbst erreichen. Beispielsweise kann man die Anzahl der "x" in einem Text 
bestimmen, indem man nach dem ersten "x" sucht, dann nur noch im Rest des Strings 
wieder ein "x" suchen und so weiter und jedes mal einen Zähler hochsetzen, wenn man 
das gemacht hat und am Ende hat man die Anzahl von "x" in dem String. Oder man zerteilt 
es mit dem angeblichen Trennzeichen "x" und guckt dann, wie viele Teile man jetzt hat.
Wenn es die Methode nicht schon gibt, dann muss man eben kreativ sein bei der 
Anwendung der vorhandenen Methoden.

## Pseudocode

Die IHK verlangt Euch in den Prüfungen ausschließlich Pseudocode ab. Das hat 
praktische Gründe, weil es keinen Standard dafür gibt, was Ihr am Ende Eurer 
Ausbildungszeit beherrschen müsst. Aber es hat auch einen ganz gewichtigen 
Hintergrund: Pseudocode ist die Basis, denn Pseudocode erlaubt Euch, Eure Gedanken 
auszudrücken und Eure Logik zu entfalten.

Wenn wir also zum Beispiel das Thema haben, dass wir wissen wollen, wie viele 
Tage ein Monat hat und jemand kommt auf die Idee, dass wir quasi nach folgendem 
Muster vorgehen können:

```
Variable m: Aktueller Monat (1 = Januar bis 12 = Dezember)
Variable y: Aktuelles Jahr
Variable d: Anzahl der Tage
Falls m == 1, 3, 5, 7, 8, 10, 12
    d = 31
ansonsten falls m == 4, 6, 9, 11
    d = 30
ansonsten
    falls restlos durch 4 teilbar
        falls restlos durch 100 teilbar
            falls restlos durch 400 teilbar
                d = 29
            ansonsten
                d = 28
        ansonsten
            d = 29
    ansonsten
        d = 28
(Weiter im Code)
```

Dann ist das klasse! Ja, wir können lernen, noch etwas rechenzeit-optimierter 
vorzugehen, aber wenn wir nicht gerade Wettersimulationen oder Marsmissionen 
oder Cyberpunkt 2077 programmieren, dann ist das schon okay und bremst den 
Rechner nicht merkbar aus. Die von mir vorgegebene Lösung lautete:

```
Variable dat: Aktuelles Datum
Variable datErsterFolgemonat: Neues Datum mit Jahr von dat, Monat von dat +1, Tag 1
Variable datLetzter: 1 Tag vor datErsterFolgemonat
Variable d: Tag von datLetzter
```

Und in dem Schritt von dem Problem zu diesem Pseudocode liegt die wahre Leistung. 
Die Umsetzung von Code ist etwas, was ein bisserl Google erfordert bzw. dass man 
sich auch von VSCode etwas leiten lässt. Zum Vergleich zwei Implementationen:

- in Dart:
```
  var datum = DateTime.now();
  var nextMonth = datum.month == 12 ? 1 : datum.month + 1; // Dezember => Januar, sonst + 1
  var datumErsterFolgemonat = DateTime(datum.year, nextMonth, 1);
  var datumLetzter = datumErsterFolgemonat.subtract(Duration(days: 1)); // 1 Tag abgezogen
```

- in Javascript:
```
    let datum = new Date();
    let datumLetzter = DateTime(datum.year, datum.month + 1, 0);
```

In JS habe ich die Idee etwas kürzer umsetzen können, weil das DateTime-Objekt die 
schöne Eigenschaft hat, dass man auch falsche Werte geben kann und es dann automatisch 
korrigiert. Das nutze ich hier und kreiere ein Datum, dass quasi der 0. des nächsten 
Monats ist, was JS dann automatisch korrigiert zum Letzten des aktuellen Monats. 
Den Dart-Code finde ich persönlich aber besser lesbar. Euch wird im Moment der 
sogenannte ternary Operator (die Zeile mit dem Fragezeichen) noch etwas stören, aber 
das gibt sich. Das ist irgendwann ein Standard-Konzept.

Die Unterschiede zwischen beiden Herangehensweisen liegen also vor allem darin, dass 
das Date-Objekt in JS etwas andere Funkionalität hat als das DateTime-Objekt in 
Dart. Sprachlich sind die Unterschiede minimal, wie zwischen allen relativ modernen 
Programmiersprachen:

- In JS nutzen wir `let` wo wir in Dart `var` nutzen. Aber wir könnten in JS auch 
`var` nutzen, ohne dass es ein Problem gibt. Der Unterschied ist nur, dass in JS 
die Gültigkeit von Variablen, die mit `var` definiert werden, etwas größer ist als 
bei Variablen, die mit `let` definiert wurden. In Dart ist die Gültigkeit von `var` 
ebenso beschränkt wie die von `let` in JS, daher bevorzuge ich in JS `let`, wann 
immer ich das nicht vergesse.
- In Dart nutze ich das Keyword `new` nicht, um ein neues Objekt zu erzeugen, weil 
Dart davon ausgeht, dass ich eines erzeuge. Würde ich `new` benutzen, dann würde 
mir das als schlechter Stil markiert, aber es wäre kein Fehler.

Also: **Schärft Euren Intellekt in Sachen Pseudocode und dann findet sich der Rest 
mit der Zeit von selbst.**

## Und jetzt die ersehnten Vokabeln

In der Tat kann ich nach dieser Einleitung guten Gewissens jetzt die meines 
Erachtens wichtigsten Fakten zu jeder Sprache zusammenstellen.

### HTML

Beschreibt den Inhalt von Webseiten. Ich denke alles wirklich wichtige ist 
[auf dieser einen Seite erklärt](https://www.bitdegree.org/learn/html-example).

### CSS

Beschreibt das Aussehen von Webseiten. Was die Eigenschaften angeht, plädiere ich 
dafür, davon auszugehen, dass im Prinzip alles geht und dann gezielt zu suchen, 
wenn man weiß, was man will. Oder irgendwo abkupfern, indem man guckt, wie 
der gewünschte Effekt woanders erreicht wurde (F12 rules).

Womit man sich auskennen kann, das sind die Selektoren, also wie erreiche ich 
ein bestimmtes Element oder eine Reihe von Elementen, denn das sind nicht nur 
Elementtypen und id und class. [Das hier ist eine gute Übersicht](https://www.w3schools.com/cssref/css_selectors.asp).

### Javascript und Dart

Die beiden Sprachen sind als echte Programmiersprachen für uns viel interessanter 
als HTML und CSS und deswegen beschäftigen wir uns in den nächsten Folgen dieser 
Serie nur noch mit diesen Sprachen (stellvertretend für viele andere Sprachen).