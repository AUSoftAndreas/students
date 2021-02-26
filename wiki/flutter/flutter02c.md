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
    if (field.numCols == 0) {
      return _buildRestart(fieldNotifier);
    }
    return Material(
      child: Container(
        color: field.gameLost ? Colors.red[700] : Colors.grey[300],
        height: height,
        child: Flex(
          direction: orientation == Orientation.landscape ? Axis.horizontal : Axis.vertical,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: field.numCols,
                children: _buildBlocks(field, fieldNotifier),
              ),
            ),
            Flex(
              direction: Axis.vertical,
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
          ],
        ),
      ),
    );
  }

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

  Material _buildRestart(FieldNotifier fieldNotifier) => Material(
        child: Container(
          color: Colors.grey[300],
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.replay),
              iconSize: 50,
              onPressed: () {
                fieldNotifier.create(numRows: 10, numCols: 10, mines: 20);
              },
            ),
          ),
        ),
      );
}
```

