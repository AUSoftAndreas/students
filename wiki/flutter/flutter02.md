## Ein praktisches Beispiel

Es ist nicht einfach, allgemeine Konzepte zu nennen. Es ist in modernen 
Sprachen sehr viel davon abhängig, zum Beispiel welche externen Bibliotheken 
man einbindet etc. Es geht oftmals viel mehr darum, dass man versteht, was man 
tut als so sehr darum, wie man es tut.

Am Beispiel einer einfachen Umsetzung des Windows-Klassikers versuche ich nun 
darzustellen, was ich in welcher Reihenfolge machte.

#### Schritt 1: Grundlage schaffen

Ich startete mit einer blanken Vorlage aus dem VSCode-Menu. Also 
Strg + Shift + P und dann "Flutter: New Application Project". Dann wird das 
bekannte Beispiel mit dem Counter installiert, wobei ich den entsprechenden 
Code sofort löschte.

Eines der großen Probleme von Flutter (bzw. eigentlich jedem System) ist das 
sogenannte State Management. Es handelt sich hierbei um die Verbindung von 
gerendeter Bildschirmausgabe (also GUI) und dem eigentlichen Zustand der Daten. 
Mal ganz abstrakt gesprochen geht es um Folgendes:
- Jede Bildschirmausgabe ist eigentlich eine Art Beschreibung der Daten / des State
- Wenn sich durch unsere Eingaben in der GUI dieser State ändert, dann muss 
natürlich dieser veränderte State zu einer veränderten Darstellung führen. Dafür 
gibt es bestimmte eingebaute Methoden in Flutter/Dart.
- Wenn aber die Änderung der Daten von außerhalb geschieht (also zum Beispiel 
durch die Ergebnisse einer Datenabfrage oder dergleichen), wie sage ich dann der 
GUI "Hey, der State ist neu, bau dich mal neu auf"?

Diese Problematik nennt man allgemein das State Management und bei jeder halbwegs 
schwierigeren Anwendung wird man sich damit auseinander setzen müssen, weil es 
eben nicht so einfach ist, dass jede Datenänderung eine Reaktion auf direkte 
Benutzereingaben ist.

Wie auch immer: Bei manchen meiner / unserer Projekte nutzen wir eine Library namens 
[Bloc](https://bloclibrary.dev/#/) im Hintergrund, die als Mittler zwischen 
Daten und GUI funginert. Aus persönlichen Lerngründen habe ich mich für Minesweeper 
dazu entschieden, mit einer relativ neuen Lösung namens [Riverpod](https://riverpod.dev/) 
zu arbeiten, einfach weil ich das ausprobieren wollte.

Im Endeffekt führt jedes State Management System dazu, dass man reativ bequem mit 
sich veränderndem State arbeiten kann. Ungefähre Grundidee von diesen Systemen ist:
- Eine GUI bildet den gegenwärtigen State ab.
- Der State ist unveränderbar (immutable).
- Wir können aber einen **neuen State** definieren und wenn wir das tun, dann 
werden automatisch alle Elemente / Screens, die sich auf den State beziehen, 
geupdated.
- Dadurch fallen die Flutter-eigenen Lösungen für das Thema State im Prinzip flach, 
also wenn Ihr in einem Tutorial etwas über `StatefilWidget` lernt, dann kann 
es sein, dass Ihr diese nicht notwendig habt, wenn Ihr Bloc oder Riverpod nutzt.
- Im Endeffekt muss man sich State so vorstellen, dass er irgendwo als Objekt 
  kreiert wird. Und wenn wir ihn überall in der App dann verwenden wollten, dann 
  müssten wir ihn als Argument immer durchreichen auf jeden Screen.
- State Managament Systeme wie Riverpod deklarieren den State irgendwo und 
stellen dann Methoden bereit, um aus jeder Ecke auf den State zuzugreifen und 
sorgen dann dafür, dass State-Updates auch zu GUI-Updates führen.

Folglich war mein Start für die main.dart mehr oder weniger deren Beispiel für 
einen simplen Starter-Code, den ich dann deutlich eingedampft habe. 

```
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
final helloWorldProvider = Provider((_) => 'Hello world');

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// Note: MyApp is a HookWidget, from flutter_hooks.
class MyApp extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // To read our provider, we can use the hook "useProvider".
    // This is only possible because MyApp is a HookWidget.
    final String value = useProvider(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Example')),
        body: Center(
          child: Text(value),
        ),
      ),
    );
  }
}
```

Riverpod musste auch installiert werden. Die Installation von Libraries ist 
erdenklich einfach. Dazu musste einach die /pubspec.yaml geändert werden. In 
dieser Datei werden alle Libraries gelistet, die zum Einsatz kommen, zusammen 
mit ihren Versionsnummern. Der interessante Abschnitt ist dieser:

```
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
machen kann und daher pausenlos sogenannte null-Checks durchführen kann. Beispiele 
(Länge eines Strings bestimmen, aber im String steht `null` oder eine Rechenoperation 
durchführen, aber eine der Zahlen ist `null`). Das ergibt jeweils eine Fehlermeldung 
und deswegen gibt es überall Checks a la 'if(variable is null)`.
- Das kaskadiert. Wenn Variablen herum gereicht werden zwischen zum Beispiel 
Funktionen, dann muss jede Funktion erneut sicher gehen, dass die Variable nicht 
`null` ist.
- Deswegen unterscheidet Dart (ab 2.12) zwischen Variablen, die `null` als 
Wert haben dürfen und solchen, die es nicht dürfen. Eine normal bezeichnete 
Variable (String, int, double) darf kein `null` enthalten. Eine Variable, die 
`null` enthalten kann, wird mit ? gekennzeichnet (String?, int?, double?).
- Das heißt, dann auch jede Variable initialisiert werden muss. Es gibt also 
keine zeilen mehr a la 
  ```
  int a;
  a = 3;
  ```
  In diesem Fall hätte `a` zumindest für einen kurzen Moment den Wert `null` und 
  das ist nicht zulässig.

Also, durch den Eintrag ind er pubspec.yaml sagte ich, dass ich mich den Regeln 
der null-Safety unterwerfen werde. Außerdem sage ich dort ebenfalls, dass zwei 
Libraries / Packages installiert werden.

- **hooks_riverpod** ist eine Variante des Riverpod-Packages, wo sich für mich der 
Code relativ angenehm lesen ließ. Diese Variante setzt aber voraus, dass man 
- **flutter_hooks** ebenfalls installiert hat, was dann eine logische Konsequenz 
war.

Die Versionsnummern kann man jeweils den Webseiten der Packages entnehmen. Ich nahm 
jeweils die neueste Version, die aber ebenfalls null-safe sein muss. Ihr 
könnt Euch auf [pub.dev](https://pub.dev/) ja auch einfach zum Spaß mal ansehen, 
was es alles für Packages gibt.

Ich hab zusätzlich die Datei /analysis_options.yaml aus unserem Tetris-Projekt 
kopiert, damit ich auch die vielen Code-Verbesserungsvorschläge bekomme, Dokumentationen 
nicht vergesse, etc.

#### Schritt 2: Klein beginnen
Im Endeffekt hatte ich dann eine App, die einfach eine belanglose Seite anzeigt 
und sonst nix kann. Und nun beginnt das Arbeiten an den Daten. Ich habe mir folgende 
Sachen erstmal überlegt:

- Im Prinzip ist Minesweeper ein Spiel, wo das Spielfeld aus einer variablen 
Anzahl von Blöcken besteht.
- Alle Interaktionen spielen sich bezogen auf diese Blöcke ab.
- Ich werde also höchstwahrscheinlich mindestens mal eine Klasse für das Spielfeld 
haben müssen, wo es jeweils ein aktives geben wird - und eine Klasse für einen 
einzelnen Block, wobei gleichzeitig ggf. hunderte Blöcke existieren werden
- Ansprechbar soll jeder Block über seine Position sein.

Mein allererster, kleiner Schritt war daher, dass ich auch eine Klasse für 
Positionen schaffen wollte. Das ist nicht zwingend notwendig, aber eine Klasse 
heißt ja zugleich, dass sie zu einem gültigen Variablentyp wird - und mir fielen 
viele Beispiele ein, wo es praktisch wäre, eine Position irgendwo zu speichern 
oder zu übergeben. Gesagt, getan, eine Klasse `Position` war geschaffen:

```
import 'package:flutter/foundation.dart';

/// Defines an absolute position (of a block)
@immutable
class Position {
  /// Horizontal component of position, from 0 (left) to numCols-1 (right)
  final int x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  final int y;

  /// Standard constructor for position
  const Position(this.x, this.y);

  /// Overridden toString method, for better output instead of "Instance of <Posiion>"
  @override
  String toString() => 'Position($x/$y)';

  @override
  bool operator ==(Object o) => o is Position && o.x == x && o.y == y;

  @override
  int get hashCode => 1000 * x + y;
}
```

Keine Sorge, das ist alles einfacher als es aussieht. Bereinigen wir es mal um 
Kommentare und Annotationen, die ja funktional nicht wirklich notwendig sind.

```
import 'package:flutter/foundation.dart';

class Position {
  final int x;
  final int y;
  Position(this.x, this.y);

  String toString() => 'Position($x/$y)';

  bool operator ==(Object o) => o is Position && o.x == x && o.y == y;

  int get hashCode => 1000 * x + y;
}
```

Gehen wir den Code durch:
- `final int x;`
  `final int y;`
  Eine Position wird bestimmt durch eine X- und eine Y-Koordinate. Beides sind 
  Ganzzahlen, weil es keine halbe Position gibt auf dem Spielfeld. Also definieren 
  wir beides als Attribute einer Position.
- `Position(this.x, this.y);`
  Eine Position wird zukünftig erstellt, indem man zum Beispiel einfach 
  Position(2,3) schreibt, damit beschreibt man eindeutig den Block in der 3. 
  Spalte von rechts und der 4. Zeile von unten (Indizes sind meistens 0-basiert, 
  also es gibt Zeile/Spalte 0)..

Und das ist schon das Ende für den Code, der wirklich klassenbezogen ist. Da ich 
hin und wieder Log-Ausgaben produziere und ich da nicht jedesmal etwas schreiben will wie 
`log('Position erstellt mit dem Koordinaten ${pos.x} / ${pos.y}');` habe ich 
die toString-Methode, die jedes Objekt habe, überschrieben. Die sorgte in ihrer 
Standardfassung dafür, dass ein `log('$pos');` immer die Ausgabe `Instance of <Position>` 
erzeugt, was wenig aussagefähig ist. Durch meine Veränderung wird jetzt bspw. 
`Position(2/3)` ausgegeben.

Für die nächsten beiden Codeabschnitte müssen wir kurz etwas Theorie wiederholen. 
Eine Variable enthält in der Regel nicht das Objekt selbst, sondern einen 
Verweis darauf. Bei den sogenannten "Primitives" (primitive Werte wie String, 
int, double) ist alles so eingerichtet, dass man Werte miteinander vergleichen kann. 
Bei den eigenen Klassen allerdings nicht. Man beachte folgenden Code:

```
class SimpleClass {
  String attribute;
  SimpleClass(this.attribute);
}

void main() {
  var a = 'Hallo';
  var b = 'Hallo';
  print(a==b); // => true
  var c = SimpleClass('Hallo');
  var d = SimpleClass('Hallo');
  print(c==d); // => false
}
```

Man sieht, dass er bei zwei Instanzen der SimpleClass nicht wirklich prüft, ob 
die Inhalte gleich sind. Stattdessen sagt er einfach "es sind zwei verschiedene 
Instanzen, also sind sie ungleich". Das ist natürlich, gerade bei großen Klassen, 
auch die viel schnellere Prüfroutine und oft genug passt sie. Hier aber nicht. 
Wir werden oft Positionen vergleichen und dazu werden wir Positionen erzeugen 
und dann soll eben gelten, dass `Position(2,3) == Position(2,3)` ist.

Daher overriden wir den Operator `==` mit dem nachfolgenden Code:
```
bool operator ==(Object o) => o is Position && o.x == x && o.y == y;
```
Wir sagen dadurch: Eine Position(x/y) ist dann **gleich** einem anderen Objekt 
(ganz allgemein), wenn auch das andere Objekt eine Position ist und wenn dann 
auch x und y übereinstimmen.

Und schließlich gab es die Linter-Aufforderung, dass an nie nur den Equality-Operator 
unterschreiben soll, sondern auch den sogenannten hashCode, der dem Computer 
dabei hilft, Werte zu vergleichen. Er soll den Inhalt schneller repräsentieren 
als wenn man wirklich händisch alle Attribute vergleicht. Nunja, die von mir 
gefundene Funktion `1000 * x + y` garantiert, dass jede wirklich verschiedene 
Position auch einen unterschiedlichen hashWert hat und deswegen nahm ich sie.

Alle anderen Änderungen an der Datei waren Linter-bezogen, also weil er zum 
Beispiel bemängelte, dass eine Dokumentation fehlt oder dass man das Keyword 
final verwenden soll. Zum Beispiel sagte der Linter auch, dass man `==` nur 
overriden soll, wenn die Klasse immutable ist. Das heißt, dass ein Objekt der 
Klasse nach Instanziierung nie verändert werden darf. Warum? Weil man verhindern 
will, dass ein Vergleich ergibt, dass zwei Objekte gleich sind, dann verändert 
man bei einem der beiden die Eigenschaften und schon sind sie eben nicht mehr 
gleich. Nunja, uns störte es nicht, weil eine Position hier sich nie ändert.

Im Endeffekt haben wir dann eine Klasse, mit der sich Objekte instanziieren lassen, 
die jeweils eine Position auf dem Spielfeld repräsentieren. Ein kleiner, 
wichtiger Schritt.

#### Schritt 3: Der Block (nur der Daten-Part)

Als nächstes habe ich mich dem Block zugewendet. An jeder Position sitzt 
später ein Block und der hat ebenfalls Informationen, die ihm zugeordnet sind. 
Im ersten Schritt habe ich nur diese Informationen erstmal abgebildet und den 
Rest der Klasse, den Ihr in lib/models/block.dart sehen könnt, dann erst später 
geschrieben.

```
import 'package:minesweeper/models/position.dart';

/// Class representing a single block on the playing field of the game.
class Block {
  /// Absolute position of block on field.
  final Position _position;

  /// Indicates whether block is mined or not
  final bool _mine;

  /// Indicates whether block is mined or not
  bool get mine => _mine;

  /// Indicates whether block is fagged or not
  bool flagged = false;

  /// How many mines are on the neighboring 8 blocks
  int _closeMines = 0;

  /// How many mines are on the neighboring 8 blocks
  int get closeMines => _closeMines;

  /// Indicates whether the player already opened this block or not
  bool open = false;

  /// Standard contructor for a block.
  Block({required position, mine = false})
      : _position = position,
        _mine = mine;
}
```

Wieder ist der Part eigentlich verdaubar. Was geschieht?
- Jeder Block hat eine Position (privat) und zudem die folgenden Eigenschaften 
(in der Regel auch privat, also von außen weder auslesbar noch veränderbar):
  - Liegt hier eine Mine oder nicht? Diese Information wird von anderen Stellen 
  benötigt (zum Beispiel Anzeige) und daher richten wir zusätzlich einen Getter 
  ein, mit dem man die Information auslesen kann. Sie ist aber nicht veränderbar, 
  da es keinen Setter gibt.
  - Hat der Spieler ein Fähnchen hinein gesteckt oder nicht? (Standardwert nein) 
  Natürlich ist die Information auslesbar, weil die Anzeige ein Fähnchen darstellen 
  muss. Und in diesem Fall ist sie auch veränderbar, weil man von außen (via 
  GUI ein Fähnchen hinein stecken kann). Also hab ich die Variable einfach 
  public gestellt (dadurch, dass sie keinen Unterstrich vorm Namen hat).
  - Wie viele Minen liegen auf den 8 Nachbarfeldern? (Standardwert 0) Die Info 
  ist wieder für die GUI interessant und ist daher mit einem Getter versehen.
  - Hat der Spieler dieses Feld bereits geöffnet? (Standardwert nein) Selbe Überlegung 
  wie bei flagged.

Wie jede Klasse braucht auch der Block einen Konstruktor, also eine Funktion, 
mit der man einen Block produzieren kann. Hier verlangt (`required`) der Konstruktor nach 
einer Position. Die Angabe, ob hier eine Mine liegt, kann man auch weglassen (dann nein).

Ein bischen ungewohnt ist die Form des Konstruktors. Dart unterscheidet beim Konstruktor sozusagen 
drei verschiedene Orte, an denen man Werte setzen kann. 

```
Konstruktor(1) : 2 {
    3
} 
```

Wir können Werte direkt in der Argumentenliste(1) entgegennehmen (this.x bei der 
Position zum Beispiel). Das klappt aber nicht, wenn die Attribute einen Unterstich 
im Namen haben und benannte Attribute sind. Es würde klappen mit 
Block(this.position, this.mine) .... Aber ich mag es häufig, wenn die Attribute mit 
Namen aufgerufen werden müssen, also Block(position: Bla, mine: blun). Daher die 
Schreibweise mit den geschweiften Klammern und dann geht dieses direkte Weiterreichen 
per this nicht. Dann gibt es wie bei jeder Funktion die Möglichkeit, etwas im Body 
zu tun (3). Dann ist das Objekt aber bereits erstellt. Es ist sozusagen der Code, 
der laufen soll, nachdem das Objekt instanziiert ist. Man kann hier beispielsweise 
keine finale Variable mehr ändern, auch nicht wenn das die Erstbelegung ist, weil 
die Variable **wurde** ja schon erstellt. Und dann gibt es eben den Block 2, der 
in meiner Variante verwendet wurde. Hier können Attribute initialisiert werden, 
während das Objekt noch nicht existiert - und für die Attribute, deren Belegung 
nicht durch die Argumentenliste gehandhabt wurde

Der Rest der Klasse, den Ihr in lib/models/block.dart sehen könnt, habe ich später 
geschrieben und auf den gehen wir auch später ein. Mein nächstes Thema war ...

#### Schritt 4: Das Spielfeld

```
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/position.dart';

@immutable

/// Class representing the game field
class Field {
  /// A map (associative array), linking each Position to its corresponding block.
  late final Map<Position, Block> map;

  /// Number of mines on the field
  final int mines;

  /// Number of rows
  final int numRows;

  /// Number of columns
  final int numCols;

  /// Is the game already lost?
  final bool gameLost;

  /// Will the next click of the user plant a flag (instead of opening a block)?
  final bool flagMode;

  /// Constructs a game field for our game
  /// It is an empty field. We just use it for instantiating the game in
  /// lib/notifiers/_notfifiers.dart. It will be reconstructed many times using
  /// the .withArguments constructor.
  Field()
      : map = {},
        mines = 0,
        numRows = 0,
        numCols = 0,
        gameLost = false,
        flagMode = false;

  /// Constructs a game field for our game
  Field.withArguments({required this.numRows, required this.numCols, required this.mines})
      : gameLost = false,
        flagMode = false {
    final newMap = <Position, Block>{};
    var leftMines = mines;
    var leftFields = numRows * numCols;
    final rng = math.Random();
    for (var col = 0; col < numCols; col++) {
      for (var row = 0; row < numRows; row++) {
        final pos = Position(col, row);
        final prob = (100 * leftMines) ~/ leftFields;
        final mine = rng.nextInt(100) < prob;
        newMap[pos] = Block(position: pos, mine: mine);
        if (mine) {
          leftMines--;
        }
        leftFields--;
      }
    }
    // Let each field calculate its nearby mines
    newMap.forEach((pos, block) {
      block.updateCloseMines(newMap);
    });
    map = newMap;
  }

  // ignore: prefer_const_constructors_in_immutables
  Field._internal({
    required this.map,
    required this.mines,
    required this.numRows,
    required this.numCols,
    required this.gameLost,
    required this.flagMode,
  });

  /// Returns new Field object, which is a copy of this object, but with
  /// some differences specified when calling this method.
  Field copyWith({Map<Position, Block>? map, int? mines, int? numRows, int? numCols, bool? gameLost, bool? flagMode}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? this.mines,
        numRows: numRows ?? this.numRows,
        numCols: numCols ?? this.numCols,
        gameLost: gameLost ?? this.gameLost,
        flagMode: flagMode ?? this.flagMode,
      );
}
```

Das ist natürlich datenseitig das Kernstück unserer Arbeit. Deswegen ist es auch 
ein bisserl mehr. Argumente schenke ich mir diesmal .... Zu den Konstruktoren: 
Ich habe einen mehr oder weniger leeren Konstruktor angelegt. Das ist nur 
nötig, weil Riverpod von mir verlangt, dass ich ihm am Anfang ein Objekt übergebe, 
dessen Veränderungen es dann immer der GUI mitteilt. Also habe ich hier einen 
Weg, eine Art Dummy-Spielfeld am Anfang anzulegen. Das geschieht in lib/notifiers/_notifiers.dart, 
was ich mal eine sehr prägnante Datei nennen möchte:

```
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

/// Global variable holding a reference to our state object
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());
```

Mal ehrlich, ich bin hier auch nur einem Blogeintrag gefolgt. In dieser Variablen 
wird halt unser State-Objekt abgelegt, sodass wir später jederzeit darauf 
zugreifen können. :-)

Zurück zur Field-Klasse. Dann gibt es zwei weitere Konstruktoren. Dart erlaubt 
beliebig viele Konstruktoren, wobei die sich durch einen Punkt und dann eine 
Namensergänzung unterscheidbar sind. Man kann also entweder ein mehr oder 
weniger leeres Spielfeld erstellen (standard-Konstruktor) oder mit einigen 
Argumenten ein vernünftiges Spielfeld. Außerdem haben wir die Möglichkeit 
schaffen, alle Feinheiten zu kontrollieren. Dafür wurde ein Konstruktor geschaffen, 
mit dem man quasi alles bestimmen kann.

Und zuletzt kommt die copyWith-Methode, die in Sachen State Management ein 
Kernstück ist. Ich habe ja schon gesagt, dass der State sich nicht verändert, 
sondern dass jeweils ein neuer State festgelegt wird. Das ist dann wirklich 
ein neues Field-Objekt. Dieses neue Field-Objekt wird erzeugt, indem wir im 
Wesentlichen alle Eigenschaften des aktuellen Field-Objekts übernehmen, nur nicht die, 
die wir bewusst anders haben wollen.

## Wie gehts weiter?

Die nächste Folge widmet sich der grafischen Darstellung des States.