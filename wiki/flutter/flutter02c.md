### Wie dieses Tutorial funktioniert

Der Code führt das Projekt ist weiterhin unter 
[AUSoftAndreas/flutter-minesweeper](https://github.com/AUSoftAndreas/flutter_minesweeper) 
abrufbar. Der für diesen Tutorial-Abschnitt relevante Branch ist 
"step_c". Wechselt auf diesen Branch. 

## Schritt C.1: Einiges Drumherum

Wir bekommen in dieser Lektion endlich eine GUI. Das heißt, dass wir wirklich 
etwas sehen und dann natürlich auch an der Game Logik arbeiten können.

Eine Voraussetzung ist aber noch zu schaffen: Wir müssen den neuen Screen auch 
erreichen können. Zuerst gilt es, in der main.dart eine neue Route für den 
neuen Screen anzulegen.

```
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:minesweeper/ui/match_screen.dart';
import 'package:minesweeper/ui/start_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

/// This class is the central class of the app, it starts everything else
class MyApp extends HookWidget {
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => StartScreen(),
        '/match': (context) => MatchScreen(),
      },
      initialRoute: '/',
    );
  }
}
```
Neu ist nur, dass jetzt zwei Routes definiert sind.

Und wenn wir auf diesen IconButton auf unserem StartScreen klicken, wollen wir 
zum Spiel kommen (es muss aber auch ein Spiel vorbereitet werden). Das heißt, 
dass wir hier zum ersten Mal wirklich Riverpod nutzen und uns auf diesem Weg 
Kontrolle über den State geben.

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';

/// StartScreen of the app
class StartScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    return Material(
      child: Container(
        child: Center(
          child: IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () {
              fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
              Navigator.pushNamed(context, '/match');
            },
          ),
        ),
      ),
    );
  }
}
```

Dank Provider bekommen wir durch die einfache Zeile `final fieldNotifier = useProvider(globFieldNotifier);` Zugriff 
auf das zuständige FieldNotifier-Objekt. Den brauchen wir im onPressed des IconButtons. 
Durch den Aufruf der Methode `Navigator.pushNamed(context, '/match');` wechseln 
wir den Screen zum Match-Screen. Der Navigator ist ein durch Flutter bereitgestelltes 
Tool, mit dem wir durch die App navigieren können.

## Schritt C.2: Der Match-Screen

Nun kommt Euer erster wirklich umfangreicher Flutter-Screen und er wird Euch 
erschlagen auf den ersten Blick. Bleibt dabei und versucht, Euch nach und 
nach einzufinden in den Code.

Wir machen das hier ausnahmsweise abschnittsweise:

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';
import 'package:minesweeper/models/position.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';

/// Central GUI Screen. Represents a playing field and handles user input
class MatchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    final field = useProvider(globFieldNotifier.state);
    final height = MediaQuery.of(context).size.height * 0.8;
    final width = MediaQuery.of(context).size.width;
    final max = height > width ? width : height;
    final orientation = MediaQuery.of(context).orientation;
```

Die Klasse heißt MatchScreen und wie das bei Riverpod üblich ist, ist es ein 
HookWidget. Das ermöglicht uns, über die Methode `useProvider()` jeweils auf den 
von uns definierten FieldNotifier und auf seinen State, also das Field zuzugreifen. 
Das wurde ja gesagt, dass das die zentrale Aufgabe von Riverpod ist. Wie das 
erreicht wird, kann uns prinzipiell egal sein. Das sind also nur aus der 
Anleitung abgeschriebene Codezeilen.

Danach beziehen wir Höhe und Breite des Bildschirms (bzw. Fenster) in Pixeln. 
Diese Angaben verwenden wir später beim Aufbau. Auch hier: Wann immer man sowas 
braucht, googelt man dann "flutter find out screen size". Mittels ternärem Operator 
(also die "a ? b : c"-Operation) legen wir fest, was die größere der beiden 
Auflösungen ist und wir merken uns die gegenwärtige Orientierung des Geräts 
(das ist entweder Portrait oder Landscape).

Und nun kann die GUI-Definition beginnen:

```
    return Material(
      child: Container(
        color: field.gameLost ? Colors.red[700] : Colors.grey[300],
        height: height,
```

Das [Material-Widget](https://api.flutter.dev/flutter/material/Material-class.html) 
wurde von diversen anderen Widgets ausdrücklich verlangt (per Fehlermeldung). Was 
es macht, kann man nachlesen. Ich verstehe es so, dass den Look der GUI beeinflusst.

Danach kommt ein Container. Dieser Container umfasst im Prinzip unsere gesamte 
GUI. Die Breite ist automatisch auf die Bildschirmbreite gesetzt. Die Höhe habe 
ich manuell auf die oben festgelegte Höhe beschränkt. Der Container wird grau gefärbt, 
wenn das Spiel läuft, und rot, wenn das Spiel verloren ist. Der Container ist 
eigentlich unser Hintergrund für den Bildschirm.

```
        child: Flex(
          direction: orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
          children: [
```

Innerhalb unseres Hintergrund-Containers wird dann ein 
[Flex-Widget](https://api.flutter.dev/flutter/widgets/Flex-class.html) gesetzt. 
Ein Flex-Widget ist im Wesentlichen eine Art, andere Widgets entweder vertikal 
(untereinander) oder horizontal (nebeneinander) anzuordnen. In diesem Fall machen 
wir die Richtung abhängig von der Orientierung des Geräte. Sind wir im Landscape-Modus, 
dann werden wir die folgenden Elemente nebeneinander anorden, sonst übereinander.

Man beachte: Ein Flex-Widget hat nicht, wie die meisten Widgets, ein Child, 
sondern mehrere Children. Das ist ja auch sinnig, wenn man drüber nachdenkt: 
Wenn das Flex-Widget Widgets unter- oder nebeneinander anordnet, dann muss 
es dazu auch mehr als ein Widget habe. Das Flex-Widget hat noch ein paar 
Besonderheiten, aber im Wesentlichen verhält es sich wie entweder eine Spalte 
oder eine Zeile, je nachdem wie das Attribut direction festgelegt wurde.

Da es mehrere Kinder sein können, wird hinter "children" nicht direkt das 
nächste Objekt instanziiert, sondern die eckigen Klammern heißen eindeutig: Jetzt 
folgt eine Liste von Elementen. Direkte Kinder des Flex sind folglich alle 
Elemente der Liste auf der nächsten Ebene in Sachen Einrückung.

```
            Expanded(
              child: GridView.count(
                crossAxisCount: field.numCols,
                children: _buildBlocks(field, fieldNotifier),
              ),
            ),
            Flex(
              direction: orientation == Orientation.landscape ? Axis.vertical : Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: field.flagMode ? Colors.green : Colors.transparent,
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.flag),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.toggleFlagMode();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
                      },
                    ),
                  ),
                ),
              ],
            ),
```

Das ist zwar viel Code, aber wenn Ihr genau guckt, dann erkennt Ihr, dass unser 
Flex direkt zwei Kinder hat. Das eine ist der Expanded-Block, das andere ist 
ein erneuter Flex-Block. Alles andere sind wiederum Nachkommen dieser Widgets.

Wenden wir uns diesen beiden Blöcken einzeln zu.

#### Der Expanded-Block im Flex # 1

```
            Expanded(
              child: GridView.count(
                crossAxisCount: field.numCols,
                children: _buildBlocks(field, fieldNotifier),
              ),
            ),
```

Ein [Expanded-Widget](https://api.flutter.dev/flutter/widgets/Expanded-class.html) 
sorgt dafür, dass sein Child innerhalb eines Flex-Layouts den maximal verfügbaren 
Platz einnimmt und entsprechend alle anderen Children des Flex nur noch den 
jeweils minimalen Platz, den sie halt benötigen, bekommen. Wir wollen also 
VIEL Platz für das, was danach kommt und das ist hier ein 
[GridView-Widget](https://api.flutter.dev/flutter/widgets/GridView-class.html). 
Ein GridView ist ein Gitter von Elementen, ganz ähnlich dem CSS-Grid, das Ihr 
auch schon kennt. Sprich: Die nachfolgenden Elemente sortieren sich in 
Spalten und Zeilen ein. Wir haben für unser GridView einen besonderen Konstruktor 
genutzt (wir erinnern uns daran, dass man in Dart mehrere Konstruktoren 
definieren kann, mit dem Klassennamen und dann ein Punkt, genau wie hier). 
Der GridView.count-Konstruktor erlaubt uns, unser Layout allein mit Hilfe eines 
crossAxisCount-Attributs festzulegen.

Da stellt sich die nächste Frage ... Was ist ein crossAxisCount? Grundsätzlich, 
an vielen Stellen, unterscheidet Flutter zwischen der MainAxis (Hauptachse) und 
der CrossAxis (Querachse). Das hängt vom Umfeld ab. Einem Grid kann man sagen, 
in welche Richtung es bei Bedarf (also sehr viele Widgets) scrollen soll. 
Standard ist, dass ein Grid von oben nach unten scrollt. Die MainAxis ist nun 
gleichzusetzen mit der Scroll-Richtung. Und die CrossAxis ist die Achse, die 
quer zur Scroll-Richtung liegt. Unser GridView scrollt von oben nach unten, also 
ist die CrossAxis von links nach rechts. Mit crossAxisCount teilen wir dem 
GridView einfach mit, wie viele Items es nebeneinander darstellen soll. Und wie 
viele Items nebeneinander sollen es sein? So viele wie es Spalten in unserem 
Spielfeld gibt.

Die Items selbst übergeben wir normalerweise einfach als Liste im children-Attribut, 
so wie bei dem Flex auch. Hier gehen wir einen anderen Weg, indem wir einfach 
eine Funktion namens _buildBlocks aufrufen, die dann die entsprechenden Widgets, 
eines für jedes Element unseres GridViews produziert.

Anstatt jetzt streng weiter von oben nach unten im Code uns zu bewegen, folgen 
wir jetzt mal diesem Funktionsaufruf und schauen uns die Funktion _buildBlocks an.

```
  List<Widget> _buildBlocks(Field field, FieldNotifier fieldNotifier) {
    final widgets = <Widget>[];
    for (var row = field.numRows - 1; row >= 0; row--) {
      for (var col = 0; col < field.numCols; col++) {
        final block = field.map[Position(col, row)];
        if (block != null) {
          widgets.add(
            InkWell(
              onTap: () {
                fieldNotifier.handleClick(block);
              },
              child: _buildBlock(block),
            ),
          );
        }
      }
    }
    return widgets;
  }
```

_buildBlocks ist eine private Methode, also nicht von außerhalb unserer Klasse 
aufrufbar. Damit wir Zugriff auf das Spielfeld bzw. den FieldNotifier haben, lassen 
wir uns diese als Argumente mitgeben. Der Rückgabewert von _buildBlocks ist eine 
List von Widgets - und das passt ja auch zu dem Punkt, an dem wir die Funktion 
aufgerufen haben. Wir waren ja innerhalb des children-Attributs von GridView, also 
waren wir an einer Stelle, wo ja eine Liste von Widgets verlangt wird.

Okay, was macht _buildBlocks nun? Es baut wieder zwei verschachtelte Schleifen und 
produziert so jede mögliche Adresse auf unserem Spielfeld. Da unser GridView zwar 
von links nach rechts die Items gerne hätte, aber eben auch von oben nach unten, 
gleichzeitig unsere Art der Nummerierung von Positionen aber zwar von links nach 
rechts, zugleich aber von unten nach oben verläuft (wir hatten Zeile 0 als die 
unterste Zeile definiert), müssen wir die row-Schleife etwas anders als gewohnt 
ausbauen.

Wenn wir also eine Position generiert haben, dann prüfen wir anhand der Map in 
unserer Field-Instanz, ob zu dieser Position in unserem Field ein Block existiert. 
Wenn einer existiert, dann erweitern wir unsere Liste von Widgets, die wir 
am Ende returnen um ein [InkWell-Widget](https://api.flutter.dev/flutter/material/InkWell-class.html). 
Ein InkWell-Widget empfängt Clicks (bzw. Bildschirm-Tappen) und sorgt dafür, dass 
der User ein optisches Feedback darauf erhält, indem eine Art Tintenklecks auf 
dem darunter liegenden Widget angezeigt wird (kurz nur) und das Widget kurz 
aufgehellt wird. Außerdem können wir noch eine Funktion hinterlegen, die das 
beinhaltet, was geschehen soll, wenn jemand klickt.

In unserem Fall sagen wir, dass die Methode `handleClick` des FieldNotifiers 
aufgerufen werden soll und wir melden ihm, in welchem Block das geschah. Das 
Child des InkWell ist also das Objekt, was man eigentlich sieht (ein InkWell 
ist sozusagen unsichtbar, solange nicht geklickt wurde). In unserem Fall wurde 
das produzieren dieses Inhalts wieder ausgelagert an eine weitere Methode 
_buildBlock, die für jeden einzelnen Block aufgerufen wird. Folgen wir auch 
hier weiter der Logik.

```
  Widget _buildBlock(Block block) {
    var color = Colors.transparent;
    if (block.open && !block.mine) {
      color = Colors.white;
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
      ),
      child: FittedBox(
        child: Center(
          child: _buildBlockCenter(block),
        ),
      ),
    );
  }
```

Für jeden Block läuft diese Funktion einmal. Zuerst wird eine Farbe festgelegt 
auf transparent, aber wenn der Block bereits geöffnet wurde und da keine 
Mine liegt, dann wird die Farbe auf weiß umgestellt. Wo nutzen wir die Farbe?

Nun, letztlich returnen wir aus dieser Funktion eine
[Container-Widget](https://api.flutter.dev/flutter/widgets/Container-class.html). 
Dieser Container hat als "decoration" ein [Box-Decoration](https://api.flutter.dev/flutter/painting/BoxDecoration-class.html). 
Das ist ein Weg, um einem Container mehr Optik zu verleihen. Man kann hier 
Farben definieren, aber eben auch Rahmen und dergleichen. Wir verleihen ihm 
einen Rahmen auf allen Seiten. Der Container bekommt außerdem die zuvor 
festgelegte Farbe.

In dem Container (als child) ist dann wiederum ein 
[FittedBox-Widget](https://api.flutter.dev/flutter/widgets/FittedBox-class.html). 
Ein FittedBox-Widget sorgt dafür, dass sein Child gegebenenfalls gedehnt oder 
gestaucht wird, um in die Box zu passen. Nit anderen Worten: Egal, welche 
Icons oder Texte wir nun da rein schreiben... Sie werden so skaliert, dass 
sie den Block füllen.

Für den Fall, dass der Inhalt nicht exakt passt, wird er zudem mit dem 
[Center-Widget](https://api.flutter.dev/flutter/widgets/Center-class.html) innerhalb 
des Feldes zentriert. Was genau da zentriert wird, haben wir erneut in eine 
Methode ausgelagert, nun namens _buildBlockCenter.

```
  Widget _buildBlockCenter(Block block) {
    var color = Colors.black;
    if (block.flagged) {
      return const Icon(Icons.flag);
    } else if (!block.open) {
      return const Text('');
    } else if (block.mine) {
      return const Text('M');
    } else {
      if (block.closeMines <= 2) {
        color = Colors.green;
      } else if (block.closeMines <= 4) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      return Text(
        block.closeMines == 0 ? '' : block.closeMines.toString(),
        style: TextStyle(
          color: color,
        ),
      );
    }
  }
```

Es wird wieder eine Standardfarbe (schwarz) festgelegt. Eigentlich passiert 
hier nichts Komplexes mehr... Je nachdem, wie der Status des Feldes ist 
(geflagged, geöffnet, mit Mine oder ohne und Anzahl der Minen im Umfeld 
wird irgendwas in den Block geschrieben.

Zusammengenommen ist das oberste Expanded-Widget also dafür zuständig dafür, dass 
gesamte Spielfeld darzustellen.

#### Flex 2 in Fex 1

Kommen wir zurück zum Anfang. Wir hatten also ein Flex, das mal in Längs- und 
mal in Querrichtung läuft, je nach Handy-Orientierung. Konzentrieren wir uns 
mal auf den Landscape-Modus. Dann ist das Flex horizontal aufgebaut. Links wäre 
unser zuvor besprochenes Expanded-Widget, was das eigentliche Spielfeld 
darstellt, wie wir uns gerade erarbeitet haben.

Rechts davon wäre jetzt ein erneutes [Flex-Widget](https://api.flutter.dev/flutter/widgets/Flex-class.html). 
Wir wissen schon, dass ein Flex-Widget eine Art Zeile oder Spalte definiert, in 
der mehrere Widgets übereinander oder nebeneinander platziert werden. Ob über- oder 
nebeneinander ergibt sich aus dem Attribut direction. Hier machen wir es 
wieder von der Orientierung des Geräts abhängig. Wenn wir im Landscape-Modus sind, dann 
haben wir also links das Spielfeld und daneben eine Spalte mit meherern Elementen 
untereinander. Im Portrait-Modus haben wir oben das Spielfeld und darunter eine 
Zeile mit mehreren Elementen.

```
            Flex(
              direction: orientation == Orientation.landscape ? Axis.vertical : Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,

```

Durch das Zusammenspiel von MainAxisSize.min und MainAxisAlignment erreichen wir, 
dass die Elemente in unserer Spalte/Zeile eng beieinander gehalten und in der 
Mitte der Zeilen / Spalte gehalten werden.

Kommen wir abschließend zu dem, was da unter- oder nebeneinander dargestellt 
werden soll.

```
            Flex(
              direction: orientation == Orientation.landscape ? Axis.vertical : Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: field.flagMode ? Colors.green : Colors.transparent,
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.flag),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.toggleFlagMode();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(max > 500 ? max * 0.05 : 25),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.replay),
                      iconSize: max > 500 ? max * 0.1 : 50,
                      onPressed: () {
                        fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
                      },
                    ),
                  ),
                ),
              ],
            ),
```
Beide children sind ähnlich aufgebaut. Erst kommt ein 
[Padding-Widget](https://api.flutter.dev/flutter/widgets/Padding-class.html). 
Ein Padding-Widget produziert einfach Abstand zu anderen Objekten, ähnlich wie 
das Padding im CSS. Padding ist ringsherum (um das Child) mindestens 50 Pixel 
groß und wächst danach in Abhängigkeit von der ScreenSize.

Innerhalb des Paddings ist wieder ein altebkanntes Container-widget. Der Container 
hat eine Linie außenrum und im Falle des ersten Buttons wird er grün 
eingefärbt, falls man sich derzeit im flag-Modus befndet.

Innerhalb des Container sitzt dann ein [IconButton-Widget](https://api.flutter.dev/flutter/material/IconButton-class.html), 
einmal mit einem Flagge-Icon und einmal mit einem Reload-Icon. Außerdem wurde 
jeweils eine Funtion unterlegt, die ausgeführt wird, wenn man den entsprechenden 
Button drücktt.

## Spiel-Logik

Im nächsten Teil des Tutorials kümmern wir uns um die Spiellogik. So ein bisschen 
ist die ja schon angeklungen, weil die GUI stellenweise Methoden des FieldNotifiers 
aufgerufen hat, die wir noch nicht besprochen haben.