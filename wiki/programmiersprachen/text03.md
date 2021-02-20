# Weitere grundlegende Konzepte

## Schleifen
Wir wissen, dass der Computer besser und schneller rechnen kann als jeder Mensch, 
aber es gibt etwas, wo der Abstand zwischen Mensch und Computer noch größer ist: 
**Immer wieder die selbe Tätigkeit verrichten, ohne Abweichung, ohne Müdigkeit, 
ohne Flüchtigkeitsfehler!**

Eine Schleife bedeutet, dass die gleiche Sequenz von Anweisungen immer wieder 
durchlaufen wird. Das ist also etwas, was dem Computer sehr entgegen kommt.

#### Ausstiegsbedingung / Fortführungsbedingung

Jede Schleife braucht eine Ausgangsbedingung. Ansonsten wäre es eine Endlosschleife 
und Endlosschleifen sind normalerweise eine verdammt schlechte Idee. Viele Sachen 
sind mögliche Ausstiegsbedingungen. Relativ häufige Beispiele sind:
- Der Computer soll Datensätze aus einer Datenbank auslesen, bis er mit allen 
Durchsätzen durch ist.
- Der Computer soll eine Datei Zeile für Zeile einlesen, bis er am Ende der 
Datei angelangt ist.
- Der Computer soll eine bestimmte Operation genau 8.357mal durchführen.
- Der Computer soll eine Operation so oft durchführen, bis das Ergebnis eine 
bestimmte Genauigkeit hat.
- Der Computer soll etwas so lange tun bis der Benutzer eine Eingabe getätigt hat.

In der Regel gilt: Die Ausstiegsbedingung kann als boolsche Bedingung formuliert 
werden, also die Bedingung liegt entweder vor oder nicht (true oder false). 
Die Umkehrung der Ausstiegsbedingung ist die Fortführungsbedingung. Sprich: Wenn 
kein Grund vorliegt, die Schleife abzubrechen, dann liegt offensichtlich ein 
Grund vor, die Schleife fortzusetzen. Beide Varianten gibt es, also dass eine 
Schleife entweder eine Ausstiegsbedingung oder eine Fortführungsbedingung 
benötigt und darauf muss man ein wenig achten.

#### Schleifentypen

Kommen wir nun zu den häufigen Schleifentypen:

###### for-Schleife

Die folgende Art, eine Schleife zu konstruieren, hat sich so durchgesetzt, dass 
im Prinzip keine Programmiersprache ohne diesen Schleifentyp auskommt:

```
  for (var x = 0; x < 1000; x++) {
    // Tu etwas wiederholt
  }
  // Weiter gehts nach der Schleife
```

Die for-Anweisung hat drei durch Semikolons getrennte Elemente:
  ```
  for (Initialisierung; Fortführungsbedingung; Schrittabschluss)
  ```
  - Initialisierung: Die Operation, die **vor** allen Schleifendurchläufen 
  durchgeführt wird. In der Regel wird hier, wie in dem Beispiel eine Variable 
  auf ihren Ausgangswert gesetzt. Das von mir benutzte var-Keyword zeigt, dass 
  die Variable direkt in der Schleife erst initialisiert wird. Wenn Euch x nach 
  dem Schleifendurchgang weiterhin zur Verfügung stehen soll als Wert, dann 
  müsst Ihr x vor der Schleife definieren. Wir haben gelernt, dass Variablen 
  einen Scope haben und in dieser Variante von mir ist der Scope der Variable 
  lediglich die Schleife selbst. x existiert nicht mehr nach der Schleife.
  - Fortführungsbedingung: **Vor dem ersten Durchgang und vor jedem weiteren 
  Durchgang** wird geprüft, ob diese Bedingung true ergibt. Wenn dem so ist, 
  dann wird die Schleife einmal durchlaufen.
  - Schrittabschluss: Nach dem Schleifendurchlauf wird diese Anweisung ausgeführt, 
  bevor die nächste Prüfung auf einen erneuten Schleifendurchlauf erfolgt.

  Der obige Code ist die häufigste Form einer solchen Schleife. x startet mit 0 
  und wird nach und nach hochgezählt bis 999 (also insgesamt 1.000 Durchläufe, da 
  x mit jedem Durchgang um 1 erhöht wird). Durch kreative Verwendung der Elemente 
  lassen sich dann andere Konstellationen abbilden:
  -  Alle ungeraden Zahlen unter 1000
    ```
    for (var x = 1; x < 1000; x = x + 2) {
      // Tu was
    }
    ```
  - Zahlen von -100 bis -200, in dieser Reihenfolge
    ```
    for (var x = -100; x >= -200; x--) {
      // Tu was
    }
    ```
  - Abbruch aufgrund der Erzielung eines bestimmten Ergebnisses anstatt aufgrund 
  einer bestimmten Zählvariable
    ```
    var ergebnis = 'noch nicht';
    for (var x = 0; ergebnis != 'jetzt aber'; x++) {
      // Tu was, was unter bestimmten Umständen dann ergebnis auf 'jetzt aber' setzt
    }

    // Dieses Vorgehen ist aber eigentlich ungünstig, selbst eine solche Schleife 
    // sollte also die maximale Anzahl von Schritten begrenzen, um keine 
    // Endlosschleife zu produzieren
    var ergebnis = 'noch nicht';
    for (var x = 0; ergebnis != 'jetzt aber' && x < 10000; x++) {
      // Tu was, was ggf. ergebnis auf 'jetzt aber' setzt
    }

    // Und selbst hier ist es besser, mit einem Schleifenabbruch zu arbeiten, 
    // dazu gleich mehr.
    ```
Wie man sieht ist die Schleifentyp sehr flexibel und lässt sich an die eigenen 
Bedingungen anpassen.

###### while-Schleife / Kopfgesteuerte Schleife

Die while-Schleife ist eine sogenannte Kopfgesteuerte Schleife. Das heißt, dass 
vor jedem Schleifendurchlauf geprüft wird, ob die Fortführungsbedingung noch 
vorliegt. Für die for-Schleife galt ähnliches.  Die for-Schleife ist eher dann 
anzuwenden, wenn die Anzahl der Durchläufe direkt zu Beginn der Schleife festliegt, 
zum Beispiel durch die Anzahl der Werte in einem Array. Die while-Schleife ist 
eher auf eine unbestimmte Anzahl von Durchläufen hin ausgelegt.

```
var ergebnis = 'noch nicht';
while (ergebnis == 'noch nicht') {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert.
}
```

Auch hier bietet es sich in der Regel an, eine Zählvariable zu nutzen, um 
Endlosschleifen dann wenigstens irgendwann abzubrechen.

```
var ergebnis = 'noch nicht';
var zaehler = 0;
while (ergebnis == 'noch nicht' && zaehler < 10000) {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert.
  zaehler++;
}
```

###### do-while-Schleife / Fußgesteuerte Schleife

do-while ist ähnlich aufgebaut. Der Unterschied ist nur, dass der Schleifeninhalt 
zumindest einmal durchlaufen wird, weil die Fortführungsbedingung erst am Ende 
der Schleife geprüft wird.

```
var ergebnis = 'noch nicht';
do {
  // Tu etwas, was ggf. den Wert der Variablen ergebnis verändert
} while (ergebnis == 'noch nicht');
```

#### Kontrollbefehle

In den meisten Sprachen gibt es darüber hinaus die Möglichkeit, aus der Schleife 
heraus das weitere Verhalten der Schleife zu beeinflussen, insbesondere:
- die Anweisung `break;`, ausgelöst irgendwo in der Schleife, führt dazu, dass 
die Schleife abgebrochen wird.
  ```
  for (var x = 0; x < 1000; x++) {
    if (bedingungFuerVorzeitigenAusstiegLiegtVor) {
      break;
    }
  }
  ```
  Diese Schleife stoppt schon vor Ablauf der 1.000 Durchläufe, wenn die 
  Ausstiegsbedingung vorliegt.
- die Anweisung `continue;`, ausgelöst irgendwo in der Schleife, führt dazu, dass 
der Rest des Schleifenkörpers übersprungen wird, dann aber weiter gemacht wird 
mit der Schleife. Angenommen wir wollen jede durch 3 glatt teilbare Zahl überspringen:
  ```
  for (var x = 0; x < 1000; x++) {
    if (x % 3 == 0) {
      continue;
    }
    // Tue Sachen mit x, die NICHT durch 3 teilbar sind
  }
  ```

## Hauptprogramm

Wenn ein Projekt etlichen Code umfasst, dann muss dem Computer klar sein, wo 
er mit dem Ausführen eines Programms anfangen soll. In vielen Programmiersprachen 
ist das die sogenannte main-Funktion.
- In einer Dart-Anwendung ist dem so.
  ```
  void eineFunktion() {
    // Etwas passiert
  }

  void main() {
    // Hier wird das Programm starten
  }

  void andereFunktion() {
    // Etwas passiert
  }
  ```
  - Eine main-Funktion (in unseren Apps wird diese sich auch in lib/main.dart befinden) 
  muss nicht zwingend viel tun. In einer typischen App sorgt sie für die Initialisierung 
  einiger Variablen und öffnet den ersten Screen.
- In Javascript ist das etwas anders: Der Code, der eingebunden wird in eine HTML-Seite, 
egal ob als externe Datei oder einfach in einem `<script>`-Tag, läuft automatisch ab, 
wenn er nicht in Funktionen verpackt ist. Daher wird auf diesem Level, also unverpackt 
in Funktionen in der Regel lediglich festgelegt, dass anderer Code zum Beispiel laufen 
soll, wenn die HTML-Seite vollständig geladen ist.

## Funktionen

In allen mir bekannten Programmiersprachen kann man Funktionen definieren. Funktionen 
sind einfach Code-Sequenzen, die ausgelagert sind aus dem Hauptprogramm und die 
entweder vom Hauptprogramm oder von anderen Funktionen aufgerufen werden.

#### Rückgabewerte

Funktionen können entweder einfach etwas tun - oder sie produzieren einen Rückgabewert, 
den die aufrufende Codestelle dann weiter verwenden kann. Beide Konzepte gehen Hand in 
Hand, also es könnte beispielsweise auch sein, dass eine Funktion in erster Linie etwas 
tut und dann zum Beispiel per Rückgabewert meldet, dass sie erfolgreich tat, was sie 
tat. Wenn man einen Rückgabewert von einer Funktion erwartet, dann verfährt man beim 
Aufruf so, als wäre die Funktion eine Variable. Man kann sie einer anderen Variable 
zuweisen oder direkt auswerten. Der Rückgabewert wird in der Regel per `return` zurück
an die aufrufende Codestelle gegeben. Die Anweisung `return` beendet sofort den Code 
der Funktion!

###### Rückgabewert-Typ: Definition vorab

In den meisten Sprachen muss ich den Rückgabewert der Funktion bei der Funktionsdefinition 
bereits festlegen. Der Rückgabewert muss in der Regel einem der Variablentypen, 
die in der Programmiersprache angeboten werden, entsprechen. Wenn kein Rückgabewert 
von der Funktion zurück gegeben wird, dann wird als Rückgabetyp in der Regel als 
void angegeben. Typische Funktionsdefinitonen sehen daher so aus:

```
int gibZahl() {
  return 13;
}

bool gibBool() {
  return true;
}

String gibString() {
  return "Hallo";
}

void tuWas() {
  return; // beendet dann einfach den Code der Funktion
}
```
Da Javascript bei Variablentypen so flexibel ist, ist das hier nicht nötig. Man 
ersetze einfach alle Variablentypen in dem obigen Codeabschnitt durch `function` 
und es funktioniert dann auch dort.

#### Funktionsargumente

Manche (die meisten) Funktionen werden durch Argumente so flexibel gehalten, dass 
sie in verschiedenen Zusammenhängen genutzt werden können. Nehmen wir uns eine 
sehr simple Funktion vor, die 1 und 2 addiert und das Ergebnis 3 zurück gibt an 
die aufrufende Stelle.

```
void main() {
  var x = addiere1Und2(); // Funktionsaufruf
  var y = addiere3Und4(); 
  log(x); // gibt 3 aus
  log(y); // gibt 7 aus
}

int addiere1Und2() {
  return 1 + 2; // ergibt 3 als Rückgabewert
}

int addiere3Und4() {
  return 3 + 4;
}
```

Durch Argumente werden wir flexibel:

```
void main() {
  var x = addiere(1,2); // Funktionsaufruf
  var y = addiere(3,4); 
  log(x); // gibt 3 aus
  log(y); // gibt 7 aus
}

int addiere(int zahlX, int zahlY) {
  return zahlX + zahlY; // ergibt einfach die Summe als Rückgabewert
}
```

In den meisten Sprachen müssen wir die Typen der Argumente, wie bei jeder 
Variablen festlegen. Ausgenommen ist wieder Javascript mit seinen flexiblen 
Variablentypen. Dort lässt man dann die Variablentypen weg. Das hat dann 
den Nachteil, dass niemand meckert, wenn man aus Versehen einen String in die 
Funktion gibt. Im Gegenteil:

```
  // Irgendwo im Code
  var x = addiere(1,2); // Funktionsaufruf
  var y = addiere('Hallo','Welt'); 
  console.log(x); // gibt 3 aus
  comsole.log(y); // gibt 'HalloWelt' aus
}

function addiere(zahlX, zahlY) {
  return zahlX + zahlY; // ergibt einfach die Summe als Rückgabewert
}
```

Der typische Aufruf einer void-Funktion, die also keinen Rückgabewert produziert, 
ist auch mehr oder weniger selbsterlklärend:

```
void main() {
  eineVoidFunktion(); // Lässt die Funktion durchlaufen
  // und weiter geht's
}

void eineVoidFunktion() {
  // Tu etwas
}
```

Natürlich kann auch eine void-Funktion Argumente haben.

```
void main() {
  eineVoidFunktion('Text'); // Lässt die Funktion durchlaufen, gibt 'Text' aus
  // und weiter geht's
}

void eineVoidFunktion(String text) {
  log(text);
}
```

###### Optionale Argumente

Nicht in jedem Fall muss die aufrufende Codestelle jedes Argument wir gewünscht an 
die Funktion übergeben.
- In Javascript gibt es im Prinzip keinerlei Prüfung. Man kann die Funktion aufrufen, 
wie man lustig ist und alle Argumente, welche die Funktion eigentlich fordert, 
ignorieren. Bei der Funktion kommen dann halt einige `undefined` Variablen an, 
was zum Crash führen kann. Wie immer ist Javscript da relativ lax.
- In den meisten Programmiersprachen, inklusive Dart, gibt es fein abgestimmte Regeln 
dafür, welche Funktionsargumente man weglassen kann und welche nicht. Die IDE 
warnt einen dann, wenn der eigene Funktionsaufruf nicht zur Funktionsdefinition 
passt. Beispiele für solche Feinbestimmungen:
  ```
  void meineFunktion(int a, int b) {}
  // Zugehöriger Funktionsaufruf
  meineFunktion(3, 4);
  // Der Funktionsaufruf muss ZWINGEND zwei Ganzzahlen übergeben.
  ```
  ```
  void meineFunktion(int a, [int b, int c]) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1,2);
  meineFunktion(1,2,3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu drei
  ```
  ```
  void meineFunktion(int a, [int b = 2, int c = 3]) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1,2);
  meineFunktion(1,2,3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu drei.
  // b und c werden, wenn nichts anderes übergeben wird, automatisch auf 2 und 
  // 3 gesetzt. Also: Alle drei Funktionsaufrufe haben die gleiche Wirkung.
  ```
  ```
  void meineFunktion(int a, {int b, int c}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1, b: 2);
  meineFunktion(1, c: 3);
  meineFunktion(1, b: 2, c: 3);
  // Der Funktionsaufruf muss ZWINGEND eine Ganzzahl beinhalten und bis zu zwei
  // **benannte** Parameter. Neu ist, dass die Reihenfolge egal ist. Es ist also 
  // jetzt möglich, c zu übergeben und b nicht.
  ```
  ```
  void meineFunktion(int a, {int b = 2, int c = 3}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1);
  meineFunktion(1, b: 2);
  meineFunktion(1, c: 3);
  meineFunktion(1, b: 2, c: 3);
  // Wie zuvor, nur dass ebenfalls Standardwerte angegeben sind, mit denen die 
  // Funktion arbeitet, wenn kein anderer Wert übergeben wurde. Insofern haben 
  // alle Funktionsaufrufe die gleiche Wirkung.
  ```
  ```
  void meineFunktion(int a, {required int b, int c = 3}) {}
  // Zugehörige zulässige Funktionsaufrufe
  meineFunktion(1, b: 2);
  meineFunktion(1, b: 2, c: 3);
  // Diesmal ist das benannte Argument b als required (benötigt) gekennzeichnet. 
  // Ein Funktionsaufruf, bei dem b nicht explizit erähnt wurde, ist also unzulässig.
  ```

Mit dieser Vielzahl an Regeln kann man eigentlich für jede Konstellation vorsorgen.

###### Overloading

Manche Sprachen setzen zudem eine Technik ein, die sich function overloading nennt. 
Im Endeffekt läuft es daraufhin hinaus, dass man mehrere Funktionen des gleichen 
Namens definieren kann. Anhand der Anzahl und Variablentypen müssen sich die 
verschiedenen Funktionen aber unterscheiden. Wenn man nun die Funktion aufruft, 
dann hat man die Wahl zwischen den verschiedenen Varianten, bzw. es wird automatisch 
die Funktions-Implementierung gewählt, die zu der Anzahl und Art der übergebenen 
Argumente passt.

Im Bereich der Funktionen ist dieses Prinzip nicht sonderlich verbreitet, hat 
aber eine relativ große Popularität im Bereich der Klassen-Konstruktoren, zu denen 
wir noch kommen werden.