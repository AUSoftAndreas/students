# Vererbung

Kommen wir zu einem weiteren, wesentlichen Element der OOP. In den meisten Vorträgen und Büchern zu dem Thema ist es gar scheinbar DAS wichtigste Element. Mit war aber wichtig, zuvor diese Einheit von Daten und Funktionalität zu betonen. Wie auch immer: Das heutige Thema ist Vererbung. 

## Klassische Vererbung / "extends"

Vererbung bedeutet, dass eine Klasse sämtliche Attribute und Funktionalität von einer anderen Klasse erbt. Das bedeutet, dass man in dieser neuen Klasse nur die Daten definieren und Funktionen implementieren muss, die zu Daten / Funktionen der Mutter-Klasse hinzu kommen. Das spart natürlich deutlich Code ein.

Das bedeutet in der Regel, dass die Tochterklasse eine spezialisiertere Form der Mutter-Klasse ist. Man spricht von einer "ist ein(e)"-Verbindung ("is a" relationship). 

Beispiel: *In unserem Beispiel einer Schulverwaltung haben wir gesagt, dass wir Objekte wie Schüler, Lehrer und Mitarbeiter brauchen. Es könnte sinnvoll sein, eine Basisklasse Person zu erstellen, denn jede Person hat bspw. Vorname und Nachname. Dann könnte man sagen, dass die Klasse Mitarbeiter eine spezialisiertere Form der Klasse Mitarbeiter ist. Neu hinzu kommen tut zum Beispiel, dass alle Mitarbeiter eine Personalnummer haben. Der Lehrer wiederum ist eine spezialisiertere Form des Mitarbeiter, denn er hat auch Unterrichtsfächer und dergleichen, die andere Mitarbeiter, wie ein Hausmeister, nicht haben. 

Dort, wo wir 1:1 das Verhalten der Mutter übernehmen wollen, müssen wir gar nichts programmieren. Wenn wir in der neuen Klasse etwas anders handhaben wollen, dann können wir eine abweichende Implementierung einer Methode schreiben. 

Damit nicht genug: Der Lehrer *ist ein* Mitarbeiter und *ist eine* Person. Er erbt also alle Eigenschaften und Methoden von beiden Vorgängern im Vererbungsbaum. Das hat aber noch eine weitere Folge. 

Beispiel: Wir haben auch ein Objekt Lohnbuchhaltung. Diese beinhaltet die folgende Methode/Funktion:

```
void gehaltZahlen(Mitarbeiter mitarbeiter, int gehalt) {
    // Implementierung
```

Diese Methode erwartet also, dass wir ihr ein Objekt Person übergeben. Das Wichtigste nun: Wir können ihr auch ein Objekt vom Typ Lehrer übergeben, denn aufgrund der Vererbung ist ein Lehrer auch eine Peeson! 

In den meisten Sprachen kann eine Klasse nur eine direkte Mutterklasse haben (und die hat ebenfalls eine und ihre Mutter auch.....). Es gibt aber auch Ausnahmen hiervon. Dart handhabt es wie die meisten Sprachen, also gibt es immer nur eine Mutter.

In Dart setzen wir eine solche Beziehung mit dem Keyword "extends" um. Beispiel:

```
class Lehrer extends Mitarbeiter {
    // Implementierung
}
```

## Interfaces / "implements"

Zusätzlich gibt es in den meisten OOP-Sprachen die Möglichkeit, Interfaces zu definieren.

Manche Lehrbücher sprechen hier von einer "has a" (hat eine)-Beziehung statt der "is a"-Beziehung zuvor, aber ich würde es eher so sagen: **Ein Interface ist eine Art Vertrag, dass jede Klasse, die ihn unterschreibt, bestimmte Attribute und Methoden zur Verfügung stellt, unabhängig davon, was die Klasse sonst tut oder kann. 

Rein programmatisch heißt das dann, dass man dadurch, dass man ein Interface implementiert, automatisch gezwungen ist, alle öffentlichen Methoden und Attribute des Interfaces auch umzusetzen. Dabei ist das Interface selbst ohne Code, es sind nur die Deklarationen von Methoden und Attributen. 

Auch wenn das auf den ersten Blick deutlich weniger mächtig aussieht (weil der Code nicht geerbt wird) als die reine Vererbung, so ist es doch in der Praxis das wahrscheinlich sogar wichtigere Konzept. Oft empfiehlt es sich, "auf Interfaces hin zu programmieren", nicht auf Klassen hin. Um das Konzept zu verdeutlichen, nehmen wir ein reales Beispiel:

Als wir den PLZCalculator gebaut haben, haben wir zuerst die Sachen umgesetzt, die einfach waren. Screens zum Beispiel. Die Anfrage bei GoogleMaps hingegen war Neuland. Trotzdem musst du in der Programmierung mit dem Objekt, das die Anfrage bei GoogleMaps durchführt, ja schon umgehen. Du musst es im Code erwähnen. Weil du die Attribute auf einer Seite darstellst oder weil du nach einem Click des Users eine Methode des Objektes starten willst. Wenn du dann einfach nicht hast, weil das noch dauert, bis es programmiert wird, dann sind das natürlich alles Fehler aus Sicht von IDE / Compiler. 

Stattdessen haben wir ein MapProvider-Interface geschrieben, indem wir einfach nur definierten, dass jede Klasse, die das Interface nutzt, diese und jene Attribute und Methoden haben wird. Damit konnten wir an jeder Stelle im Code einfach nur auf das Interface verweisen und dann gibt es auch keine Fehler mehr. Zudem haben wir einen MockMapProvider geschrieben, der auf jede Anfrage mit einer zufälligen Antwort reagierte. Somit konnten wir die App auch schon testen, obwohl ein wichtiges Element der App noch nicht fertig war. Und als der GoogleMapProvider fertig war, mussten wir nur an einer Stelle das Wort MockMapProvider durch GoogleMapProvider austauschen und das war's, weil beide (MockMapProvider und GoogleMapProvider) jeweils das Interface MapProvider implementieren und weil an jeder anderen Stelle im Code immer nur auf MapProvider, also das Interface, Bezug genommen wurde und nie auf die konkrete Implementierung dieses Interfaces. Sprich: Es ist dem Rest der App egal, woher die Daten kommen, ob von Google oder von einer Zufalls-Routine. Hauptsache sie sind da. 

Wenn wir irgendwann sagen, dass wir statt GoogleMaps einen anderen Service nutzen wollen (oder alternativ, je nach User-Preferenzen), dann weiß der Programmierer anhand des Interfaces genau, welche Methoden und Attribute er public anzubieten hat. Er hat eine Art Grundraster. Wie er das dann umsetzt, liegt an ihm, aber es ist einfach und der Rest der App muss null ungeschrieben werden. Deswegen ist es üblich, dass man häufig Interfaces nutzt. Man sagt "so und so wird meine Lösung aussehen" und arbeitet damit, auch wenn die Lösung noch nicht fertig ist. Das Interface hilft dabei, Programme modularer zu gestalten. 

Dart und die meisten Sprachen setzen Interfaces mit dem Keyword "implements" um.

```
class MockMapProvider implements MapProvider {
    // Details
}
```

Anders als in den meisten Sprachen müssen wir Interfaces nicht gesondert deklarieren. Jede Klasse ist auch ein Interface (nur dann hält ohne Funktion und Inhalt, nur die Deklarationen). Das heißt jede Klasse kann als Interface verwendet werden. 

Während eine Klasse nur eine Mutterklasse haben kann, kann jede Klasse beliebig viele Interfaces implementieren.

## Dart-spezifisch: Mixins / "with"

Interfaces sind ja aus Sicht des Codesparens etwas enttäuschend... Zwar ist es schön, per "implements X" sich zu verpflichten, dass unsere Klasse allen Anforderungen an X genügt, aber im Endeffekt müssen wir die Funktionalität dann unter Umständen in jeder Klasse, die X implementiert, erneut umsetzen. Und zwar können wir per "extends" auch die Funktionalität übernehmen, aber das geht nur einmal und signalisiert ein Verwandtschaftsverhältnis ("is a"), was nicht zwingend vorliegen muss. 

Mixins füllen die Lücke. Wir übernehmen die Funktionalität von X, aber vielleicht auch die von Y und Z. Mixins müssen aber gesondert definiert werden. Es sind keine normalen Klassen. Fürs Erste können wir sie als erweiterte Interfaces verstehen. 

## Übung
Definiert die folgenden Klassen und bringt sie in eine passende Klassenhierarchie (ohne Mixins) in Dart:

- Lebewesen
- Säugetier
- Vogel
- Fisch
- Mensch
- Haustier
- Wal
- Fliegen
- Schwimmen
- Gehen
- Fledermaus
- Spatz
- Pinguin
- Hering
- Lehrer
- Loewe
- Lizy (das ist mein Hund) 

Alles in ein Dart-File, nur Klassen Definitionen, ohne Methoden und Attribute. 