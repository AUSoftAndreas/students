### Wie dieses Tutorial funktioniert

Der Code führt das Projekt ist weiterhin unter 
[AUSoftAndreas/flutter-minesweeper](https://github.com/AUSoftAndreas/flutter_minesweeper) 
abrufbar. Der für diesen Tutorial-Abschnitt relevante Branch ist 
"step_d". Wechselt auf diesen Branch. 

## Schritt D.1: Erste Elemente der Game-Logik

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