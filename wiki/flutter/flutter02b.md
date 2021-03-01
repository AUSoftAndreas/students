### Wie dieses Tutorial funktioniert

Der Code führt das Projekt ist weiterhin unter 
[AUSoftAndreas/flutter-minesweeper](https://github.com/AUSoftAndreas/flutter_minesweeper) 
abrufbar. Der für diesen Tutorial-Abschnitt relevante Branch ist 
"step_b". Wechselt auf diesen Branch. 

## Schritt B.1: Libraries

Bei manchen meiner / unserer Projekte nutzen wir eine Library namens 
[Bloc](https://bloclibrary.dev/#/) im Hintergrund, die als Mittler zwischen 
Daten und GUI funginert (das schon mehrfach angesprochene State Management). 
Aus persönlichen Lerngründen habe ich mich für Minesweeper dazu entschieden, 
mit einer relativ neuen Lösung namens [Riverpod](https://riverpod.dev/) 
zu arbeiten, einfach weil ich das ausprobieren wollte.

Im Endeffekt führt jedes State Management System dazu, dass man reativ bequem mit 
sich veränderndem State arbeiten kann. Ungefähre Grundidee von diesen Systemen ist:
- Eine GUI bildet den gegenwärtigen State ab.
- Der State ist unveränderbar (immutable).
- Wir können aber einen **neuen State** definieren und wenn wir das tun, dann 
werden automatisch alle Elemente / Screens, die sich auf den State beziehen, 
geupdated.
- Dadurch fallen die Flutter-eigenen Lösungen für das Thema State im Prinzip flach, 
also wenn Ihr in einem Tutorial etwas über `StatefulWidget` lernt, dann kann 
es sein, dass Ihr diese nicht notwendig habt, wenn Ihr Bloc oder Riverpod nutzt.
- Im Endeffekt muss man sich State so vorstellen, dass er irgendwo als Objekt 
  kreiert wird. Und wenn wir ihn überall in der App dann verwenden wollten, dann 
  müssten wir ihn als Argument immer durchreichen auf jeden Screen.
- State Managament Systeme wie Riverpod deklarieren den State irgendwo und 
stellen dann Methoden bereit, um aus jeder Ecke auf den State zuzugreifen und 
sorgen dann dafür, dass State-Updates auch zu GUI-Updates führen.

###### Kurz zum StatefulWidget
Das `StatefulWidget` war eine für den sogenannten local State. Local State meint 
den State eines GUI-Bildschirms. Es ging darum, dass Benutzereingaben ja zu 
Änderungen dessen führen können, was auf genau dem Screen, auf dem der 
Benutzer etwas getan hat, zu Änderungen führt. Beispielsweise habt Ihr einen 
Button, mit dem der User zwischen Day und Night Mode der App switchen kann. 
Natürlich wollt Ihr, dass ein Klick des Users dann dazu führt, dass auf einmal 
alles dunkler ist. Also muss die GUI neu gerendert werden. Das war das 
Aufgabengebiet des `StatefulWidget`. Ein Problem war aber, wenn das, was den 
State ändert, von außen kommt. Bibliotheken wie bloc oder Riverpod nehmen einem 
den Aufwand ab, das im Detail zu arrangieren, dass zum Beispiel irgendwelche 
neuen Daten erstmal jedem GUI-Screen einzeln bekannt gemacht werden müssen.

###### Zurück zum Thema
Ausgehend von den Beschreibungen auf der [Riverpod](https://riverpod.dev/)-Homepage 
habe ich erstmal das Riverpod-Package und das damit zusammenhängende "Flutter-Hooks"-
Package in unser Projekt integriert. Das ist recht einfach und geschieht über die 
pubspec.yaml-Datei im Stammverzeichnis.

Riverpod musste auch installiert werden. Die Installation von Libraries ist 
erdenklich einfach. Dazu musste einach die /pubspec.yaml geändert werden. In 
dieser Datei werden alle Libraries gelistet, die zum Einsatz kommen, zusammen 
mit ihren Versionsnummern. Der interessante Abschnitt ist dieser:

```Yaml
environment:
  sdk: ">=2.12.0-0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_hooks: ^0.16.0-nullsafety.0
  hooks_riverpod: ^0.13.0-nullsafety.3
```

Der sdk-Eintrag sagt, welche Version des Dart SDK (Software Development Kit) 
zum Einsatz kommen wird. Wenn eine Version größer als 2.12 da steht, dann 
wählt man damit automatisch aus, dass man das neue Dart-Feature null-safety 
verwenden will. Dazu folgt irgendwann ein Artikel im Wiki, aber im Wesentlichen 
kann ich das zusammenfassen als:
- Jede Variable wird normalerweise auf `null` initialisiert. Das ist der Wert, 
den sie hat, wenn an ihr nicht einen anderen zuweist.
- `null` ist insofern problematisch, als dass man mit diesem Wert vieles nicht 
machen kann und daher pausenlos sogenannte null-Checks durchführen muss. Beispiele 
(Länge eines Strings bestimmen, aber im String steht `null` oder eine Rechenoperation 
durchführen, aber eine der Zahlen ist `null`). Das ergibt jeweils eine Fehlermeldung 
und deswegen gibt es überall Checks a la `if(variable == null)`.
- Das kaskadiert. Wenn Variablen herum gereicht werden zwischen zum Beispiel 
Funktionen, dann muss jede Funktion erneut sicher gehen, dass die Variable nicht 
`null` ist.
- Deswegen unterscheidet Dart (ab 2.12) zwischen Variablen, die `null` als 
Wert haben dürfen und solchen, die es nicht dürfen. Eine normal bezeichnete 
Variable (`String`, `int`, `double`) darf kein `null` enthalten. Eine Variable, die 
`null` enthalten kann, wird mit ? gekennzeichnet (`String?`, `int?`, `double?`).
- Das heißt, dann auch jede Variable initialisiert werden muss. Es gibt also 
keine zeilen mehr a la 
  ```Dart
  int a;
  a = 3;
  ```
  In diesem Fall hätte `a` zumindest für einen kurzen Moment den Wert `null` und 
  das ist nicht zulässig.

Also, durch den Eintrag in der `pubspec.yaml` sagte ich, dass ich mich den Regeln 
der null-Safety unterwerfen werde. Das war von Anfang an der Fall, weil man 
ja schon im letzten Tutorial-Abschnitt sah, dass ich an manchen Stellen mit ? 
hinter dem Variablentyp gearbeitet habe.

Außerdem sage ich in der `pubspec.yaml` ebenfalls, dass zwei 
Libraries / Packages installiert werden.

- **hooks_riverpod** ist eine Variante des Riverpod-Packages, wo sich für mich der 
Code relativ angenehm lesen ließ. Diese Variante setzt aber voraus, dass man 
- **flutter_hooks** ebenfalls installiert hat, was dann eine logische Konsequenz 
war.

Die Versionsnummern kann man jeweils den Webseiten der Packages entnehmen. Ich nahm 
jeweils die neueste Version, die aber ebenfalls null-safe sein muss. Ihr 
könnt Euch auf [pub.dev](https://pub.dev/) ja auch einfach zum Spaß mal ansehen, 
was es alles für Packages gibt.

Ich hab zusätzlich die Datei `/analysis_options.yaml` aus unserem Tetris-Projekt 
kopiert, damit ich auch die vielen Code-Verbesserungsvorschläge bekomme, Dokumentationen 
nicht vergesse, etc.

## Schritt B.2: Änderungen an main.dart

Aufgrund der Installation von Riverpod folgte ich dessen Turorial. Irgendwo, 
mmöglichst weit oben im Widget-Tree muss man einen Provider-Scope definieren, 
also ab wo der State bekannt sein soll. Das geschieht einfach, indem MyApp, das
ja die Oberklasse für alles ist, noch eine Stufe oben drauf bekommt.

```Dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

Außerdem muss irgendwo festgelegt werden, welche Provider von State es gibt.  
Bei Riverpod braucht man dafür eine globale Variable, die eine Referenz auf 
das das StateNotifier-Objekt enthält, das den State verwaltet. Dazu später mehr. 

Dafür habe ich eine eigene Datei `/lib/notifiers/_notifier.dart` angelegt, die 
nur den folgenden Inhalt hat:

```Dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

/// Global variable holding a reference to our state object
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());
```

Folglich lässt sich dann über die Variable `globFieldNotifier` jederzeit ein 
Verweis auf das zuständige Objekt der FieldNotifier-Klasse finden. Das soll 
jetzt echt nicht so klingen, als müsse man das verstehen. Ich folge hier auch 
blind einem Tutorial. Es sind einfach Voraussetzungen, die man schaffen muss, 
um das Riverpod-Package zu verwenden. :-)

Aber im Kern gitl einfach, dass hier ein `FieldNotifier`-Objekt erstellt wird und 
die Referenz darauf ist folglich immer abrufbar über die Variable. Das 
`FieldNotifier`-Objekt bzw. die Klasse habe ich geschrieben, zu der kommen wir 
also noch, aber die Grundidee ist einfach: Dieses Objekt wird, solange die 
App läuft, unseren State verwalten. Sie nimmt Nachrichten aus dem GUI entgegen 
und sie gewöhrt dem GUI Zugriff auf Informationen aus dem State der App (also 
im Wesentlichen Auskünfte über den Zustand des Spielfelds). Dadurch, dass jeder 
Zugriff über sie läuft, ist sichergestellt, dass auch immer die GUI-Updates 
ausgelöst werden, wenn ein neuer State vorliegt.

## Schritt B.3: FieldNotifier

Ja, jetzt haben wir so lange über Riverpod gesprochen und über StateNotifier als 
zentralen Hub für alle Interaktionen mit der GUI. Das muss ja eine wahnsinnig 
komplexe Klasse sein, oder? Nunja, hier der Code:

```Dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/field.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class FieldNotifier extends StateNotifier<Field> {
  /// Constructor (from Riverpod tutorial)
  FieldNotifier() : super(Field());

  /// Creates a new playing field ... just by instantiating a new state
  /// with a new playing field
  void create({required int numRows, required int numCols, required int mines}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, mines: mines);
  }
}
```

Eigentlich passiert weniges, wie man sieht. Ich bin auch nur dem Tutorial 
gefolgt bei der Klassendefinition. Die einzige Ergänzung ist der Name und die 
Klasse des zuständigen State-Objektes, was ja in unserem Fall Field ist.

Wirklich geschrieben habe ich dann lediglich die erste Interaktionsmöglichkeit. 
Man kann ein neues Spielfeld generieren mit der Methode create. Es lohnt sich, 
kurz darüber zu sprechen, wie es funktioniert. Die Methode ruft offensichtlich 
den Konstruktor `Field.withArguments` auf, über den wir schon redeten. Dieser 
konstruiert ein komplettes Spielfeld. Und dieses neue Spielfeld wird dann 
der Variablen state zugewiesen (bzw. dem Attribut). Aber wir haben doch gar kein 
Attribut state definiert? Genau. Aber unsere Klasse hier `extends StateNotifier`. 
Und das heißt, dass sie alle Methoden und Attribute von StateNotifier erbt und 
StateNotifier hat eben ein Attribut namens state, das wir somit auch haben.

Ich habe keinerlei Ahnung, wie Riverpod intern funktioniert, aber die folgende 
Erklärung ist für mich hinreichend sinnvoll:
- `StateNotifier` hat eigentlich ein privates Feld `_state`, hat aber auch Setter 
und Getter dafür definiert. Durch den Getter erhalten wir dann den Inhalt 
dieses privaten Attributs. Wichtiger noch: Die GUI kann über uns den State 
abfragen und ihn darstellen.
- Was der State ist, haben wir definiert: Eine Instanz eines `Field`-Objektes. 
Unser Spielfeld ist also der State.
- Zudem wurde ein  Setter für `_state` implementiert. Das heißt wir schreiben 
einen State in das Attribut `_state` (private) durch den Setter `state` (public). 
Und dieser Setter wurde so geschrieben, dass - wann immer wir ihn nutzen, also 
einen neuen State setzen, er automatisch auch die GUI informiert, dass sie sich 
jetzt neu zu bauen hat.
- Um diese Details müssen wir uns aber nicht kümmern. Das DARF über unseren 
Verstand hinausgehen, sowas selbst zu prorammieren. Wir müssen es nur 
ungefähr verstehen und dann entsprechend mit dieser Technik umgehen. Merken wir 
uns fürs erste nur: Wann immer wir dem Attribut `state` einen neuen 
Wert zuweisen, wird automatisch die GUI upgedated.

Alle anderen Änderungen, die sich durch den Einbau von Riverpod ergaben, sind 
gering. Im Wesentlichen führte es dazu, dass sowohl in main(), als auch im 
StartScreen das oberste Widget jetzt ein `HookWidget` ist, kein `StatelessWidget` 
mehr. HookWidgets sind eben auch ein Teil von Riverpod, und es wird darauf 
hinauslaufen, dass durch diese Widgets Riverpod Zugriff auf die GUI bekommt.

## Schritt B.4: Unit testing

Wir haben immer noch keine wirkliche GUI, nur einen leeren Bildschirm mit einem 
IconButton in der Mitte. Wir haben aber schon komplexe Datenstrukturen geschrieben 
und dabei können uns Fehler unterlaufen sein. Deswegen generieren wir jetzt einige 
Tests, um das richtige Verhalten unserer Daten sicherzustellen.

Dazu existiert nun eine Datei `/lib/test/field_test.dart`. Dart ist so aufgebaut, dass
es alle Dateien mit _test am Ende des Dateinamens nicht als normalen Teil der 
App betrachtet, sondern als separat ausführbare Tests. Schauen wir in den Code:

```Dart
import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

void main() {
  test('Field should be created and have the right number of fields/mines', () {
    final fieldNotifier = FieldNotifier();
    // ignore: cascade_invocations
    fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
    // ignore: invalid_use_of_protected_member
    final state = fieldNotifier.state;
    var numMines = 0;
    var numFields = 0;
    var numFlags = 0;
    state.map.forEach((pos, block) {
      numFields++;
      if (block.mine) numMines++;
      if (block.flagged) numFlags++;
    });
    expect(numMines, 20);
    expect(numFields, 100);
    expect(numFlags, 0);
  });
}
```
Zuerst wird ein Test definiert mit frei wählbarer Beschreibung. Der Test selbst 
wird als anonyme Funktion definiert. Wie sieht unser Test aus?

Wir instanziieren einen FieldNotifier, was ja normal unsere App auch macht. Wir 
geben diesem den Befehl, ein neues Spiel zu kreieren  mit einer festgelegten 
Anzahl an Minen und Feldern. Danach lesen wir den state aus. Das sollte jetzt 
genau das instanziierte neue Spielfeld sein, da der `state` immer den aktuellen 
Stand produziert. Nun gehen wir durch die Map, die Positionen und Blöcke 
miteinander verbindet und über die wir schon redeten. Wir gehen alle Blöcke 
durch und zählen die Minen und Flags.

Am Ende sagen wir, welchen Wert wir eigentlich erwarten, wenn die Klasse richtig 
funktioniert. Wenn das nicht stimmt, dann schlägt unser Test fehl.

In VSCode gibt es die Schaltfläche Test. Hier sieht man, dass VSCode unseren 
definierten Test erkannt hat. Und wir können diesen (oder alle) Test laufen lassen. 
Wenn wir es tun, erhalten wir die Info, dass die Tests erfolgreich durchlaufen 
wurden.

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/flutter/testing01.png)

## Fazit

Wir haben eine App, die immer noch nix kann und nach nix aussieht, aber es 
gibt zumindest einige Datenmodelle, die auch zu funktionieren scheinen. 
Jetzt wird es Zeit, dass wir auch was sehen.