## Ein praktisches Beispiel

Es ist nicht einfach, allgemeine Konzepte zu nennen. Es ist in modernen 
Sprachen sehr viel davon abhängig, zum Beispiel welche externen Bibliotheken 
man einbindet etc. Es geht oftmals viel mehr darum, dass man versteht, was man 
tut als so sehr darum, wie man es tut.

Am Beispiel einer einfachen Umsetzung des Windows-Klassikers versuche ich nun 
darzustellen, was ich in welcher Reihenfolge machte.

### Wie dieses Tutorial funktioniert

Ich habe den Code veröffentlicht in einem Repo unter 
[AUSoftAndreas/flutter-minesweeper](https://github.com/AUSoftAndreas/flutter_minesweeper). 
Mein vorgeschlagener Weg lautet nun so: Jedes Kapitel hat einen zugeordneten Branch. 
Dieses Kapitel ist beispielsweise Branch "step_a" als Branch zugeordnet. Wenn 
Ihr also nachvollziehen wollt, wie die App nach und nach entstanden ist, dann 
clont Euch das Repository und dann wechselt unten links den Branch und geht auf 
"step_a". Gegebenenfalls müsst Ihr nochmal pullen, damit es wirklich der richtige 
Stand ist, aber prinzipiell sollten es sofort weniger Dateien sein und eine 
deutlich schlechtere App. :-)

## Schritt A.1: Grundlage schaffen

Ich startete mit einer blanken Vorlage aus dem VSCode-Menu. Also 
Strg + Shift + P und dann "Flutter: New Application Project". Dann wird das 
bekannte Beispiel mit dem Counter installiert, wobei ich den entsprechenden 
Code sofort löschte.

Meine main.dart ist daher sehr spartanisch:

```
import 'package:flutter/material.dart';
import 'package:minesweeper/ui/start_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

/// Base class of app
class MyApp extends StatelessWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => StartScreen(),
      },
      initialRoute: '/',
    );
  }
}
```

Ich erkläre kurz, was die main.dart tut. Im Wesentlichen ist das der Startpunkt 
für die App. Man sieht die `void main()`, die den eigentlichen Einstiegspunkt 
darstellt. Sie tut nicht mehr als die App zu starten, was zwar im Hintergrund 
sicher einiges an Prozessen startet, uns aber eher wenig beschäftigt.

MyApp ist das erste Widget, sozusagen das Stammwidget für alles, was kommt. 
Sämtliche GUI-Elemente in Flutter sind Widgets. Sie sind alle untereinander 
relativ austauschbar insofern, als dass sie alle sich auf die Basisklasse `Widget` 
beziehen. Dadurch ist der Bau einer GUI sehr flexibel, weil ein Widget wieder 
ein anderes Widget als child haben kann - und da ein Widget so vieles sein kann, 
gibt es da einfach viel Auswahl.

In jeder Klasse, die wiederum auf Widgets basiert (wie hier MyApp) gilt es eine 
build-Methode. Diese Methode ist das, was die Ausgabe auf dem Bildschirm erzeugt. 
Sie läuft unter Umständen, zu denen wir noch kommen werden, viele Male pro Sekunde 
ab. Sie kann aber auch über Minuten nicht laufen, wenn Ihr Euch einfach einen 
Screen in der App anschaut. Sie würde aber beispielsweise sofort ablaufen, wenn 
Ihr das Handy dreht. Die build-Methode returnt jeweils Widgets und die werden 
auf dem Bildschirm gerendert. Die Annotation '@override' wird vom Linter gewollt, 
weil technisch gesehen wir die build-Methode unserer Mutterklasse (StatelessWidget) 
überschreiben. Das wird also bei jeder build-Methode passieren. Die Zeile mit dem 
ignore sagt einfach, dass wir den blauen Linter-Hinweis ignorieren wollen, der 
sonst erschiene, wenn wir die Zeile nicht hätten. Das könnt ihr ja ausprobieren.

In unserem Fall setzt diese build-Methode einfach nur ein paar Werte fest. Das 
passiert mit dem MaterialApp-Widget. Hier geht es vor allem um die routes. 
Das heißt, dass wir unseren Screens in der App (also den verschiedenen GUI-
Bildschirmen) jeweils einen Namen zuordnen. Den Namen '/' (was ein Standard für 
den Startscreen ist) ordnen wir also die Klasse StartScreen zu.) Ihr ahnt es, auch 
StartScreen wird eine Tochter eines Widgets sein und in seiner build-Methode ein 
Widget returnen? Exakt.

Außerdem sagen wir, dass die erste Route (initialRoute), also der erste geladene 
Screen der StartScreen sein soll. Sonst passiert hier nix. Kommen wir zum StartScreen:

```
import 'package:flutter/material.dart';

/// Welcome Screen for the app
class StartScreen extends StatelessWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
```

Selber Aufbau. Und das erste kleine Beispiel dafür, wie GUI-Screens in Flutter 
beschrieben werden. Diese Baumstruktur mit den Einrückungen ist typisch (und 
im Prinzip HTML nicht ganz unähnlich). Gehen wir die Widgets durch:
- Das [Material-Widget](https://api.flutter.dev/flutter/material/Material-class.html) 
sorgt einfach dafür, dass die MaterialDesign-Google-Bibliotheken laufen. Das muss man 
also irgendwohin packen. Ich hatte es auch vergessen und es sorgt dann für 
Fehlermeldungen bei dem Icon-Button, weil Flutter nicht weiß, wie 
so ein Button aussieht, wenn es nicht irgendwo innerhalb eines Material-Widgets geschieht. 
Bei den meisten meiner Apps nutze ich für den Bildschirmaufbau das sogenannte 
[Scaffold-Widget](https://api.flutter.dev/flutter/material/Scaffold-class.html), 
das Material wohl einschließt und muss Material deswegen nicht verwenden. Das 
Scaffold sorgt für einen Seitenaufbau mit Titelleiste etc., aber in dieser App 
wollte ich keine Titelleiste.
- Innerhalb des Material-Widgets liegt ein 
[Container-Widget](https://api.flutter.dev/flutter/widgets/Container-class.html). 
Container-Widgets kommen häufig vor und sind im Prinzip wie `<div></div>` in 
HTML, also einfach eben ein Container um das, was da drin ist. Im Kern wird 
einfach die ganze Seite erstmal in einen Container gepackt.
- In dem Container ist dann ein [Center-Widget](https://api.flutter.dev/flutter/widgets/Center-class.html). 
Ein Center-Widget zentriert einfach alles (vertikal und horizontal), was seine 
Nachkommen sind.
- Und schließlich kommt ein [IconButton-Widget](https://api.flutter.dev/flutter/material/IconButton-class.html). 
Wie man vom Namen her annehmen kann, wird hier ein Button produziert, der wiederum 
ein Icon darstellt. Ihm gibt man dann als Attribute das Icon mit, das dargestellt wird 
(siehe oben `Icon(Icons.ac_unit)`) und man muss auch definieren, was passieren soll, 
sobald der Button gedrückt wird. In dem Fall definierte ich eine anonyme Funktion 
ohne Inhalt. Also eigentlich passiert nichts.

*Was Ihr an dieser Stelle tun könnt und solltet:
- Cursor in `Material` platzieren, rechts clicken und "Refactor" auswählen im 
Kontextmenu. Seht, welche Möglichkeiten Ihr habt. Wählt "Remove widget" und seht, 
dass VSCode Euch hilft. Es entfernt das Material-Widget und die dadurch notwendige 
Klammer am Ende des Blocks. alle anderen Widgets rücken eine Ebene hoch (also 
weiter nach links im Editor). Nun könnt Ihr den Container ebenfalls markieren und 
rechtsclicken. Wiederum "refactor" wählen und "Wrap with widget". Dann wird 
Euer Container in ein noch zu benenndes Widget gehüllt. Nennt das wieder 
`Material` und wir haben den Anfangszustand wieder erreicht. VSCode hilft Euch 
sehr bei der Tipparbeit und das solltet Ihr in Zukunft oft nutzen.
- Fahrt mit dem Mauszeiger über die einzelnen Widgetnamen und VSCode zeigt Euch 
dann an, wie dieses Widget definiert ist und Ihr seht all die Attribute, die Ihr 
definieren KÖNNTET beim Aufruf. Testen wir das mal bei einem aus:
  - Fahrt mit dem Mauszeiger über den Container. Wie Ihr sehen könnt, könnte man 
  einem Container eine Farbe geben, indem man das Attribut color setzt. Okay, tun 
  wir das.
  - Ändert
  ```
      child: Container(
        child: Center(
  ```
  zu
  ```
      child: Container(
        color: Colors.red,
        child: Center(
  ```
  - Seht, dass Ihr dadurch den Container rot gefärbt habt, was man auch in der 
  App sofort sieht. Solche Änderungen werden Euch übrigens immer sofort in der 
  App angezeigt, wenn sobald Ihr die Datei speichert (Strg+S).
  - Begreift den Aufbau: Jeder Widget-Aufruf (ein Konstruktor) erlaubt Euch, 
  bestimmte Attribute zu setzen, die zu dem Widget gehören. Manche Attribute 
  gehen vielleicht sogar wiederum über mehrere Zeilen. Sie enden dann mit einem 
  Komma. Das Schwierigste ist eigentlich, den Überblick über all die Kommans und 
  Klammern zu behalten. Auch da hilft VSCode, indem es hinter die schließenden 
  Klammern einen Text setzt, um Euch zu sagen, zu welchem Element die Klammer 
  gehört.
- Das Komma nach dem letzten Attribut kann man eigentlich weg lassen, aber 
VSCode formatiert den Code schöner, wenn man darauf achtet, eigentlich immer auch 
Kommas zu setzen.

Okay. Halten wir fest: Wir haben jetzt eine App, die nix kann und nach nix aussieht. :-)

## Schritt A.2: Models

Die Grundlage ist eigentlich immer, dass man mit den Daten beginnt. Die UI ist 
ja nur eine grafische Representation des sogenannten State. Wir müssen nun überlegen, 
was den State der App ausmacht, also den Zustand, den - würde man ihn komplett 
kennen - einen in die Lage versetzen würde, den Bildschirm zu zeichnen.

Es ist nicht allzu schlimm, wenn man dabei etwas vergisst. Man kann ja nachlegen, 
aber das Arbeiten an GUI etc. macht keinen Sinn ohne ein Verständnis davon zu 
haben, was man eigentlich darstellen will. Ich habe mir folgende 
Sachen erstmal überlegt:

- Im Prinzip ist Minesweeper ein Spiel, wo das Spielfeld aus einer variablen 
Anzahl von Blöcken besteht. Alle Interaktionen spielen sich bezogen auf diese Blöcke ab.
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
  final int _x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  final int _y;

  /// Standard constructor for position
  const Position(this._x, this._y);

  /// Horizontal component of position, from 0 (left) to numCols-1 (right)
  int get x => _x;

  /// Vertical component of position, from 0 (bottom) to numRows-1 (top)
  int get y => _y;

  /// Overridden toString method, for better output instead of "Instance of <Posiion>"
  @override
  String toString() => 'Position($x/$y)';

  @override
  bool operator ==(Object o) => o is Position && o.x == _x && o.y == _y;

  @override
  int get hashCode => 1000 * x + y;
}
```

Keine Sorge, das ist alles einfacher als es aussieht. Bereinigen wir es mal um 
Kommentare und Annotationen, die ja funktional nicht wirklich notwendig sind.

```
import 'package:flutter/foundation.dart';

@immutable
class Position {
  final int _x;
  final int _y;

  const Position(this._x, this._y);

  int get x => _x;
  int get y => _y;

  String toString() => 'Position($x/$y)';

  bool operator ==(Object o) => o is Position && o.x == _x && o.y == _y;

  int get hashCode => 1000 * x + y;
}
```

Gehen wir den Code durch:
- `final int _x;`
  `final int _y;`
  Eine Position wird bestimmt durch eine X- und eine Y-Koordinate. Beides sind 
  Ganzzahlen, weil es keine halbe Position gibt auf dem Spielfeld. Also definieren 
  wir beides als Attribute einer Position. Da ich eigentlich nicht will, dass eine 
  Position im Nachhinein von irgendwem geändert wird, sind beide als private 
  definiert, was durch den Unterstrich klar gemacht wird. Wenn man aber eine Position 
  hat, dann soll man sie durchaus auslesen können. Man soll sie nur nicht 
  verändern dürfen.
- `int get x => _x;`
  `int get y => _y;`
  Diese Zeilen, sogenante Getter, sorgen dafür, dass die Attribute auslesbar sind. 
  Sie definieren ein öffentliches Attrubut x bzw. y, das man von außen getten, also 
  lesen kann. Man bekommt dann (=>) den Inhalt der beiden privaten Attribute 
  _x bzw. _y ausgegeben. Einfach sich daran erinnern:
  `int get x => _x;`  
  ist nur eine andere Schreibweise für  
  ```
  int get x {
    return _x;
  }
  ```
- `Position(this._x, this._y);`
  Eine Position wird zukünftig erstellt, indem man zum Beispiel einfach 
  Position(2,3) schreibt, damit beschreibt man eindeutig den Block in der 3. 
  Spalte von rechts und der 4. Zeile von unten (Indizes sind meistens 0-basiert, 
  also es gibt Zeile/Spalte 0). Es werden (da wir keine `[]` oder `{}` verwenden) 
  positionale Argumente benötigt, man kann auch keines weglassen. Das erste 
  Argument, was man verwendet, wird automatisch in _x geschrieben, das zweite 
  automatisch in _y. `this` steht stellvertretend für "dieses Objekt".

Und das ist schon das Ende für den Code, der wirklich klassenbezogen ist. Da ich 
hin und wieder Log-Ausgaben produziere und ich da nicht jedesmal etwas schreiben will wie 
`log('Position erstellt mit dem Koordinaten ${pos.x} / ${pos.y}');` habe ich 
die toString-Methode, die jedes Objekt hat, überschrieben. Die sorgte in ihrer 
Standardfassung dafür, dass ein `log('$pos');` immer die Ausgabe `Instance of <Position>` 
erzeugt, was wenig aussagefähig ist. Durch meine Veränderung wird jetzt bspw. 
`Position(2/3)` ausgegeben.

Für die nächsten beiden Codeabschnitte müssen wir kurz etwas Theorie wiederholen. 
Eine Variable enthält in der Regel nicht das Objekt selbst, sondern einen 
Verweis darauf. Bei den sogenannten "Primitives" (primitive Werte wie String, 
int, double) ist alles so eingerichtet, dass man Werte miteinander vergleichen kann. 
Bei den eigenen Klassen allerdings nicht. Man beachte folgenden Code (den Ihr 
in einem Tool wie [DartPad](https://dartpad.dev/) gut nachvollziehen könnt):

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
bool operator ==(Object o) => o is Position && o.x == _x && o.y == _y;
```
Wir sagen dadurch: Eine Position(x/y) ist dann **gleich** einem anderen Objekt 
(ganz allgemein), wenn auch das andere Objekt eine Position ist und wenn dann 
auch x und y übereinstimmen mit unseren Attributen _x und _y (man beachte 
die Unterstriche, denn die sind ja privat, wobei wir auch x und y schreiben könnte, 
denn unsere Klasse würde dann über den Getter ja auch _x und _y bekommen).

Und schließlich gab es die Linter-Aufforderung, dass man nie nur den Equality-Operator 
overriden soll, sondern auch den sogenannten hashCode, der dem Computer 
dabei hilft, Werte zu vergleichen. Er soll den Inhalt schneller repräsentieren 
als wenn man wirklich händisch alle Attribute vergleicht. Nunja, die von mir 
gefundene Funktion `1000 * x + y` garantiert, dass jede wirklich verschiedene 
Position auch einen unterschiedlichen hashWert hat und deswegen nahm ich sie.

Alle anderen Änderungen an der Datei waren Linter-bezogen, also weil er zum 
Beispiel bemängelte, dass eine Dokumentation fehlt oder dass man das Keyword 
final verwenden soll. Das gilt zum Beispiel für _x und _y. Warum? Nun, wenn 
ich keinerlei Setter habe, mit dem man den Wert von _x und _y ändern kann und 
auch keine meiner Methoden in dieser Klasse es tut, dann sind die Variablen 
per definitionem final, also unveränderbar.

Das heißt, dass ein Objekt der 
Klasse nach Instanziierung nie verändert werden darf. Warum? Weil man verhindern 
will, dass ein Vergleich ergibt, dass zwei Objekte gleich sind, dann verändert 
man bei einem der beiden die Eigenschaften und schon sind sie eben nicht mehr 
gleich. Nunja, uns störte es nicht, weil eine Position hier sich nie ändert.

Im Endeffekt haben wir dann eine Klasse, mit der sich Objekte instanziieren lassen, 
die jeweils eine Position auf dem Spielfeld repräsentieren. Ein kleiner, 
wichtiger Schritt.

###### Exkurs: var, final und const

Relativ häufig erinnert uns der Linter daran, dass wir unsere Variablen als 
`final` deklarieren sollen. Ebenso häufig wird er uns später daran erinnern, 
dass wir ein Widget mit `const` markieren sollen. Was ist damit gemeint?

Für den Rechner ist es mehr Arbeit, wenn er bei einer Variablen dafür sorgen 
muss, dass der Wert sich auch ändern kann. Daher nehmen wir ihm Arbeit ab, 
wenn wir ihm sagen, dass eine Variable sich nicht ändern wird. Dabei gibt 
es zwei Stufen.

Eine Variable ist `const`, wenn Ihr Wert schon dann feststeht, wenn wir den 
Code schreiben. Wenn wir beispielsweise `var a = 2` schreiben und diesen 
Wert nie ändern, dann ist es eigentlich sogar eine Konstante. Denn uns ist 
klar, dass der Wert 2 ist und immer sein wird, solange wir das Programm 
nicht umschreiben. Der Wert ist also schon zur Compilezeit feststehend.

Eine Variable ist `final` wenn Ihr während das Programm läuft ein für uns bei 
der Programmierung nicht vorhersagbarer Wert zugewiesen wird und sich dieser 
danach nicht mehr ändert.

Im Endeffekt kann man das alles weg lassen, aber es optimiert die Geschwindigkeit, 
wenn wir möglichst häufig `final` und `const` einsetzen. Beispielsweise 
weiß der Rechner bei einem Neurendern der GUI, dass ein Widget-Zweig, der nur 
konstante Widgets enthält, nicht neu gezeichnet werden muss.

#### Schritt A.3: Der Block

Als nächstes habe ich mich dem Block zugewendet. An jeder Position sitzt 
später ein Block und der hat ebenfalls Informationen, die ihm zugeordnet sind. 
Im ersten Schritt habe ich nur diese Informationen erstmal abgebildet.

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

  /// List of all neighboring blocks. Convenience getter, so that we do not
  /// have to implement the same logic whenever we need that information
  List<Block> _neighbors(Map<Position, Block> map) {
    final list = <Block>[];
    if (map[Position(_position.x + 0, _position.y + 1)] != null) list.add(map[Position(_position.x + 0, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 1)] != null) list.add(map[Position(_position.x + 1, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 0)] != null) list.add(map[Position(_position.x + 1, _position.y + 0)]!);
    if (map[Position(_position.x + 1, _position.y - 1)] != null) list.add(map[Position(_position.x + 1, _position.y - 1)]!);
    if (map[Position(_position.x + 0, _position.y - 1)] != null) list.add(map[Position(_position.x + 0, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y - 1)] != null) list.add(map[Position(_position.x - 1, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y + 0)] != null) list.add(map[Position(_position.x - 1, _position.y + 0)]!);
    if (map[Position(_position.x - 1, _position.y + 1)] != null) list.add(map[Position(_position.x - 1, _position.y + 1)]!);
    return list;
  }

  /// Updates the count of mines within the neighboring fields
  void updateCloseMines(Map<Position, Block> map) {
    _neighbors(map).forEach((block) {
      if (block.mine) _closeMines++;
    });
  }
}
```

Wieder ist der Part eigentlich verdaubar. Was geschieht?
- Jeder Block hat eine Position (private) und zudem die folgenden Eigenschaften 
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
  ist wieder für die GUI interessant und ist daher mit einem Getter versehen. Sie 
  wird aber ausschließlich von der Klasse selbst verwaltet, daher hat sie keinen 
  Setter.
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
nicht durch die Argumentenliste gehandhabt wurde.

Wenn man übrigens keinen Body (3) benötigt, kann man stattdessen einfach ein 
Semikolon setzen, was hier getan wurde.

So, und dann sind da noch zwei Methoden, die auch erst einen Ticken später 
geschrieben wurden, als die Spielfeld-Klasse geschrieben war, und die tatsächlich 
was mit dem Spiel zu tun haben. Zuerst muss man sich vergegenwärtigen, dass 
mehrfach im Spiel ein Block mit seinen Nachbarn interagieren muss. Einmal dann, 
wenn er die Anzahl der Minen im Umfeld berechnen muss. Dann muss er gucken, welcher 
Nachbar eine Mine hat. Und das andere mal, hier noch nicht implementiert, wenn er 
selbst geöffnet wird. Wenn nämlich der Block eine 0 Minen in der Umgebung hat, dann 
deckt er auch alle seine Nachbarn auf, die wiederum ihre Nachbarn aufdecken, so sie 
auch 0 Minen im Umfeld haben. In beiden Fällen ist es sinnvoll, nicht jedesmal 
den langen Block zu schreiben nach dem Motto "mein Nachbar oberhalb, der oben rechts, 
der rechts, der unten rechts, der....", sondern das einmal zu tun und deswegen 
habe ich eine Methode geschrieben, die einfach eine Liste aller Nachbarblöcke 
produziert. Das macht die anderen beiden Methoden schlanker. Gucken wir uns den 
Code an:
```
  List<Block> _neighbors(Map<Position, Block> map) {
    final list = <Block>[];
    if (map[Position(_position.x + 0, _position.y + 1)] != null) list.add(map[Position(_position.x + 0, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 1)] != null) list.add(map[Position(_position.x + 1, _position.y + 1)]!);
    if (map[Position(_position.x + 1, _position.y + 0)] != null) list.add(map[Position(_position.x + 1, _position.y + 0)]!);
    if (map[Position(_position.x + 1, _position.y - 1)] != null) list.add(map[Position(_position.x + 1, _position.y - 1)]!);
    if (map[Position(_position.x + 0, _position.y - 1)] != null) list.add(map[Position(_position.x + 0, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y - 1)] != null) list.add(map[Position(_position.x - 1, _position.y - 1)]!);
    if (map[Position(_position.x - 1, _position.y + 0)] != null) list.add(map[Position(_position.x - 1, _position.y + 0)]!);
    if (map[Position(_position.x - 1, _position.y + 1)] != null) list.add(map[Position(_position.x - 1, _position.y + 1)]!);
    return list;
  }
```
Zuerst zur Deklaration der Methode. Die Methode hat einen Rückgabewert vom Typ 
List<Block>, also eine Liste von Blöcken. Sie heißt _neighbors. Der Unterstrich 
macht sie wieder private, sie ist also nicht von außerhalb der Klasse aufzurufen. 
Die Methode basiert darauf, dass man ihr eine map aller Positionen im Spiel 
als Parameter übergibt. Eine Map ist eine Zuordnung von Werten zu anderen 
Werten. Eine typische Liste sieht zum Beispiel so aus:
```
 var a = {
  "name": "Andreas",
  "hobby": "Programmieren",
  "partner": "Mariia",
  "hund": "Lizy"
};
```
Ich denke man erkennt das System. Das wäre eine Map<String, String>, weil jedem 
String (links) ein anderer String (rechts) zugeordnet ist. Wenn man wissen sollte, 
wie mein Hund heißt, müsste man dann folgendermaßen vorgehen:
```
var b = a["hund"];
```
Man fragt also nach der Zuordnung zu dem String "hund" in der Map.

Unsere Map, die wir bekommen werden, ist eine Map, wo jeder Position ihr 
jeweiliger Block zugeordnet ist. Die kommt aus der Field-Klasse, insofern brauchen 
wir uns nicht zu tief damit beschäftigen.

Dann wird eine Liste namens list als Variable definiert. Das kann man entweder 
manchen wie bei der Methodendeklaration, also man könnte schreiben
```
final List<Block> list = [];
```
Dann meckert aber der Linter, weil er nicht will, dass wir den Typ hinschreiben. 
Die gewählte Variante `final list = <Block>[];` hingegen gefällt dem Linter. 
Das `[]` zeigt dem Linter es ist eine Liste, aber sie ist noch leer.

Die nächsten Zeilen prüfen jeweils, ob es für die rechnerisch berechnete Nachbar-Position 
einen Block gibt. Wenn die Position außerhalb des Spielfelds liegt, wird es keinen 
Block dort geben, insofern müssen wir diese Fälle nicht gesondert abfangen. Wenn 
es keinen Eintrag in der Map gibt, dann gibt es da keinen Block. Wenn es einen gibt, dann 
wird unsere Nachbarn-Liste um einen Eintrag ergänzt. Das sind also maximal 8 Einträge. 
Das Hinzufügen zur Liste geschieht über list.add.

Dem aufmerksamsten aller Leser mag sich die Frage stellen, wieso wir Einträge einer 
Liste hinzufügen dürfen, obwohl die Liste doch `final` ist. Hier verweise ich 
nochmal auf Ausführungen zuvor: Eine Variable enthält in der Regel nicht die 
Werte selbst, sondern nur eine Referenz auf diese Werte. Wenn wir einer Liste 
einen Wert hinzufügen, dann verändern wir diese Referenz nicht. Insofern ist 
das `final`-kompatibel. Was hingegen nicht geht, wäre eine neue Liste zu erstellen, 
jetzt mit allen Elementen der alten Liste plus der neue Eintrag. Das wäre eben 
eine neue Liste und damit eine neue Referenz.

#### Schritt B.4: Das Spielfeld

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
ein bisserl mehr. Argumente schenke ich mir diesmal

###### Zu den Konstruktoren

Ich habe einen mehr oder weniger leeren Konstruktor angelegt. Das ist nur 
nötig, weil ich aus Gründen des State Management, mit denen wir uns im nächsten 
Kapitel beschäftigen werden, schon beim Starten der App einen State haben muss.
Das repräsentiert also sozusagen ein 0-Spielfeld.

Dann gibt es zwei weitere Konstruktoren. Dart erlaubt beliebig viele Konstruktoren 
für eine Klasse, wobei die sich durch einen Punkt und dann eine 
Namensergänzung unterscheidbar sind. Man kann also entweder ein mehr oder 
weniger leeres Spielfeld erstellen (Standard-Konstruktor) oder mit einigen 
Argumenten ein vernünftiges Spielfeld (Field.withArguments, wobei ich fürchte, 
dass das falsches Englisch war, aber nun ist es zu spät, um das umzsuchreiben). 

Außerdem haben wir die Möglichkeit geschaffen, alle Feinheiten zu kontrollieren. 
Dafür wurde ein Konstruktor geschaffen, mit dem man quasi alles bestimmen kann. Dieser 
dient uns in der copyWith-Methode, zu der wir nun kommen.

###### copyWith

Diese Art der Funktion ist bei State Management mit sogenanntem immutable State 
wichtig. Auch wenn wir darauf nochmal zu sprechen kommen werden, sei die 
Grundlage zumindest erähnt: Der State ist der Gesamtstatus der App (ggf. kann 
eine App auch mehrere Teil-States haben, aber so komplex ist diese App nicht). 
Das Grundproblem sind die Updates der GUI, wenn sich der State ändert. Und ganz 
klassisch gibt es zwei, logisch nachvolziehbare, Ansätze:
- **Mutable State**: Der State kann sich verändern. Pausenlos schreiben irgendwelche 
Methoden Änderungen in den State. Durch pausenlose Überwachung wird immer wieder 
der Jetzt-Status des State mit dem letzten Status des State verglichen. Wenn es eine 
Änderung gab, wird die GUI geupdated.
- **Immutable State**: Der State ändert sich nie. Stattdessen ist eine Änderung 
des States in echt die Instanziierung eines komplett neuen States. Dieser ist 
dann wahrscheinlich meistens dem alten State ähnlich (also nur eine kleine 
Änderung), aber programmatisch gesehen ist er ein komplett neues Objekt.

Die copyWith-Methode erzeugt eine Kopie des jetzigen States mit Abweichungen. Wenn 
wir also beispielsweise eine Zeile haben wie
```
state = state.copyWith(gameLost: true);
```
dann führt das dazu, dass der Variablen state ein neuer Wert zugewiesen wird. Dieser 
neue Wert ist eine Kopie des alten States, nur eben mit einem veränderten Attribut.

Gucken wir uns die copyWith-Methode ruhig im Detail an:
```
  Field copyWith({Map<Position, Block>? map, int? mines, int? numRows, int? numCols, bool? gameLost, bool? flagMode}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? this.mines,
        numRows: numRows ?? this.numRows,
        numCols: numCols ?? this.numCols,
        gameLost: gameLost ?? this.gameLost,
        flagMode: flagMode ?? this.flagMode,
      );
```
Die Fragezeichen bei den Argumenten sagen, dass hier auch `null`-Werte übergeben 
werden können. Wenn wir kein Argument angeben, dann sind das jeweils `null`-Werte. 
Unser Beispiel-Methodenaufruf mit dem gameLost-Attribut übergibt eben für jede 
Variable den Wert `null`, bis auf die Variable gameLost, der gibt sie den Wert 
true.

Die Funktion ist kurz und übergibt uns direkt per `=>` ihren Rückgabewert. Dieser 
ist ein neu konstruiertes Field-Objekt (ein neuer State), und hier übergeben wir 
jedem Attribut prinzipiell die Variablen, die wir bei unserem Funktionsaufruf 
bekamen. Wenn es aber `null`-Werte sind, wird stattdessen der aktuelle Wert des 
Attributs in `this` (diesem) Objekt übergeben. In der Wirkung führt das dazu, dass 
bei obigem Funktionsaufruf `state.copyWith(gameLost: true) also ein neues 
Field-Objekt erstellt wird und dieses Objekt bekommt als Attrubute:
- Eine Map. Da wir keine Map übergeben haben beim Methodenaufruf, ist der Wert der 
Variablen `null`. Wenn der Wert aber `null` ist (das macht der `??`-Operator, er 
fragt, ob der Wert `null` ist), dann wird stattdessen der Wert unseres Attribus 
map übergeben. Im vorliegenden Fall wird also der gegenwärtige Wert von map in das 
neue Field-Objekt übernommen.
- Selbiges passiert bei allen anderen Werten ebenso - bis auf gameLost. Hier 
springt der `??`-Operator nicht an, denn der Wert `true` ist ja nicht `null`.

#### Nochmal zu dem Konstruktor Field.withArguments

Kommen wir noch zu diesem Code. Das ist ja der Konstruktor, der nicht irgendwelchen 
Dummy-Kreationen zu Beginn geschuldet ist und auch nicht dem Konstruieren eines 
Objektes im Zuge des State Managament. Hier geht es wirklich um das Generieren 
eines neuen Spielfelds. Lasst uns diesen Code erstmal erneut anschauen:

```
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
```

Gehen wir wieder alles von oben an durch:
- Der Konstruktor (mit benannten Parametern) erfordert, dass man ihm sagt, wie 
groß das Spielfeld sein soll (numRows, numCols). Außerdem muss man ihm sagen, 
wie viele Minen das Spielfeld enthalten soll.
- gameLost und flagMode werden dann im Nachgang auf false gesetzt, noch während 
das Objekt nicht instanziiert wurde. Damit sind alle Attribute des Objekts 
definiert, bevor der eigentliche Body des Konstruktors läuft, so wie das bei 
`final`-Attributen in einer immutable-Klasse gefordert ist - bis auf die map. 
Um die Map zu generieren, brauchen wir Informationen aus den anderen Feldern und 
daher können wir die Map erst im Body definieren. Das führt dazu, dass wir bei 
der Attribitsdeklaration das Keyword `late` hinzufügen mussten. Das heißt 
übersetzt "ja, dieser Wert kommt später. Ich übernehme die Verantwortung dafür, 
dass der Wert auf jeden Fall initialisiert wurde - und zwar nicht auf `null`, 
gib mir nur etwas Zeit".
- Dann legen wir mit `final newMap = <Position, Block>{};` eine neue Map an, also 
eine Zuordnung von Werten zu anderen Werten, hier wird Positionen jeweils ein 
Block zugeordnet. Das ist die Map, mit der wir uns schon im letzten Abschnitt 
beschäftigt haben.
Wir richten uns zwei Felder ein, `leftMines` (für die Anzahl der noch zu platzierenden 
Minen im Spielfeld, was logischerweise mit der Anzahl der Minen beginn) und 
`leftFields` (für die Anzahl der noch zu instanziierenden Blöcke, was logischertweise 
am Anfang die Anzahl der Spalten mal die Anzahl der Zeilen ist).
- Mit `final rng = math.Random();` instanziieren wir einen Zufallszahlengenerator, 
der aus der math-Bibliothek von dart kommt (siehe Imports am Anfang der Datei). 
Da die Math-Bibliothek auch eine Logarithmus-Funktion enthält und diese mit 
log bezeichnet ist, ich aber ein Freund der log-Funktion (aus der developer-
Bibliothek von Dart) bin, die Logausgaben im Debugmodus produziert, sind 
log-Befehle nicht mehr eindeutig definiert. Aus diesem Grund wurde beim 
Import der math-Bibliothek diese mit dem Begriff math assoziiert und hier 
wird dann jedem Verweis auf die Bibliothek ein `math.` vorangestellt. Das ist 
einfach eine Reaktion auf eine Fehlermeldung, als ich auch log-Ausgaben in der 
Klasse hatte.
- Danach starten zwei ineinander verschachtelte Schleifen. Die erste zählt 
die Variable `col` hoch und produziert soviele Durchgänge wie es Spalten gibt.
- Die zweite zählt die Variable `row` hoch und produziert so viele Durchgänge 
wie es Reihen gibt.
- Bei einer solchen Verschachtelung gilt: Die äußere Schleife läuft mneinetwegen 
10mal und bei jedem dieser 10 Durchgänge läuft die innere Schleife dann auch 
10mal. Insgesamt gibt es also 100 Durchgänge.
- In jedem dieser Durchgänge gilt dann:
  - Wir definieren mit `final pos = Position(col, row);` die dem Schleifendurchlauf 
  entsprechende Position, also von (0/0) bis (Anzahl Spalten -1 / Anzahl Zeilen - 1).
  - Wir errechnen eine Wahrscheinlichkeit dafür, dass der nächste Block eine Mine 
  enthält. Die Formel sorgt dafür, dass die Wahrscheinlichkeit ansteigt oder sinkt, 
  je nach dem Zahlenverhältnis zwischen Minen und Restfeldern. Mal vereinfacht:
    - Wenn wir nur noch 5 Felder übrig haben, aber wir haben auch nur noch 5 
    Felder zu definieren, dann ist die Wahrscheinlichkeit 100 Prozent, dass das 
    nächste Feld eine Mine ist.
    - Wenn wir noch 5 Felder zu zeichnen haben, aber wir haben schon soviele 
    Minen platziert wie wir platzieren sollten, dann ist die Wahrscheinlichkeit 
    für eine nächste Mine 0%.
    - Das dient dazu, dass am Ende wirklich genau so viele Minen platziert wurden , 
    wie sie anfangs festgelegt wurden.
  - Wir würfeln dann eine Zahl aus zwischen 0 und 99 (.nextInt(100) platziert nie 
  die 100, sondern eben 0 bis 99, zufällig).
  - Wenn wir kleiner würfeln als die Wahrscheinlichkeit für eine Mine ist, dann 
  wird im nächsten Feld eine Mine platziert.
  - Unserer Map `newMap` fügen wir jetzt jeweils einen neuen Eintrag hinzu, also 
  die Zuordnung der Position (die sich aus der Schleife ergibt) zu einem 
  Block, den wir in diesem Moment auch instanziieren, mit Mine oder ohne, je 
  nach vorherigen Berechnungen.
  - Wenn wir eine Mine platziert haben, wird die Anzahl der noch zu reduzierenden 
  Minen um eins reduziert.
  - Generell wird mit jedem Durchgang ein Block instanziiert, also reduziert sich 
  die Anzahl der noch zu generierenden Blöcke um 1.
- Nach der Schleife gehen wir dann die Map durch. Und für jeden Eintrag, den wir 
ja produziert haben, wird dem zugehörigen Block mitgeteilt, dass er bitte die 
Anzahl der Minen um sich herum aktualisiert. Das kann erst jetzt passieren, nachdem 
die Map erstmal gefüllt wurde, weil erst jetzt auch alle Blöcke schon vorhanden sind.
- Zum Schluss wird dem Klassenattribut map die neue Map zugewiesen. Sie ist also 
`late` initialisiert worden und ist nicht `null`, womit dann auch alles okay ist.


## Lange Rede, kurzer Sinn
Wir haben jetzt einen Zwischenstand erreicht, bei dem die Daten einigermßan passen, 
aber die App kann noch nicht viel, wie folgender Screenshot beweist. :-)

![](https://github.com/AUSoftAndreas/students/raw/dev/wiki/flutter/minesweeper01.png)