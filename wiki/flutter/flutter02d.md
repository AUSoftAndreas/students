### Wie dieses Tutorial funktioniert

Der Code führt das Projekt ist weiterhin unter 
[AUSoftAndreas/flutter-minesweeper](https://github.com/AUSoftAndreas/flutter_minesweeper) 
abrufbar. Der für diesen Tutorial-Abschnitt relevante Branch ist 
"step_d". Wechselt auf diesen Branch. 

## Basis

Ich kann gar nicht genug betonen, dass Programmieren immer auch Ausprobieren und 
Experimentieren bedeutet. Man muss nicht für alles einen großen Plan haben. auch 
wenn er oft hilft.

Daher hab ich einiges umgestrickt in diesem Teil des Projektes, einfach weil ich 
mehr über Riverpod lernte - und vor allem lernte, was nicht so funktionierte, wie 
ich es wollte. :-)

## Schritt D.1: Settings

Ich wollte, dass man auswählen kann, wie groß das Spielfeld ist. Aus diversen 
Gründen habe ich mich dazu entschieden, die folgenden drei Settings festzulegen:
- Anzahl der Reihen (rows)
- Anzahl der Spalten (cols)
- Prozentanteil der Minen

Für jeden dieser Werte setzte ich zudem einen Minimal- und Maximalwert fest und 
definierte diese als Konstanten. Alles zusammen kam dann in die Klasse 
`Settings` in `/lib/models/settings.dart`. Um ehrlich zu sein habe ich vorher 
eine Weile versucht, das einfach irgendwie als globale Variablen zu speichern 
und diese per Riverpod zu verwalten - und irgendwie hat es nicht geklappt. 
Allerdings ist das Ergebnis auch besser und übersichtlicher.

Der Code der Klasse ist wenig spektakulär

```Dart
import 'package:flutter/foundation.dart';

@immutable

/// General settings of the app
class Settings {
/*-----------------------------------------------------------------------------\
| Constants                                                                    |
\-----------------------------------------------------------------------------*/
  /// Standard number of columns
  static const stdCols = 10;

  /// Minimum number of columns
  static const stdColsMin = 4;

  /// Maximum number of columns
  static const stdColsMax = 30;

  /// Standard number of rows
  static const stdRows = 10;

  /// Minimum number of rows
  static const stdRowsMin = 4;

  /// Maximum number of rows
  static const stdRowsMax = 30;

  /// Standard percentage of mines on field
  static const stdMinePercentage = 15;

  /// Minimum percentage of mines on field
  static const stdMinePercentageMin = 5;

  /// Maximum percentage of mines on field
  static const stdMinePercentageMax = 50;

/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  final int _rows;

  final int _cols;

  final int _minePercentage;

/*-----------------------------------------------------------------------------\
| Getters / Setters for attributes                                             |
\-----------------------------------------------------------------------------*/
  int get rows => _rows;
  int get cols => _cols;
  int get minePercentage => _minePercentage;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  /// Standard constructor, only constructs a fixed standard game
  const Settings()
      : _rows = stdRows,
        _cols = stdCols,
        _minePercentage = stdMinePercentage;

  /// Internal constructor, used by copyWith method
  const Settings._internal({required int rows, required int cols, required int minePercentage})
      : _rows = rows,
        _cols = cols,
        _minePercentage = minePercentage;

/*-----------------------------------------------------------------------------\
| Methods                                                                      |
\-----------------------------------------------------------------------------*/
  /// Copies the current settings into a new Settings object, changing values in that moment
  Settings copyWith({int? rows, int? cols, int? minePercentage}) => Settings._internal(
        cols: cols ?? _cols,
        rows: rows ?? _rows,
        minePercentage: minePercentage ?? _minePercentage,
      );
}
```
Auch wenn es lang ist ... Es sind wahrlich nicht viele Überraschungen darin. Diesen 
Code solltet Ihr inzwischen weitestgehend verstehen. Bisher haben wir nicht 
mit Konstanten gearbeitet. Es sind festgelegte Werte, die einen Vorteil haben: 
Wenn man sie an diversen Stellen nutzt und dann im Nachhinein doch einen anderen 
Wert festlegt, dann muss man nicht an zig Stellen suchen, wo man noch den falschen 
Wert stehen hat. Alle Informationen liegen hier in der Klasse beisammen. Und wenn 
wir hier den Wert von bspw. `stdMinePercentageMax` ändern, dann ist er überall 
im Code automatisch anders.

Neu dürfte nur sein, dass alle Konstanten ein `static` vorweggestellt bekamen, und 
das ist wieder einen kleinen Ausflug wert.

###### Exkurs: Das static-Keyword

Kernelement der objektorientierten Programmierung ist, dass die Daten und 
Methoden in Klassen definiert werden, aber dann später sich auf Objekte, also 
eine einzelne Instanz dieser Klasse beziehen. Wir legen also beispielsweise fest, 
dass die Klasse `Schueler` in unserer Schulverwaltung ein Attribut `name` beinhaltet. 
Das heißt, dass jeder unserer 2.000 Schüler ein Attribut `name` hat.

Wir könnten aber auch in der Klasse die Information speichern, dass Schüler 
keinen Zugang zur Lehrertoilette haben.

```Dart
static const zugangLehrertoilette = false;
```

Das `static` sorgt dafür, dass diese Information nicht bei den 2.000 Schülern 
jeweils einzeln abgespeichert wird, sondern stattdessen einmal für die gesamte 
Klasse. Auch statische Methoden sind denkbar. Sie dürfen sich dann nicht 
auf das Objekt beziehen, sondern haben eher einen allgemeinen Einsatzzweck.

###### Wieder zurück

Der Rest der Klasse ist ziemlicher Standard. Wieder legen wir einen Konstruktor 
an, der mehr oder weniger ein Standard-Setting-Objekt instanziiert (weil wir 
für Riverpod am Anfang ein Objekt brauchen) und einen Konstruktor, mit dem man 
alle Feinheiten einstellen kann, der aber nur intern genutzt wird im Zusammenhang 
mit der copyWith-Methode. Diese ist analog zu der Methode in `/lib/models/field.dart` 
aufgebaut.

## Schritt D.2: Der Spielstatus

Wir hatten ja bereits den Zustand, dass das Spiel als verloren galt, wenn man 
eine Mine aufdeckte. Mir ist aber bewusst geworden, dass ein Spiel auch 
gewonnen werden kann, und deswegen habe ich diese Informationen zusammengefasst 
und auch hier eine neue Klasse geschaffen. Diese ist aber ein kleiner Sonderfall, 
nämlich eine `enum`. Code:

```Dart
/// Status of game
enum GameStatus {
  /// The game is running
  gameRunning,

  /// The game is over because it is already won
  gameWon,

  /// The game is over because it is already lost
  gameLost
}
```

Tja, überschaubar, nicht wahr? Aber was ist eine Enum? Nun, eine Enum ist 
im Wesentlichen eine Aufzählung von möglichen Werten für etwas. Es hilft dabei, 
klareren Code zu schreiben, denn anstatt sich das beispielsweise als Zahlen 
zu merken (running = 1, verloren = 2, etc.), schreibt man dann einfach Code 
wie `x = GameStatus.gameRunning;`. Man kann dann auch leicht weitere mögliche 
Werte später nachpflegen.

Aufgrund dessen musste ich die Klasse `Field` in `/lib/models/field.dart` 
umschreiben. Hinzu kam noch eine gewisse Strategie, welche Teile der Spiellogik 
ich in `Field` und welche im `FieldNotifier` unterbringe. Das kann man im 
Wesentlichen natürlich handhaben, wie man will. Mein Grundgedanke war aber, dass 
eine Klasse eigentlich die Aufgabe hat, seine eigenen Daten zu verwalten. In 
diesem Zusammenhang fand ich es suboptimal, wenn der `FieldNotifier` dafür 
zuständig ist, zum Beispiel festzulegen, dass jemand gewonnen hat. Wenn die 
Klasse `Field` das nicht selbst verwaltet, dann produziert sie inkonsistente 
Zustände, also beispielsweise ein Spielfeld, bei dem eine Mine aufgedeckt ist, 
dass aber noch `GameStatus.gameRunning` behauptet.

```Dart
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/game_status.dart';
import 'package:minesweeper/models/position.dart';

@immutable

/// Class representing the game field
class Field {
/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  /// A map (associative array), linking each Position to its corresponding block.
  late final Map<Position, Block> map;

  /// Number of mines on the field
  final int _mines;

  /// Percentage of mines on the field
  final int _minePercentage;

  /// Number of rows
  final int _numRows;

  /// Number of columns
  final int _numCols;

  /// The status of the game
  late final GameStatus _gameStatus;

/*-----------------------------------------------------------------------------\
| Getters and Setters for private attributes                                   |
\-----------------------------------------------------------------------------*/
  /// Number of mines on the field
  int get mines => _mines;

  /// Number of rows
  int get numRows => _numRows;

  /// Number of columns
  int get numCols => _numCols;

  /// The status of the game
  GameStatus get gameStatus => _gameStatus;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  /// Constructs a game field for our game
  /// It is an empty field. We just use it for instantiating the game in
  /// lib/notifiers/_notfifiers.dart. It will be reconstructed many times using
  /// the .withArguments constructor.
  Field()
      : map = {},
        _mines = 0,
        _minePercentage = 0,
        _numRows = 0,
        _numCols = 0,
        _gameStatus = GameStatus.gameRunning;

  /// Constructs a game field for our game
  Field.withArguments({required numRows, required numCols, required minePercentage})
      : _numRows = numRows,
        _numCols = numCols,
        _minePercentage = minePercentage,
        _mines = (numRows * numCols * minePercentage) ~/ 100,
        _gameStatus = GameStatus.gameRunning {
    final newMap = <Position, Block>{};
    var leftMines = _mines;
    var leftFields = _numRows * _numCols;
    final rng = math.Random();
    for (var col = 0; col < _numCols; col++) {
      for (var row = 0; row < _numRows; row++) {
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
    required mines,
    required minePercentage,
    required numRows,
    required numCols,
    required gameStatus,
  })   : _minePercentage = minePercentage,
        _mines = mines,
        _numRows = numRows,
        _numCols = numCols {
    _gameStatus = _calculateGameStatus();
  }

/*-----------------------------------------------------------------------------\
| Methods                                                                      |
\-----------------------------------------------------------------------------*/
  /// Returns new Field object, which is a copy of this object, but with
  /// some differences specified when calling this method.
  Field copyWith({Map<Position, Block>? map, int? minePercentage, int? mines, int? numRows, int? numCols, GameStatus? gameStatus}) => Field._internal(
        map: map ?? this.map,
        mines: mines ?? _mines,
        minePercentage: minePercentage ?? _minePercentage,
        numRows: numRows ?? _numRows,
        numCols: numCols ?? _numCols,
        gameStatus: gameStatus ?? _gameStatus,
      );

  GameStatus _calculateGameStatus() {
    var status = GameStatus.gameWon;
    for (var pos in map.keys) {
      final block = map[pos]!;
      if (block.mine && block.open) {
        for (var block2 in map.values) {
          if (block2.mine) {
            block2.open = true;
          }
        }
        return GameStatus.gameLost;
      }
      if (!block.mine && !block.open) {
        status = GameStatus.gameRunning;
      }
    }
    // If the game is won now, we open all fields that are still closed
    if (status == GameStatus.gameWon) {
      for (var block in map.values) {
        if (block.mine && !block.open) block.open = true;
      }
    }
    return status;
  }

/*-----------------------------------------------------------------------------\
| Fake getters                                                                 |
\-----------------------------------------------------------------------------*/
  /// Number of flags set on the field
  int get numberOfFlagsSet {
    var flags = 0;
    map.forEach((pos, block) {
      if (block.flagged) flags++;
    });
    return flags;
  }

  /// Number of flags still to be places
  /// The number is limited to the number of mines on the field
  int get numberOfFlagsLeft => _mines - numberOfFlagsSet;
}
```

Ich habe insgesamt einige Attribute auf private gestellt, die es noch nicht waren. 
Das ist fast immer eine gute Idee. Neu sind eigentlich, bis auf die Implementation 
von GameStatus, nur ein paar Methoden am Ende.

In `_calculateGameStatus()` wird der Status des Spiels berechnet. Das geschieht 
jedesmal, wenn ein neues Field-Objekt durch die copyWith-Methode produziert wird, 
was ja bei jeder Veränderung des Status passiert. Die Logik dieser Methode ist:
- Grundsätzlich gehen wir davon aus, dass das Spiel gewonnen ist .... Ja, das 
war einfacher, als von laufend auszugehen, weil von "gewonnen" aus jeweils einzeln 
Ergebnisse alles verändern. Eine einzige geöffnete Mine ändert den Status auf 
"verloren" und nur ein einziger nicht geöffneter Block ohne Mine setzt das 
Spiel auf "running".
- Wir iterieren über alle Positionen unseres Spielfelds hinweg. Wenn wir eine Mine 
finden, die geöffnet wurde, dann öffnen wir auch alle anderen Minen und werten 
das Spiel als verloren.
- In der gleichen Schleife prüfen wir auch, ob es einen noch nicht geöffneten 
Block gibt. Wenn ja, dann ist das Spiel eben noch nicht beendet.
- Bei einem gewonnen Spiel decken wir zum Schluss auch alle Minen auf.

Im `FieldNotifier` in `lib/notifiers/field_notifier.dart` gab es nicht allzuviel 
Neues:

```Dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/block.dart';
import 'package:minesweeper/models/field.dart';
import 'package:minesweeper/models/game_status.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class FieldNotifier extends StateNotifier<Field> {
  /// Standard constructor
  FieldNotifier() : super(Field());

  /// Creates a new playing field ... just by instantiating a new state
  /// with a new playing field
  void create({required int numRows, required int numCols, required int minePercentage}) {
    state = Field.withArguments(numRows: numRows, numCols: numCols, minePercentage: minePercentage);
  }

  /// Is triggered by users clicking on a certain block in the game (MatchScreen)
  // ignore: avoid_positional_boolean_parameters
  void handleClick(Block block, bool flagMode) {
    if (state.gameStatus != GameStatus.gameRunning) return;
    if (flagMode) {
      block.flagged = !block.flagged;
      state = state.copyWith();
      return;
    }
    if (block.flagged) return;
    if (block.open) return;
    block.reveal(state.map);
    state = state.copyWith();
  }
}
```

Die `create()`-Methode wurde leicht angepasst, weil wir nicht mehr die 
Anzahl der Minen direkt mitgeben, sondern einen Prozentsatz für den Anteil der 
Minen (damit, wenn man später die Spielfeldgröße erhöht, man das Spiel nicht 
automatisch leichter macht).

Die in einem früheren Zustand noch vorhandene Methode `toggleFlagMode()` musste 
weichen, auch aufgrund einer strukturellen Überlegung. Ob wir im FlagMode sind, 
also ob wir Fähnchen setzen statt Blöcke zu öffnen, ist eigentlich eher eine 
GUI-Funktion und sollte dann auch dort verwaltet werden. Warum? Nunja, wenn wir 
zum Beispiel daraus irgendwann eine Windows-Version machen, dann ist es 
wahrscheinlich so, dass wir einfach Rechtsclicks als "Fähnchen setzen" interpretieren, 
und dann macht es wenig Sinn, überhaupt einen FlagMode zu haben bzw. zwischen 
Modi hin und her zu schalten. Viel sinnvoller ist es, wenn die GUI, die ja 
die Klicks mitbekommt, bei jedem einzelnen Klick auch sagt "das war ein FlagMode-Klick" 
(oder eben nicht).

Nur die Methode `handleClick()` ist neu:
- Wenn das Spiel verloren ist oder gewonnen, 
dann zählen weitere Klicks nicht.
- Wenn wir im FlagMode sind, dann flaggen wir 
einen Block.
- Wenn der Block, auf den wir klickten, eine Flagge enthält (und wir nicht im FlagMode 
sind), dann passiert ebenfalls nicht, denn die Fähnchen schützen uns ja vorm 
Bombenclick.
- Ein offener Block wird nicht erneut geöffnet.
- Nur, wenn das alles nicht zutraf, werten wir den Klick und öffnen den Block.

## Schritt D.3: Riverpod (für die Settings)

Nun ging es darum, die Settings, ähnlich wie das Field, prinzipiell immer zur 
Verfügung zu stellen, egal wo wir uns auf irgendwelchen Seiten aufhalten. Hinzu 
kommt, dass die GUI auf Updates der Daten reagiert.

Unsere `Settings`-Klasse bekam daher, ebenso wie das `Field` mit `FieldNotifier` eine 
Br+cke zwischen GUI und Daten - unter dem folgerichtigen Namen `SettingsNotifier` 
in der Datei `/lib/notifiers/settings-notifier.dart`.

```Dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/settings.dart';

/// The FieldNotifier is the connection between GUI and state. All state
/// changes go through FieldNotifier. It extends StateNotifier which handles
/// all GUI updates. Part of Riverpod.
class SettingsNotifier extends StateNotifier<Settings> {
  /// Standard constructor
  SettingsNotifier() : super(Settings());

  void setCols(int cols) {
    state = state.copyWith(cols: cols);
  }

  void setRows(int rows) {
    state = state.copyWith(rows: rows);
  }

  void setMinePercentage(int minePerc) {
    state = state.copyWith(minePercentage: minePerc);
  }
}
```

Die Klasse tut nicht viel, außer eben diese Brücke darzustellen, die man halt 
braucht. Hinzu kommen die Funktionen, mit denen man die Settings-Einstellungen 
verändern kann.

Ebenso wie der `FieldNotifier` war dann auch der `SettingsNotifier` noch als 
globale Variable abzulegen, sodass man auf diesen zugreifen kann. Das 
geschah und geschieht in `lib/notifiers/_notifiers.dart`. Ja, das ist aus 
dem Tutorial für Riverpod, das habe ich mir auch nicht ausgedacht. :-)

```Dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/notifiers/field_notifier.dart';
import 'package:minesweeper/notifiers/settings_notifier.dart';

/// Global variable holding a reference to our state object
final globFieldNotifier = StateNotifierProvider((ref) => FieldNotifier());

/// Global variable holding a reference to an int indicating number of columns in the game
final globalSettingsNotifier = StateNotifierProvider((ref) => SettingsNotifier());
```

Die Änderungen im MatchScreen könnt Ihr Euch angucken, sie sind nicht allzu spannend:
- Überall, wo wir uns zuvor auf das `Field`-Attribut "gameLost" bezogen, mussten 
wir auf die Enum GameStatus umstellen.
- Ob die Buttons für FlagMode und Restart rechts oder unterhalb vom Spielfeld 
platziert werden, ist jetzt abhängig von der Bildschirmorientierung.
-  Der FlagMode wird jetzt lokal in der GUI verwaltet (siehe oben). Dabei kommt 
wieder Riverpod zum Einsatz, wobei das nur ein simpler true/false-Wert ist.
- Entsprechend geben wir den gegenwärtigen Zustand des FlagMode nun bei jedem 
Klick in den FieldNotifier.
- Wenn wir "reload" drücken, dann wird das neue Spielfeld nun anhand unserer 
Settings dimensioniert, nicht mehr mit immer-gleichen Standardwerten.

## Schritt D.4: Der Willkommensbildschirm und Sliders
Für den `StartScreen` in `/lib/ui/start_screen.dart` gilt, dass wir endlich 
weg kommen von dem leeren Bildschirm mit dem einen traurigen Button. Und weil 
die langen Codes eines Flutter-Bildschirms abschreckend sind, gehen wir auch 
diesen schrittweise durch:

```Dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:minesweeper/models/settings.dart';
import 'package:minesweeper/notifiers/_notifiers.dart';

/// Welcome Screen for the app
class StartScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final fieldNotifier = useProvider(globFieldNotifier);
    final settingsNotifier = useProvider(globalSettingsNotifier);
    final settings = useProvider(globalSettingsNotifier.state);
```

Mehr oder weniger aus Tutorial geklaute Zugriffe auf die State-Objekte mittels 
Riverpod, sodass wir sie dann hier verwenden können.

```Dart
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter-Minesweeper')),
```

Ein [Scaffold-Widget](https://api.flutter.dev/flutter/material/Scaffold-class.html) 
baut einen Standard-Bildschirm mit Titelseite und Body und, wenn man das will, 
auch mit Drawer-Menu und Fußleiste etc.

```Dart
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.vertical,
          children: [
            const Text(
              'Spiel-Einstellungen',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
```

Wie man sieht, kann man bei einem Text mittels TextStyle-Objekt noch einiges 
mehr an Einstellungen vornehmen.

```Dart
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Anzahl Reihen: ${settings.rows}'),
            ),
```

Hier wird erstmals auf den State zugegriffen.

```Dart
            Slider(
              value: settings.rows.toDouble(),
              min: Settings.stdRowsMin.toDouble(),
              max: Settings.stdRowsMax.toDouble(),
              label: 'Reihen: ${settings.rows}',
              onChanged: (newValue) {
                settingsNotifier.setRows(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Anzahl Spalten: ${settings.cols}'),
            ),
            Slider(
              value: settings.cols.toDouble(),
              min: Settings.stdColsMin.toDouble(),
              max: Settings.stdColsMax.toDouble(),
              label: 'Spalten: ${settings.cols}}',
              onChanged: (newValue) {
                settingsNotifier.setCols(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text('Minen-Anteil(%): ${settings.minePercentage} %'),
            ),
            Slider(
              value: settings.minePercentage.toDouble(),
              min: Settings.stdMinePercentageMin.toDouble(),
              max: Settings.stdMinePercentageMax.toDouble(),
              label: 'Minen-Anteil: ${settings.minePercentage} %',
              onChanged: (newValue) {
                settingsNotifier.setMinePercentage(newValue.toInt());
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: ElevatedButton(
                child: const Text(
                  'Spiel starten',
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  fieldNotifier.create(numRows: settings.rows, numCols: settings.cols, minePercentage: settings.minePercentage);
                  Navigator.pushNamed(context, '/match');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

Wie man sieht, werden hier drei Slider produziert und mit den Settings-Werten 
verknüpft.

## Fazit vorerst
Auch wenn man noch viel Feintuning machen kann, ist dieses Tutorial fürs Erste 
beendet. Danke allen, die es durchgestanden haben. :-)

















Dadurch, dass der FieldNotifier sozusagen die Schnittstelle zwischen GUI und 
Daten darstellt, ist hier die meiste Game-Logik untergebracht. Fangen wir hier 
an. Wir haben ja schon einige Elemente der FieldNotifier-Klasse durchgesprochen
und deswegen konzentrieren wir uns jetzt hier auf einzelne Methoden.

```
  /// Handles click events from GUI.
  void handleClick(Block block) {
    if (state.gameLost) return;
    if (block.open) return;
    if (state.flagMode) {
      block.flagged = !block.flagged;
      state = state.copyWith();
      return;
    }
    if (block.flagged) return;
    block.reveal(state.map);
    if (block.mine) {
      state.map.forEach(
        (pos, block) {
          if (block.mine) block.open = true;
        },
      );
      state = state.copyWith(gameLost: true);
      return;
    }
    state = state.copyWith();
  }
```

Diese Methode wird von der GUI ausgelöst, wann immer wir auf einen Block im 
Spielfeld klicken. Einfache Logik:
- Wenn das Spiel schon verloren ist, dann haben die Klicks keine Wirkung mehr.
- Wenn der Block schon geöffnet wurde, hat ein weiterer Klick keine Wirkung mehr.
- Wenn wir im FlagMode sind, dann stellen wir einfach nur per Klick den Flag-Mode 
um.
- Wenn wir NICHT im FlagMode sind, aber auf dem gegenwärtigen Block eine Flagge 
klebt, dann passiert nichts bei einem Click.
- Danach wird der Block aufgedeckt durch Aufruf einer Methode des Blocks.
- Nach dem Aufdecken wird geprüft, ob es sich um eine Mine deckte, die da 
aufgedeckt wurde. Wenn ja, dann werden ALLE Minen aufgedeckt. Außerdem ist das 
Spiel verloren.

Immer bedenken .. Wir haben diese `state = ???`-Anweisungen, in denen ja 
jeweils ein neuer State (meistens per `copyWidth`-Methode des alten States) 
deklariert wird. Diese Zeilen sind es, die jeweils die GUI updaten lassen.

Die einzige Funktion, die in FieldNotifier aufgerufen wird, mit der wir uns 
noch nicht beschäftigt haben, ist die reveal-Methode der Block-Klasse. Gucken 
wir uns also auch diese an.

```
  /// Reveals (opens) this block. If this block has no mines in its neighboring
  /// fields, it will reveal its neighbors too.
  void reveal(Map<Position, Block> map) {
    if (open) return;
    open = true;
    if (mine) return;
    if (closeMines == 0) {
      _neighbors(map).forEach((block) {
        if (!block.open) {
          block.reveal(map);
        }
      });
    }
  }
```

Ziemlich simple Mechanik. Prinzipiell führt die Methode dazu, dass der Block 
geöffnet wird. Wenn es sich um ein Feld mit dem Minen-drumherum-Wert 0 handelt, 
dann werden auch alle Nachbarn aufgedeckt. Ausnahme: Da technisch auch 
Minen den Wert "0 Minen im Umfeld" haben können, werden Minenfelder zuvor 
ausgenommen.

In ersten Versuchen mit dieser Art des Aufdeckens produzierte ich eine Endlosschleife, 
weil ein Feld seine Nachbarn aufdeckte, aber jeder von diesen Nachbarn auch wieder 
seine Nachbarn aufdecken wollte und da dann unendlich oft Blöcke sich gegenseitig 
aufforderten, einander zu revealen. Jetzt ist klar, dass die Öffnung des Feldes 
zuerst erfolgt und DANN die Nachbarn geprüft werden. Das heißt der Block, der 
den Prozess startete, startet ihn nicht erneut, weil er ja dann beim nächsten 
Durchgang schon open ist.

## Was noch fehlt

Im nächsten Schritt des Tutorials geht es ans Feintuning:
- Gewinnbedingung: Es muss festgestellt werden, ob der User schon gewonnen hat. 
Wenn ja, dann muss das Spiel abbrechen (und gratulieren).
- Möglichkeit, das Spiel mit selbst bestimmter Höhe / Breite / Minendichte 
zu spielen.
- StartScreen streichen ... Ich denke er ist nicht notwendig. Wir können auch 
direkt ins Spiel starten.
- Optische Feinheiten.

Aber so im Wesentlichen bin ich schon ganz zufrieden mit dem Zustand. :-)